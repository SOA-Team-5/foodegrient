# frozen_string_literal: true

require 'sequel'

module Foodegrient
  module Database
    # Object Relational Mapper for Menu Entities
    class MenuOrm < Sequel::Model(:menu)
      many_to_one :recipe,
                  class: :'Foodegrient::Database::RecipeOrm'

    end
  end
end