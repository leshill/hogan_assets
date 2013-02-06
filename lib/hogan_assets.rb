require 'hogan_assets/version'
require 'hogan_assets/config'

module HoganAssets
  extend Config

  autoload :Hogan, 'hogan_assets/hogan'
  autoload :Tilt, 'hogan_assets/tilt'

  if defined? Rails
    require 'hogan_assets/engine'
  else
    require 'sprockets'
    Config.load_yml! if Config.yml_exists?
    Config.template_extensions.each do |ext|
      Sprockets.register_engine ".#{ext}", Tilt
    end
  end
end
