# frozen_string_literal: true

require 'http'
require_relative 'menu'

module Foodegrient
  module Food
    # Library for Food API utilities
    class Api
      API_ROOT = 'https://api.spoonacular.com/recipes/findByIngredients'
      class Request

        def initialize(token)
          @api_token = token
        end

        def food_api_path(path)
          "https://api.spoonacular.com/#{path}"
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

        def get(url)
          result = HTTP.headers('x-api-key' => @api_token).get(url)
          Response.new(result).tap do |response|
            raise(response.error) unless response.successful?
          end
        end
      end


      # Decorates HTTP responses from Food API
      class Response < SimpleDelegator
        Unauthorized = Class.new(StandardError)
        NotFound = Class.new(StandardError)

        HTTP_ERROR = {
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def successful?
          HTTP_ERROR.keys.none?(code)
        end

        def error
          HTTP_ERROR[code]
        end
      end
    end
  end
end
