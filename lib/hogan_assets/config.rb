module HoganAssets
  # Change config options in an initializer:
  #
  # HoganAssets::Config.template_extensions = ['mustache']
  #
  # Or in a block:
  #
  # HoganAssets::Config.configure do |config|
  #   config.lambda_support = false
  #   config.path_prefix = 'templates'
  #   config.template_extensions = ['mustache', 'hamstache', 'slimstache']
  #   config.haml_options[:ugly] = true
  #   config.slim_options[:pretty] = false
  # end
  #
  module Config
    extend self

    attr_writer :lambda_support, :path_prefix, :template_extensions, :template_namespace, :haml_options, :slim_options

    def configure
      yield self
    end

    def haml_available?
      defined? ::Haml::Engine
    end

    def slim_available?
      defined? ::Slim::Engine
    end

    def lambda_support?
      @lambda_support
    end

    def path_prefix
      @path_prefix ||= 'templates'
    end

    def template_namespace
      @template_namespace ||= 'HoganTemplates'
    end

    def template_extensions
      @template_extensions ||= "mustache#{' hamstache' if haml_available?}#{' slimstache' if slim_available?}".split
    end

    def haml_options
      @haml_options ||= {}
    end

    def slim_options
      @slim_options ||= {}
    end
  end
end
