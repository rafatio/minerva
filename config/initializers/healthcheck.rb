Healthcheck.configure do |config|
  config.success = 200
  config.error = 503
  config.verbose = false
  config.route = '/healthcheck'
  config.method = :get

  config.add_check :environments, -> { Dotenv.require_keys('MINERVA_OK') }
end
