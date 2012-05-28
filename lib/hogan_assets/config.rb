module HoganAssets
  # Change config options in an initializer:
  #
  # HoganAssets::Config.template_extensions = ['mustache']
  #
  # Or in a block:
  #
  # HoganAssets::Config.configure do |config|
  #   config.template_extensions = ['mustache']
  # end

  module Config
    extend self

    def configure
      yield self
    end

    attr_accessor :allow_hamstache

    attr_writer :template_extensions

    def template_extensions
      @template_extensions ||= if haml_available?
                                 ['mustache', 'hamstache']
                               else
                                 ['mustache']
                               end
    end

    def haml_available?
      defined? ::Haml::Engine
    end
  end
end
