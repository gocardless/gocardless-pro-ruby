# Ruby Client for the GoCardless API

A Ruby client for the GoCardless API. For full details of the GoCardless API, see the [API docs](https://developer.gocardless.com/pro/).

[![Gem Version](https://badge.fury.io/rb/gocardless_pro.svg)](http://badge.fury.io/rb/gocardless_pro)
[![Build Status](https://travis-ci.org/gocardless/gocardless-pro-ruby.svg?branch=master)](https://travis-ci.org/gocardless/gocardless-pro-ruby)

- ["Getting started" guide](https://developer.gocardless.com/getting-started/api/introduction/?lang=ruby) with copy and paste Ruby code samples
- [API Reference](https://developer.gocardless.com/api-reference)

## Usage Examples

This README will use `customers` throughout but each of the resources in the
[API](https://developer.gocardless.com/api-reference/) is available in this library.

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

When creating a resource, the library will automatically include a randomly-generated
[idempotency key](https://developer.gocardless.com/api-reference/#making-requests-idempotency-keys)
- this means that if a request appears to fail but is in fact successful (for example due
to a timeout), you will not end up creating multiple duplicates of the resource.

If any parameters are required they come first:

```rb
@client.customers.update(customer_id, {...})
```

### Custom headers

Custom headers can be provided for a POST request under the `headers` key.

The most common use of a custom header would be to set a custom [idempotency key](https://developer.gocardless.com/pro/#making-requests-idempotency-keys) when making a request:

```rb
@client.customers.create(
  params: {
    first_name: "Pete",
    last_name: "Hamilton",
    ...
  },
  headers: {
    "Idempotency-Key": "1f9630a9-0487-418d-bd37-8b77793c9985"
  }
)
```

### Handling failures

When the API itself returns an error, the client will raise a corresponding exception. There are four classes of exception which could be thrown, all of which subclass `GoCardlessPro::Error`:

- `GoCardlessPro::GoCardlessError`
- `GoCardlessPro::InvalidApiUsageError`
- `GoCardlessPro::InvalidStateError`
- `GoCardlessPro::ValidationError`

These different types of error are fully documented in the [API documentation](https://developer.gocardless.com/api-reference/#overview-errors). Exceptions raised by the library have the following methods to provide access to information in the API response:

- `#documentation_url`
- `#message`
- `#type`
- `#code`
- `#request_id`
- `#errors`

When the API returns an `invalid_state` error due to an `idempotent_creation_conflict`, where possible, the library will automatically retrieve the existing record which was created using the idempotency key.

If the client is unable to connect to GoCardless, an appropriate exception will be raised, for example:

* `Faraday::TimeoutError`, in case of a timeout
* `Faraday::ConnectionFailed`, in case of a connection issue (e.g. problems with DNS resolution)
* `GoCardlessPro::ApiError`, for `5xx` errors returned from our infrastructure, but not by the API itself

If an error occurs which is likely to be resolved with a retry (e.g. a timeout or connection error), and the request being made is idempotent, the library will automatically retry the request twice (i.e. it will make up to 3 attempts) before giving up and raising an exception.

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
