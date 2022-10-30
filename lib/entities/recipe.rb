# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module Foodegrient
  module Entity
    # Domain entity for recipe
    class Recipe < Dry::Struct
      include Dry.Types

      attribute :id,        Integer
      attribute :image,     Strict::String
      attribute :title,      Strict::String
      attribute :ingredients, Strict::Array.of(String)
    end
  end
end
