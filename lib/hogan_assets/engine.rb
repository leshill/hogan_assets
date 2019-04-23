module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :group => :all do |app|
      HoganAssets::Config.load_yml! if HoganAssets::Config.yml_exists?
      Rails.application.config.assets.configure do |env|
        HoganAssets::Config.template_extensions.each do |ext|
          env.register_engine(".#{ext}", Tilt)
        end
      end
    end
  end
end
