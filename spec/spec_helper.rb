# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/api_utils'


INGREDIENTS='apples'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
GITHUB_TOKEN = CONFIG['FOOD_API_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/recipes_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTES_FILE = 'food_api'