require 'user_engage/client'

RSpec.describe UserEngage::Client do
  describe 'instance methods' do
    let(:token) { 'TestToken' }
    let(:configuration) do
      UserEngage::Configuration.new.tap do |config|
        config.token = token
      end
    end

    subject { UserEngage::Client.new(configuration) }

    describe '#get' do
      before do
        stub_request(:get, 'https://app.userengage.com/api/public/users/search?email=test@example.com')
        subject.get('/users/search', email: 'test@example.com')
      end

      it 'GET to public api with given path and parameters' do
        expect(WebMock).to have_requested(
          :get,
          'https://app.userengage.com/api/public/users/search?email=test@example.com'
        ).with(
          headers: {
            Authorization: "Token #{token}",
            'Content-Type' => 'application/json',
            'User-Agent' => "UserEngage-Ruby/#{UserEngage::VERSION}"
          }
        ).once
      end
    end # describe '#get'

    describe '#post' do
      pending
      it 'POST to public api with given path and parameters'
    end # describe '#post'

    describe '#put' do
      pending
      it 'PUT to public api with given path and parameters'
    end # describe '#put'

    describe '#delete' do
      pending
      it 'DELETE to public api with given path and parameters'
    end # describe '#delete'
  end # describe 'instance methods'
end
