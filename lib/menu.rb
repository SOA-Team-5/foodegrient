# frozen_string_literal: true

module Foodegrient
  # class for food recipes
  class Menu
    def initialize(main_ingredients, recipes)
      @main_ingredients = main_ingredients
      @recipes = recipes
    end

    attr_reader :main_ingredients, :recipes

    def size
      @recipes.size
    end
  end
end
