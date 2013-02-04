module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      HoganAssets::Config.load_yml! if HoganAssets::Config.yml_exists?
      HoganAssets::Config.template_extensions.each do |ext|
        app.assets.register_engine(".#{ext}", Tilt)
      end
    end
  end
end
