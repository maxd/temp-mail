[![Build Status](https://travis-ci.org/maxd/temp-mail.svg?branch=master)](https://travis-ci.org/maxd/temp-mail)

# temp-mail

Ruby client for temp-mail.ru

## Usage

### Get available domain names

```ruby
require 'temp/mail'

client = Temp::Mail::Client.new
p client.available_domains
```

### Get incoming e-mails

```ruby
require 'temp/mail'

client = Temp::Mail::Client.new
p client.incoming_emails
```

[Here](http://api.temp-mail.ru/) is Temp Mail API specification. It describe all fields of e-mail objects in incoming list.

## Contributing

1. Fork it ( https://github.com/maxd/temp-mail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
