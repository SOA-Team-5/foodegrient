# frozen_string_literal: true

require 'http'
require 'yaml'

config = YAML.safe_load(File.read('config/secrets.yml'))

def gh_api_path(path)
  "https://api.spoonacular.com/#{path}"
end

def call_gh_url(config, url)
  HTTP.headers('Content-Type' => 'application/x-www-form-urlencoded',
               'Authorization' => "token #{config['apiKey']}").get(url)
end

gh_response = {}
gh_results = {}

## HAPPY project request
project_url = gh_api_path('recipes/findByIngredients')
gh_response[project_url] = call_gh_url(config, project_url)
project = gh_response[project_url].parse




File.write('spec/fixtures/spoonacular.yml', gh_results.to_yaml)