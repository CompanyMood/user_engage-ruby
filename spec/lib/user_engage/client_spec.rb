# frozen_string_literal: true

RSpec.describe UserEngage::Client do
  describe 'instance methods' do
    let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

    let(:configuration) do
      UserEngage::Configuration.new.tap do |config|
        config.token = token
        config.host = 'https://app.userengage.com'
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
      let(:params) { { company_admin: true, company_role: 'employee' } }

      before do
        stub_request(:post, 'https://app.userengage.com/api/public/users/111/set_multiple_attributes')
        subject.post('/users/111/set_multiple_attributes', params)
      end

      it 'POST to public api with given path and parameters' do
        expect(WebMock).to have_requested(
          :post,
          'https://app.userengage.com/api/public/users/111/set_multiple_attributes'
        ).with(
          body: params,
          headers: {
            Authorization: "Token #{token}",
            'Content-Type' => 'application/json',
            'User-Agent' => "UserEngage-Ruby/#{UserEngage::VERSION}"
          }
        ).once
      end
    end # describe '#post'

    describe '#put' do
      let(:params) { { email: 'new@email.de' } }

      before do
        stub_request(:put, 'https://app.userengage.com/api/public/users/111')
        subject.put('/users/111', params)
      end

      it 'PUT to public api with given path and parameters' do
        expect(WebMock).to have_requested(
          :put,
          'https://app.userengage.com/api/public/users/111'
        ).with(
          body: params,
          headers: {
            Authorization: "Token #{token}",
            'Content-Type' => 'application/json',
            'User-Agent' => "UserEngage-Ruby/#{UserEngage::VERSION}"
          }
        ).once
      end
    end # describe '#put'

    describe '#delete' do
      before do
        stub_request(:delete, 'https://app.userengage.com/api/public/users/1/')
        subject.delete('/users/1/')
      end

      it 'DELETE to public api with given path' do
        expect(WebMock).to have_requested(
          :delete,
          'https://app.userengage.com/api/public/users/1/'
        ).with(
          headers: {
            Authorization: "Token #{token}",
            'Content-Type' => 'application/json',
            'User-Agent' => "UserEngage-Ruby/#{UserEngage::VERSION}"
          }
        ).once
      end
    end # describe '#delete'
  end # describe 'instance methods'
end
