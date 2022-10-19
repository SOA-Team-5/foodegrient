# frozen_string_literal: true

require 'http'
require_relative 'menu'

module Foodegrient
  # class for API utilities
  class ApiUtils
    API_ROOT = 'https://api.spoonacular.com/recipes/findByIngredients'

    # Decorates Error Responses
    module Errors
      # 404 NotFound
      class NotFound < StandardError; end
      # 401 Unauthorized
      class Unauthorized < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    def initialize(token)
      @api_token = token
    end

    def food_api_path(path)
      "https://api.spoonacular.com/#{path}"
    end

    def call_food_url(url)
      result = HTTP.headers('x-api-key' => @api_token).get(url)
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end

    def build_query(ingredients)
      result = 'recipes/findByIngredients'
      ingredients.each_with_index do |ingredient, index|
        result += index.zero? ? "?ingredients=#{ingredient}" : ",+#{ingredient}"
      end
      result
    end

    def menu(ingredients)
      query = build_query(ingredients)
      recipes_url = food_api_path(query)
      recipes = call_food_url(recipes_url).parse
      Menu.new(ingredients, recipes)
    end
  end
end
