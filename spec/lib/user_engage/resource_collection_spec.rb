# frozen_string_literal: true

RSpec.describe UserEngage::ResourceCollection, vcr: { record: :new_episodes } do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  before do
    UserEngage.config do |config|
      config.token = token
    end
  end

  describe 'instance methods', vcr: { cassette_name: :found_all } do
    subject { UserEngage::User.all }

    describe '#go_next!' do
      context 'there are no more pages (next link is not present)' do
        before { subject.attributes[:next] = nil }

        it 'raises an NoNextPageAvailableException' do
          expect { subject.go_next! }
            .to raise_error(UserEngage::NoNextPageAvailableException)
        end
      end # context 'there are no more pages (next link is not present)'

      context 'there are more pages (next link is present)' do
        it 'should increment current page' do
          expect { subject.go_next! }
            .to change { subject.current_page }.from(1).to(2)
        end

        it 'should request for the next page of results' do
          expect(subject.results.first.id).to eq(111)
          subject.go_next!
          expect(subject.results.first.id).to eq(222)
        end
      end # context 'there are more pages (next link is present)'
    end # describe '#go_next!'

    describe '#go_previous!' do
      context 'there are no more pages (previous link is not present)' do
        before { subject.attributes[:previous] = nil }

        it 'raises a NoPreviousPageAvailableException' do
          expect { subject.go_previous! }
            .to raise_error(UserEngage::NoPreviousPageAvailableException)
        end
      end # context 'there are no more pages (previous link is not present)'

      context 'there are more pages (previous link is present)' do
        before { subject.go_next! } # Setup to be on the page 2 already

        it 'should decrease current page' do
          expect { subject.go_previous! }
            .to change { subject.current_page }.from(2).to(1)
        end

        it 'should request for the previous page of results' do
          expect(subject.results.first.id).to eq(222)
          subject.go_previous!
          expect(subject.results.first.id).to eq(111)
        end
      end # context 'there are more pages (next link is present)'
    end # describe '#go_previous!'

    fdescribe '#each' do
      it 'should iterate through all results (even next pages)' do
        expect do |block|
          subject.each(&block)
        end.to yield_successive_args(
          an_object_having_attributes(id: 111), # Result on first page
          an_object_having_attributes(id: 222) # Result on second page
        )
      end
    end # describe '#each'
  end # describe 'instance methods'
end
