module HoganAssets
  # Change config options in an initializer:
  #
  # HoganAssets::Config.template_extensions = ['mustache']
  #
  # Or in a block:
  #
  # HoganAssets::Config.configure do |config|
  #   config.template_extensions = ['mustache']
  #   config.lambda_support = true
  # end

  module Config
    extend self

    def configure
      yield self
    end

    attr_writer :lambda_support, :template_extensions

    def lambda_support?
      @lambda_support
    end

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
