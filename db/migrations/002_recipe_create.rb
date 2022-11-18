# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:recipe) do
      primary_key :r_id

      Integer     :r_id, unique: true
      String      :image
      String      :title
      Integer     :menu_id
    end
  end
end
