# frozen_string_literal: true

require 'http'
require 'yaml'

config = YAML.safe_load(File.read('config/secrets.yml'))

def gh_api_path(path)
  "https://api.spoonacular.com/#{path}"
end

sp_response = {}
sp_results = {}

## HAPPY recipes request
recipes_url = gh_api_path('recipes/findByIngredients?ingredients=apples')
# sp_response[recipes_url] = call_gh_url(config, recipes_url)
sp_response[recipes_url] = HTTP.headers('x-api-key' => config['FOOD_API_TOKEN']).get(recipes_url)
recipes = sp_response[recipes_url].parse

sp_results['size'] = recipes.count
# should be 10

sp_results['recipes'] = recipes

## BAD recipes request
bad_recipes_url = gh_api_path('recipes/bad')
sp_response[bad_recipes_url] = call_gh_url(config, bad_recipes_url)
sp_response[bad_recipes_url].status.client_error?

File.write('spec/fixtures/results.yml', sp_results.to_yaml)
