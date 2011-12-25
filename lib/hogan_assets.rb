require 'hogan_assets/version'

module HoganAssets
  autoload(:Hogan, 'hogan_assets/hogan')
  autoload(:Tilt, 'hogan_assets/tilt')

  if defined?(Rails)
    require 'hogan_assets/engine'
  else
    require 'sprockets'
    Sprockets.register_engine '.mustache', Tilt
  end
end
