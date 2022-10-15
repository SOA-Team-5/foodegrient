# frozen_string_literal: true

require 'http'
require_relative 'food'

module Foodegrient
  class ApiUtils
    API_ROOT = 'https://api.spoonacular.com/recipes/findByIngredients'

    module Errors
      class NotFound < StandardError; end
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
      result = String.new
      result << 'recipes/findByIngredients'
      ingredients.each_with_index do |ingredient, index|
        result += index==0 ? "?ingredients=#{ingredient}" : ",+#{ingredient}"
      end
      result
    end

    def recipes(ingredients)
      query = build_query(ingredients)
      recipes_url = food_api_path(query)
      recipes = call_food_url(recipes_url).parse
      save_files(recipes)
    end

    def save_files(recipes_data)
      File.write('spec/fixtures/results.yml', recipes_data.to_yaml)
    end
  end
end
