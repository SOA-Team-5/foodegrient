# frozen_string_literal: true

require 'yaml'
require_relative 'lib/api_utils'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['FOOD_API_TOKEN']

ingredients = %w[apple watermelon]
menu = Foodegrient::ApiUtils.new(API_TOKEN).menu(ingredients)
File.write('spec/fixtures/results.yml', menu.to_yaml)
