 require_relative 'lib/gocardless_pro'

@client = GoCardlessPro::Client.new(
  access_token: ENV["GOCARDLESS_TOKEN"],
  environment: :sandbox
)

puts "Your first customer:"
puts "-> #{@client.customers.list.records.first.inspect}"
