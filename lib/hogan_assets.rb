require 'hogan_assets/version'
require 'hogan_assets/config'

module HoganAssets
  autoload(:Hogan, 'hogan_assets/hogan')
  autoload(:Tilt, 'hogan_assets/tilt')

  if defined?(Rails)
    require 'hogan_assets/engine'
  else
    require 'sprockets'
    Sprockets.register_engine ".#{HoganAssets.template_extension}", Tilt
  end
end
