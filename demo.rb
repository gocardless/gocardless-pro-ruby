 require_relative 'lib/gocardless/enterprise'

@client = GoCardless::Client.new(
  user: "AK0000133BVTZP",
  password: "I4WaBGT8FQTDmUbmIl51-FLw3OqhyeHj2x89rOV7",
  environment: :sandbox
)

p @client.customers.list.first

p @client.customers.all.to_a
