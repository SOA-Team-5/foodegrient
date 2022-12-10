# frozen_string_literal: true

require 'dry/monads'

module Foodegrient
  module Service
    # Retrieves array of all listed project entities
    class Keywords
      include Dry::Monads::Result::Mixin

      def call(ori_keywords)
        results = Forms::NewQuery.new.call(ingredients:ori_keywords.split(' '))

        Success(results)
      rescue StandardError
        Failure('Could not access')
      end
    end
  end
end
