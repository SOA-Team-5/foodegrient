# frozen_string_literal: true

module Views
  # View for a a list of project entities
  class ResultsList
    def initialize(keywords, menus)
      @keywords = keywords
      @menus = menus
    end

    attr_reader :keywords, :menus
  end
end
