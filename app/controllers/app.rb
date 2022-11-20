# frozen_string_literal: true

require 'roda'
require 'slim'

module Foodegrient
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: 'style.css', path: 'app/presentation/assets/css'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'menu' do
        routing.is do
          # POST /project/
          routing.post do
            keywords = routing.params['keywords']

            routing.redirect "menu/#{keywords}"
          end
        end

        routing.on String do |keywords|
          # GET /menu/result/keywords
          routing.get do
            result = Spoonacular::MenuMapper
                     .new(App.config.FOOD_API_TOKEN)
                     .search(keywords.split)

            results_list = Views::ResultsList.new(keywords, result)

            view('result', locals: { results_list: })
          end
        end
      end
    end
  end
end
