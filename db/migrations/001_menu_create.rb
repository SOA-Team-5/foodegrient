# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:menu) do
      primary_key :m_id

      Integer     :m_id, unique: true, null: false
      String      :ingredients, null: false
    end
  end
end
