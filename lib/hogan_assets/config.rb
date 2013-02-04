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
  # Change config options in a YAML file (config/hogan_assets.yml):
  #
  # defaults: &defaults
  #   lambda_support: false
  #   path_prefix: 'templates'
  #   template_extensions:
  #     - 'hamstache'
  #     - 'slimstache'
  #   template_namespace: 'JST'
  #   haml_options:
  #     ugly: true
  #   slim_options:
  #     pretty: false
  # development:
  #   <<: *defaults
  # test:
  #   <<: *defaults
  # production:
  #   <<: *defaults
  #
  module Config
    extend self

    attr_writer :lambda_support, :path_prefix, :template_extensions, :template_namespace, :haml_options, :slim_options

    def configure
      yield self
    end

    def load_yml!
      @lambda_support      = yml['lambda_support'] if yml.has_key?('lambda_support')
      @path_prefix         = yml['path_prefix'] if yml.has_key?('path_prefix')
      @template_extensions = yml['template_extensions'] if yml.has_key?('template_extensions')
      @template_namespace  = yml['template_namespace'] if yml.has_key?('template_namespace')
      @haml_options        = yml['haml_options'] if yml.has_key?('haml_options')
      @slim_options        = yml['slim_options'] if yml.has_key?('slim_options')
      @haml_options.symbolize_keys
      @slim_options.symbolize_keys
    end

    def yml
      begin
        @yml ||= YAML.load(ERB.new(IO.read(yml_path)).result)[Rails.env] rescue nil || {}
      rescue Psych::SyntaxError
        @yml = {}
      end
    end

    def yml_exists?
      File.exists?(yml_path)
    end

    def yml_path
      Rails.root.join('config', 'hogan_assets.yml')
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
