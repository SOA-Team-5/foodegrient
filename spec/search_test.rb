# frozen_string_literal: true
require 'dry-validation'
require 'minitest/autorun'
require 'minitest/rg'
require_relative '../app/applications/forms/new_query'

describe 'Tests Input' do
  describe 'Keywords' do
    it 'HAPPY: should success' do
      keywords = 'apple milk'
      
      _(Foodegrient::Forms::NewQuery.new.call(ingredients:keywords.split(' ')).success?).must_equal true
    end

    it 'SAD: should fail' do
      _(
        Foodegrient::Forms::NewQuery.new.call(ingredients:'apple apple'.split(' ')).success?
      ).must_equal false
    end
  end
end
