# frozen_string_literal: true

require 'support/shared_examples/user_examples'

RSpec.describe UserEngage::User, vcr: { record: :new_episodes } do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  before do
    UserEngage.config do |config|
      config.token = token
    end
  end

  describe '#find' do
    context 'with valid find attribute', vcr: { cassette_name: :found_user } do
      subject { described_class.find(email: 'markus@company-mood.com') }

      include_examples 'valid user find request'
    end # context 'with a valid find attribute'

    context 'with valid find attribute', vcr: { cassette_name: :found_user } do
      subject { described_class.find(72130530) }

      include_examples 'valid user find request'
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
