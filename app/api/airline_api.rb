class AirlineApi < Grape::API
  format :json
  helpers SessionHelpers

  mount CityAPI

  # add_swagger_documentation(
  #   base_path: "/api",
  #   hide_documentation_path: true,
  #   hide_format: true,
  # )
end
njnjnj