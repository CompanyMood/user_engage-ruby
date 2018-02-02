RSpec.describe UserEngage do
  it 'has a version number' do
    expect(UserEngage::VERSION).not_to be nil
  end

  it 'is possible to configure UserEngage' do
    UserEngage.config do |config|
      config.token = 'XXX'
    end

    expect(UserEngage.configuration.token).to eq('XXX')
  end
end
