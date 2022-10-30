# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'recipe'

module Foodegrient
  module Entity
    # Domain entity for menu
    class Menu < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :ingredients, Strict::Array.of(String)
      attribute :recipes,     Strict::Array.of(Recipe)
    end
  end
end
