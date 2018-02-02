require 'user_engage/user'

RSpec.describe UserEngage::User, vcr: { record: :new_episodes } do
  before do
    UserEngage.config do |config|
      config.token = '<my-test-token>'
    end
  end

  describe '#find' do
    context 'with a valid find attribute' do
      subject { described_class.find(email: 'markus@company-mood.com') }

      it 'returns an UserEngage::User object' do
        expect(subject).to be_a(UserEngage::User)
      end
    end # context 'with a valid find attribute'

    context 'with a not existing user for the given attribute' do
      it 'raises an ResourceNotFoundException exception' do
        expect{ described_class.find(email: 'not-existing@invalid.com') }.
          to raise_error(UserEngage::ResourceNotFoundException)
      end
    end # context 'with a not existing user for the given attribute'

    context 'with an invalid attribute' do
      it 'raises an InvalidFindAttribute exception' do
        expect{ described_class.find(invalid: 'not-valid!') }.
          to raise_error(UserEngage::InvalidFindAttributeException)
      end
    end # context 'with an invalid attribute'
  end # describe '#find
end
