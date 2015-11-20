# Ruby Client for GoCardless Pro API

- [GoCardless Pro API Docs](https://developer.gocardless.com/pro/)
- [RubyGems](https://rubygems.org/gems/gocardless_pro)

Add this line to your application's Gemfile:

```ruby
gem 'gocardless_pro'
```

And then load it into your application:

```ruby
require 'gocardless_pro'
```

## Usage Examples

- In the case of a single response, the client will return you an instance of the resource
- In the case of list responses, the client will return an instance of `ListResponse`.
- You can also call `#all` to get a lazily paginated list of resource that will deal with making extra API requests to paginate through all the data

### Initialising the client

The client is initialised with an Access Token.
You can also pass in `environment` as `:sandbox` to make requests to the sandbox environment rather than production.

```rb
@client = GoCardlessPro::Client.new(
  access_token: ENV["GOCARDLESS_TOKEN"]
)
```

### GET requests

You can make a request to get a list of resources using the `list` method:

```rb
@client.customers.list
```

This README will use `customers` throughout but each of the resources in the API is available in this library. They are defined in [`gocardless.rb`](https://github.com/gocardless/pro-client-ruby/blob/master/lib/gocardless_pro.rb#L87).

If you need to pass any options, the last (or in the absence of URL params, the only) argument is an options hash. This is used to pass query parameters for `GET` requests:

```rb
@client.customers.list(params: { limit: 400 })
```

A call to `list` returns an instance of `GoCardlessPro::ListResponse`. You can call `records` on this to iterate through results:

```rb
@client.customers.list.records.each do |customer|
  p customer.given_name
end
```

In the case where a url parameter is needed, the method signature will contain required arguments:

```rb
@client.customers.get(customers_id)
```

As with list, the last argument can be an options hash, with any URL parameters given under the `params` key:

```rb
@client.customers.get(customers_id, params: { limit: 200 })
```

Both individual resource and `ListResponse` instances provide an `api_response` method, which lets you access the following properties of the request:

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

As with GET requests, if any parameters are required they come first:

```rb
@client.customers.update(customer_id, {...})
```

### Handling failures

When an API returns an error, the client __will raise__ an error that corresponds to the type of error. All errors subclass `GoCardlessPro::Error`. There are four errors that could be thrown:

- `GoCardlessPro::GoCardlessError`
- `GoCardlessPro::InvalidApiUsageError`
- `GoCardlessPro::InvalidStateError`
- `GoCardlessPro::ValidationError`

These errors are fully documented in the [API documentation](https://developer.gocardless.com/pro/#overview-errors).

The error has the following methods to allow you to access the information from the API response:

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

However, support for previous ruby versions can be added using a gem such as
[backports](https://github.com/marcandre/backports).

1. Add backports to your Gemfile
   ```gem 'backports'```
2. Require lazy enumerables
   ```require 'backports/2.0.0/enumerable/lazy.rb'```

## Contributing

This client is auto-generated from Crank, a toolchain that we hope to soon open source. Issues should for now be reported on this repository. __Please do not modify the source code yourself, your changes will be overriden!__
