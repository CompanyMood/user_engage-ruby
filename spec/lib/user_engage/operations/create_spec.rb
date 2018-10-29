# frozen_string_literal: true

RSpec.describe UserEngage::User, vcr: { record: :new_episodes } do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  before do
    UserEngage.config do |config|
      config.token = token
    end
  end

  subject { UserEngage::User.create(params) }

  describe '#create' do
    context 'with invalid params' do
      context 'which does not include all required' do
        let(:params) { { invalid: true } }

        it 'should throw an UserEngage::CreateNotSuccessfulException' do
          expect { subject }.to raise_error(
            UserEngage::CreateNotSuccessfulException
          )
        end
      end # context 'which does not exist'

      context 'which exist but invalid value provided' do
        let(:params) do
          {
            email: 'specs@company-mood.com',
            gender: 'invalid'
          }
        end

        it 'should throw an UserEngage::CreateNotSuccessfulException' do
          expect { subject }.to raise_error(
            UserEngage::CreateNotSuccessfulException
          ).with_message(
            '{"errors":{"gender":["\"invalid\" is not a valid choice."]}}'
          )
        end
      end # context 'which exist but invalid value provided'
    end # context 'with invalid params'

    context 'with valid params', vcr: { cassette_name: :created_user } do
      let(:params) do
        {
          email: 'specs@company-mood.com',
          gender: 2
        }
      end

      it 'should create a new resource with the given params' do
        expect(subject.email).to eq('specs@company-mood.com')
        expect(subject.gender).to eq('male')
      end

      it 'should return a new resource instance with ID' do
        expect(subject.id).to be_a(Integer)
      end
    end # context 'with valid params'
  end # describe '#create'
end
