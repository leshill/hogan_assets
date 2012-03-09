module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine(".#{HoganAssets.template_extension}", Tilt)
    end
  end
end
