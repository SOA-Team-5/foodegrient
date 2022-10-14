require 'http'
require_relative 'food'

module Foodegrient

  class ApiUtils
    API_ROOT = "https://api.spoonacular.com/recipes/findByIngredients"

    def food_api_path(path)
      "https://api.spoonacular.com/#{path}"
    end

    def call_food_ur(token, url)
      HTTP.headers('x-api-key' => token).get(url)
    end

    food_response = {}
    food_results = {}

  end

end
