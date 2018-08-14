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

      it 'returns an UserEngage::User object' do
        expect(subject).to be_a(UserEngage::User)
      end

      it 'sets the Users correct id' do
        expect(subject.id).to eq(2913134)
      end

      it 'sets the correct attributes' do
        attribute = subject.attributes[:attributes].first
        expect(attribute).to be_a(UserEngage::Attribute)
        expect(attribute.id).to eq(286104)

        expect(attribute.name).to eq('created_at')
        expect(attribute.name_std).to eq('created_at')
        expect(attribute.value).to eq('2015-03-13 11:45:35')
        expect(attribute.description).to eq(
          'When has that user been created? (Self or invited)'
        )
      end

      it 'sets the correct lists' do
        list = subject.lists.first
        expect(list).to be_a(UserEngage::List)
        expect(list.name).to eq('General list')
        expect(list.id).to eq(12342)
        expect(list.description).to eq('A first list')
      end

      it 'sets the correct tags' do
        tag = subject.tags.first
        expect(tag).to be_a(UserEngage::Tag)
        expect(tag.name).to eq('CompanyMood team member')
        expect(tag.id).to eq(9827)
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
