module GoCardlessPro
  # Thrown when something goes wrong with the request to the API
  # and we don\'t get a proper response from the GC API
  class ApiError < Error
  end
end
