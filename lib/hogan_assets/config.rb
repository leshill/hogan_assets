module HoganAssets
  # Change config options in an initializer:
  #
  # HoganAssets.template_extension = 'mustache'
  #
  # Or in a block:
  #
  # HoganAssets.configure do |config|
  #   config.template_extension = 'mustache'
  # end
  
  module Config
    attr_accessor :template_base_path, :template_extension
    
    def configure
      yield self
    end
    
    def template_extension
      @template_extension ||= 'mustache'
    end
  end
end

