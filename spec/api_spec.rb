# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Tests API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<API_TOKEN>') { API_TOKEN }
  end

  before do
    VCR.insert_cassette CASSETTES_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

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
