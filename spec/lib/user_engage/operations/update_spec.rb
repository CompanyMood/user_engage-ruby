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
        expect(subject.email).to eq('markus@company-mood.com')
        subject.update(email: 'markus+test@company-mood.com')
        expect(subject.email).to eq('markus+test@company-mood.com')
      end
    end # context 'with existing attribute'
  end # describe '#update_attributes'
end
