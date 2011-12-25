module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine('.mustache', Tilt)
    end
  end
end
