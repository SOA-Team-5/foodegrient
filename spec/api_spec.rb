# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/api_utils'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['FOOD_API_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/recipes_results.yml'))

describe 'Tests API library' do
  describe 'Recipes information' do
    it 'HAPPY: should provide correct attributes' do
      ingredients = %w[apple watermelon]
      result = Foodegrient::ApiUtils.new(API_TOKEN).menu(ingredients)
      _(result.main_ingredients).must_equal CORRECT['main_ingredients']
      _(result.size).must_equal CORRECT['recipes'].size
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        Foodegrient::ApiUtils.new('BAD_TOKEN').menu(%w[apple watermelon])
      end).must_raise Foodegrient::ApiUtils::Errors::Unauthorized
    end

    it 'SAD: should be empty on incorrect attributes' do
      _(
        Foodegrient::ApiUtils.new(API_TOKEN).menu(%w[1]).recipes
      ).must_be_empty
    end
  end
end
