# Client for GoCardless Enterprise API


Add this line to your application's Gemfile:

```ruby
gem 'gocardless-enterprise'
```

## Usage Examples

- In the case of a single response, the client will return you an instance of the resource
- In the case of list responses, the client will return an instance of `ListResponse`, which is enumerable.
- You can also call `#all` to get a lazily paginated list of resource that will deal with making extra API requests to paginate through all the data

### Initialising the client

The client is initialised with a user and password, which is the API Key and token respectively. You can also pass in `environment` as `:sandbox` to make requests to the sandbox environment.

```
@client = GoCardless::Client.new(
  api_key: ENV["GOCARDLESS_KEY"],
  api_secret: ENV["GOCARDLESS_TOKEN"]
)
```

### GET requests

Simple requests can be made like this:

```
@client.resource.list
```

Where `resource` is one of the resources in the GoCardless API, such as `customers` or `mandate`.

If you need to pass any options, the last (or in the absence of URL params, the only) argument is an options hash. This is used to pass query parameters for `GET` requests.

```
@client.customers.list(limit: 400)
```

In the case where url parameters are needed, the method signature will contain required arguments:

```
@client.customers.show(customers_id)
```

As with list, the last argument can be an options hash:

```
@client.customers.show(customers_id, limit: 200)
```

### POST/PUT Requests

For POST and PUT requests you need to pass in the body in as the last argument.

```
@client.customers.create(
  first_name: "Pete",
  last_name: "Hamilton",
  ...
)
```

As with GET requests, if href params are required they come first:

```
@client.customers.update(customers_id, {...})
```

### Custom Headers

If you need to pass in a custom header to an endpoint, you can pass in a separate hash as the last argument:

```
@client.helpers.mandate({
  account_number: 200000
  ...
}, {
  'Accept': 'application/pdf'
})
```

### Handling failures

When an API returns an error, the client __will raise__ an error that corresponds to the type of error. All errors subclass `GoCardless::Error`. There are four errors that could be thrown:

- `GoCardless::GoCardlessError`
- `GoCardless::InvalidApiUsageError`
- `GoCardless::InvalidStateError`
- `GoCardless::ValidationError`

These errors are fully documented in the [API documentation](https://developer.gocardless.com/pro/#overview-errors).

The error has the following methods to allow you to access the information from the API response:

- #documentation_url
- #message
- #type
- #code
- #request_id
- #errors


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

This client is auto-generated from Crank, a toolchain that we hope to soon open source. Issues should for now be reported on this repository. Please do not modify the source code yourself, your changes will be overriden!
