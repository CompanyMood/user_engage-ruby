# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<my-test-token>') do
    ENV.fetch('USERENGAGE_API_TOKEN')
  end
  c.hook_into :webmock
end
