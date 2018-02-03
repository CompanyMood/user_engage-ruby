RSpec.describe UserEngage do
  let(:token) { ENV.fetch('USERENGAGE_API_TOKEN') }

  it 'has a version number' do
    expect(UserEngage::VERSION).not_to be nil
  end

  it 'is possible to configure UserEngage' do
    described_class.config do |config|
      config.token = token
    end

    expect(described_class.configuration.token).to eq(token)
  end

  describe '#client' do
    subject { described_class.client }

    it 'returns a client object' do
      expect(subject).to be_a(UserEngage::Client)
    end
  end # describe '#client'
end
