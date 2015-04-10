 require_relative 'lib/gocardless/enterprise'

@client = GoCardless::Client.new(
  user: ENV["GOCARDLESS_KEY"],
  password: ENV["GOCARDLESS_TOKEN"],
  environment: :sandbox
)

puts "Your first customer:"
puts "-> #{@client.customers.list.first.inspect}"
