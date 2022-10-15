# frozen_string_literal: true

module Foodegrient
  # class for food recipes
  class Menu
    def initialize(main_ingredients, recipes)
      @main_ingredients = main_ingredients
      @recipes = recipes
    end

    def main_ingredients
      @main_ingredients
    end

    def size
      @recipes.size
    end
  end
end
