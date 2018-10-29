# frozen_string_literal: true

RSpec.describe UserEngage::User, vcr: { record: :new_episodes } do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  before do
    UserEngage.config do |config|
      config.token = token
    end
  end

  subject do
    VCR.use_cassette(:found_user) do
      UserEngage::User.find(email: 'markus@company-mood.com')
    end
  end

  describe '#update_attributes' do
    context 'with existing attribute' do
      it 'should change the objects instances attribute' do
        expect(subject.attributes[:attributes].last.value).to be(true)
        subject.update_attributes(company_admin: false)
        expect(subject.attributes[:attributes].last.value).to be(false)
      end
    end # context 'with existing attribute'

    context 'with not existing attribute' do
      it 'should set a new attribute on the instance if not found' do
        attribute_finder = lambda do
          subject.attributes[:attributes].find { |a| a.name == 'company_role' }
        end

        expect(attribute_finder.call).to be_nil
        subject.update_attributes(company_role: 'supervisor')
        expect(attribute_finder.call.value).to eq('supervisor')
      end
    end # context 'with not existing attribute'
  end # describe '#update_attributes'
end
