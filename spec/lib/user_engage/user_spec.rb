# frozen_string_literal: true

require 'support/shared_examples/user_examples'

RSpec.describe UserEngage::User, vcr: { record: :new_episodes } do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  before do
    UserEngage.config do |config|
      config.token = token
    end
  end

  describe '#all' do
    subject { described_class.all }

    context 'with an successful request', vcr: { cassette_name: :found_all } do
      it 'should return a resource collection' do
        expect(subject).to be_a(UserEngage::ResourceCollection)
      end

      context 'the resource collection' do
        it 'should have set a base_class' do
          expect(subject.base_class).to eq(UserEngage::User)
        end

        it 'should have the current_page on 1' do
          expect(subject.current_page).to eq(1)
        end

        it 'should have set the correct meta informations' do
          expect(subject.count).to eq(111)
          expect(subject.next).to eq('https://app.userengage.com/api/public/users/?page=2')
          expect(subject.previous).to eq(nil)
        end

        it 'should include the result resources' do
          expect(subject.results).to be_a(Array)
          expect(subject.results.size).to eq(1)
          expect(subject.results.first).to be_a(UserEngage::User)
        end
      end # context 'the resource collection'
    end # context 'with an successful request'
  end # describe '#all'

  describe '#find' do
    context 'with valid find attribute', vcr: { cassette_name: :found_user } do
      subject { described_class.find(email: 'markus@company-mood.com') }

      include_examples 'valid user find request'
    end # context 'with a valid find attribute'

    context 'with valid find attribute', vcr: { cassette_name: :found_user } do
      subject { described_class.find(72130530) }

      include_examples 'valid user find request'

      it 'sets the correct tags' do
        company = subject.companies.first
        expect(company).to be_a(UserEngage::Company)
        expect(company.name).to eq('CompanyMood')
        expect(company.member_since).to eq('2018-01-25T14:30:15.435527Z')
        expect(company.id).to eq(120378)
      end
    end # context 'with a valid find attribute'

    context 'with a not existing user for the given attribute' do
      it 'raises an ResourceNotFoundException exception' do
        expect { described_class.find(email: 'not-existing@invalid.com') }
          .to raise_error(UserEngage::ResourceNotFoundException)
      end
    end # context 'with a not existing user for the given attribute'

    context 'with an invalid attribute' do
      it 'raises an InvalidFindAttribute exception' do
        expect { described_class.find(invalid: 'not-valid!') }
          .to raise_error(UserEngage::InvalidFindAttributeException)
      end
    end # context 'with an invalid attribute'
  end # describe '#find

  describe '#destroy' do
    context 'with a not existing user' do
      let(:user) { described_class.new(id: 99922211) }

      it 'raises an NotExistingResourceException' do
        expect { user.destroy }
          .to raise_error(UserEngage::NotExistingResourceException)
      end
    end # context 'with a not existing user'

    context 'with an existing user' do
      let(:user) { described_class.new(id: 68567127) }

      it 'deletes the user at UserEngage' do
        expect(user.destroy).to be_truthy
      end
    end # context 'with an existing user'
  end # describe '#destroy'
end
