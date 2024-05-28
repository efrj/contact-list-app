Geocoder.configure(
  api_key: ENV['GOOGLE_MAPS_API_KEY'],
  use_https: true,
  lookup: :google,
  units: :km
)
