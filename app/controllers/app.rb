# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module Foodegrient
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: 'style.css', path: 'app/presentation/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        flash.now[:notice] = 'Search for the recipe you want'
        view 'home'
      end

      routing.on 'menu' do
        routing.is do
          # POST /project/
          routing.post do
            ori_keywords = routing.params['keywords']
            unless (ori_keywords.nil? || ori_keywords.empty?)
              flash[:error] = 'Please enter menu'
              response.status = 400
              routing.redirect "/"
            end
          end
        end

        routing.on String do |keywords|
          # GET /menu/result/keywords
          routing.get do
            result = Spoonacular::MenuMapper
                     .new(App.config.FOOD_API_TOKEN)
                     .search(keywords.split('%20'))

            results_list = Views::ResultsList.new(keywords, result)

            view('result', locals: { results_list: })
          end
        end
      end
    end
  end
end
