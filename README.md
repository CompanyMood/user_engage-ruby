# UserEngage [![Build Status](https://travis-ci.org/CompanyMood/user_engage-ruby.svg?branch=master)](https://travis-ci.org/CompanyMood/user_engage-ruby)

This gem implements the ruby bindings for https://user.com (former https://userengage.com)

## Current state
By now, you're able to find and destroy users but functionality is very easy to add, as soon as all [operations](https://github.com/CompanyMood/user_engage-ruby/tree/master/lib/user_engage/operation) are implemented.

Look at [the open todo list](https://github.com/CompanyMood/user_engage-ruby/blob/master/TODO.md) for more details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'user_engage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install user_engage

## Basic Usage

NOTE: It's important to have access to the User.com API package.

First, setup your User.com configuration.
Get yourself an API access token and set the token and your applications
user.com host like

```ruby
UserEngage.config do |config|
  config.token = '<your-access-token-here>'
  config.host = https://<your-custom-subdomain-host>.user.com'
end
```

Then query models or delete them like

```ruby
user = UserEngage::User.find(email: 'markus@company-mood.com')
# => <#UserEngage::User id:12345 email:...>

user.destroy
# => true
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CompanyMood/user_engage-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UserEngage project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CompanyMood/user_engage/blob/master/CODE_OF_CONDUCT.md).
