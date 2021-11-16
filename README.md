# RactiveCampaign

Simple wrapper for ActiveCampaign API v3

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ractive_campaign"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ractive_campaign

## Usage

### Config

```ruby
# config/initializers/ractive_campaign.rb

ActiveCampaign.configure do |config|
  config.api_url = ENV["AC_API_URL"] # ex.: https://mystartup.api-us1.com/api/3
  config.api_key = ENV["AC_API_KEY"]
end
```

### Examples

#### Contact

```ruby
# new
harry = ActiveCampaign::Contact.new firstName: "Harry",
                                    lastName: "Potter",
                                    email: "potter.hurray@hogwash.com"
harry.save

# create
hermione = ActiveCampaign::Contact.new firstName: "Hermione",
                                       lastName: "Granger",
                                       email: "mione@drtooth.com"

# update
ron = ActiveCampaign::Contact.create email: "ron1988@hogwash.com", lastName: "Weasley"
ron.firstName = "Ron"
ron.save
```

#### Tag

```ruby
ActiveCampaign::Tag.create tag: "hogwarts"
```

#### Contact tags

```ruby
harry = ActiveCampaign::Contact.find_by email: "potter.hurray@hogwash.com"

# add a contact tag
harry.add_tag "hogwargs"

# remove a tag
harry.remove_tag "hogwarts"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ractive_campaign. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ractive_campaign/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RactiveCampaign project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ractive_campaign/blob/master/CODE_OF_CONDUCT.md).
