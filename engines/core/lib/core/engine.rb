require "sprockets/railtie"
require "pagy"

module Core
  class Engine < ::Rails::Engine
   isolate_namespace Core

   config.api_only = false

    initializer "core.add_middleware" do |app|
      app.middleware.use ActionDispatch::Cookies
      app.middleware.use ActionDispatch::Session::CookieStore
      app.middleware.use ActionDispatch::Flash
    end

    initializer "core.register_mime_types" do
      Mime::Type.register "text/vnd.turbo-stream.html", :turbo_stream
    end

    initializer "core.yarn" do |app|
      if Rails.env.development?
        config.after_initialize do
 
          unless root.join("node_modules").exist?
            system "yarn install", chdir: root
          end

          unless root.join("app/assets/stylesheets/core/application.css").exist?
            system "yarn build:css", chdir: root
          end

          unless root.join("app/assets/builds/application.js").exist?
            system "yarn build", chdir: root
          end
        end
      end
    end


    initializer "core.assets" do |app|
      app.config.assets.paths << root.join("app", "assets", "javascripts","core").to_s
      app.config.assets.paths << root.join("app", "assets", "stylesheets","core").to_s
      app.config.assets.paths << root.join("app", "assets", "config")
      app.config.assets.paths << root.join("node_modules")

      # Adiciona os assets da engine à pré-compilação
      app.config.assets.precompile += %w( core/application.js core/application.css )
    end


  end
end
