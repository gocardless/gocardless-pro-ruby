 require_relative 'lib/gocardless/enterprise'

@client = GoCardless::Client.new(
  api_key: ENV["GOCARDLESS_KEY"],
  api_secret: ENV["GOCARDLESS_TOKEN"],
  environment: :sandbox
)

puts "Your first customer:"
puts "-> #{@client.customers.list.first.inspect}"
