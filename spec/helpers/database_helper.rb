# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
    def self.wipe_database
      # Ignore foreign key constraints when wiping tables
      Foodegrient::App.DB.run('PRAGMA foreign_keys = OFF')
      Foodegrient::Database::RecipeOrm.map(&:destroy)
      Foodegrient::Database::MenuOrm.map(&:destroy)
      Foodegrient::App.DB.run('PRAGMA foreign_keys = ON')
    end
  end
