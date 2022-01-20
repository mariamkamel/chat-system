class Api::ApplicationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    require "securerandom"
    def index
        apps = App.all
        render json: apps, status: 200
    end

    def create
      uuid = SecureRandom.uuid
      app = App.new(
          name: app_create_params[:name],
          chat_count: 0,
          token: uuid
      )
      if app.save
        render json: app, status: 200
      else
        render json: {error: "ERROR CREATING APP"}
      end
    end

    def show
        app = App.find_by(token: params[:token])
        if app
           render json: app, status: 200
        else 
            render json: {error: "APP NOT FOUND"}
        end
    end

    def update
      app = App.find_by(token: params[:token])
      if
        app.update(name: app_create_params[:name])
        render json: app, status: 200
      else
        render json: {error: "APP NOT FOUND"} 
      end
    end
    private
        def app_create_params
            params.require(:app).permit(:name)
        end
end