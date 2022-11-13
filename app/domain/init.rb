# frozen_string_literal: true

folders = %w[menus]
folders.each do |folder|
  require_relative "#{folder}/init"
end