# frozen_string_literal: true

require 'roda'
require 'slim'

module Foodegrient
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
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
            # routing.halt 400 unless (gh_url.include? 'github.com') &&
            #                         (gh_url.split('/').count >= 3)
            # owner, project = gh_url.split('/')[-2..]

            routing.redirect "menu/result/#{keywords}"
          end
        end

        routing.on String do |keywords|
          # GET /project/owner/project
          routing.get do
            # github_project = Github::ProjectMapper
            #   .new(GH_TOKEN)
            #   .find(owner, project)

            view 'result'
            # , locals: { project: github_project }
          end
        end

      # routing.on 'result' do
      #   routing.on String do |words|
      #     # GET /project/owner/project
      #     menu_result = Entity::Menu
      #         .new(GH_TOKEN)
      #         .find(owner, project)
      #     routing.get do
      #       view 'result'
      #     end
      #   end
      # end
      end
    end
  end
end