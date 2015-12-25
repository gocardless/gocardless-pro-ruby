# Ruby Client for the GoCardless Pro API

A Ruby client for the GoCardless Pro API. For full details of the GoCardless Pro API, see the [API docs](https://developer.gocardless.com/pro/).

[![Gem Version](https://badge.fury.io/rb/statesman.png)](http://badge.fury.io/rb/gocardless_pro)
[![Build Status](https://travis-ci.org/gocardless/gocardless-pro-ruby.svg?branch=master)](https://travis-ci.org/gocardless/gocardless-pro-ruby)


## Usage Examples

This README will use `customers` throughout but each of the resources in the
[API](https://developer.gocardless.com/pro/) is available in this library.

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'gocardless_pro'
```

And then load it into your application:

```ruby
require 'gocardless_pro'
```

### Initialising the client

The client is initialised with an Access Token.
You can also pass in `environment` as `:sandbox` to make requests to the sandbox
environment rather than production.

```rb
@client = GoCardlessPro::Client.new(
  access_token: ENV["GOCARDLESS_TOKEN"]
)
```

### GET requests

You can get details about one or many resources in the API by calling the
`#get`, `#list` and `#all` methods.

#### Getting a single resource

To request a single resource, use the `#get` method:

```rb
@client.customers.get(customer_id)
```

A call to `get` returns an instance of the resource:

```rb
p @client.customers.get(customer_id).given_name
```

#### Getting a list of resources

To get a list of resources, use the `#list` method:

```rb
@client.customers.list
```

A call to `list` returns an instance of `GoCardlessPro::ListResponse`. You can call `records` on this to iterate through results:

```rb
@client.customers.list.records.each do |customer|
  p customer.given_name
end
```

If you need to pass any options, the last (or in the absence of URL params, the only) argument is an options hash. This is used to pass query parameters for `GET` requests:

```rb
@client.customers.list(params: { limit: 400 })
```

#### Getting all resources

If you want to get all of the records for a given resource type, you can use the
`#all` method to get a lazily paginated list. `#all` will deal with making extra
API requests to paginate through all the data for you:

```rb
@client.customers.all.each do |customer|
  p customer.given_name
end
```

#### Raw response details

In addition to providing details of the requested resource(s), all GET requests
give you access the following properties of the response:

- `status`
- `headers`
- `body`

### POST/PUT Requests

For POST and PUT requests you need to pass in the body in under the `params` key:

```rb
@client.customers.create(
  params: {
    first_name: "Pete",
    last_name: "Hamilton",
    ...
  }
)
```

If any parameters are required they come first:

```rb
@client.customers.update(customer_id, {...})
```

### Handling failures

When the API returns an error, the client will raise a corresponding one. There are four classes of error which could be thrown, allof which subclass `GoCardlessPro::Error`:

- `GoCardlessPro::GoCardlessError`
- `GoCardlessPro::InvalidApiUsageError`
- `GoCardlessPro::InvalidStateError`
- `GoCardlessPro::ValidationError`

These errors are fully documented in the [API documentation](https://developer.gocardless.com/pro/#overview-errors).

All errors have the following methods to facilitate access to information in the API response:

- `#documentation_url`
- `#message`
- `#type`
- `#code`
- `#request_id`
- `#errors`

### Using the OAuth API

The API includes [OAuth](https://developer.gocardless.com/pro/2015-07-06/#guides-oauth) functionality, which allows you to work with other users' GoCardless accounts. Once a user approves you, you can use the GoCardless API on their behalf and receive their webhooks.

OAuth simply provides a means by which you obtain an access token - once you have this access token, you can use this gem as usual.

We recommend using the [oauth2](https://github.com/intridea/oauth2) gem to handle the authorisation process and gain a token. For an example of this in action, see our [open-source OAuth demo app](https://github.com/gocardless/oauth-demo/blob/master/app.rb#L46).

## Supporting Ruby < 2.0.0
The client only supports Ruby >= 2.0.0 out of the box due to our use of
Enumerable::Lazy for lazy loading of paginated API resources.

If you wish to use this gem with a previous ruby version, you should be able to
do so with the [backports](https://github.com/marcandre/backports) gem:

1. Add backports to your Gemfile
   ```gem 'backports'```
2. Require lazy enumerables
   ```require 'backports/2.0.0/enumerable/lazy.rb'```

## Contributing

This client is auto-generated from Crank, a toolchain that we hope to open source soon. For now, issues should be reported on this repository. __Please do not modify the source code yourself, your changes will be overriden!__
