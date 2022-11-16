# frozen_string_literal: true

require_relative 'recipes'

module CodePraise
  module Repository
    # Repository for Menu Entities
    class Menu
      def self.all
        Database::MenuOrm.all.map { |menu| rebuild_entity(menu) }
      end

      def self.find(entity)
        find_origin_id(entity.origin_id)
      end

      def self.find_id(myId)
        menu = Database::MenuOrm.first(id:myId)
        rebuild_entity(menu)
      end

      def self.create(entity)
        raise 'Menu already exists' if find(entity)

        menu = PersistMenu.new(entity).call
        rebuild_entity(menu)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Menu.new(
          db_record.to_hash.merge(
            recipes: Recipes.rebuild_many(db_record.recipes)
          )
        )
      end

      # Helper class to persist Menu and its recipes to database
      class PersistMenu
        def initialize(entity)
          @entity = entity
        end

        def create_menu
          Database::MenuOrm.create(@entity.to_attr_hash)
        end

        def call
          create_menu.tap do |menu|
            @entity.recipes.each do |recipe|
              menu.add_recipe(Recipe.db_find_or_create(recipe))
            end
          end
        end
      end
    end
  end
end
