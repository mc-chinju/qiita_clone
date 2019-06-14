Rails.application.config.generators do |g|
  g.template_engine false
  g.javascripts false
  g.stylesheets false
  g.helper true
  g.factory_bot dir: "spec/factories"
  g.test_framework :rspec,
                   view_specs: false,
                   routing_specs: false,
                   helper_specs: false,
                   controller_specs: false,
                   request_specs: true
end
