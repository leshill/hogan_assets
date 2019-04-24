require 'tilt'

module HoganAssets
  class Tilt < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def initialize_engine
      load_haml
      load_slim
    end

    def evaluate(scope, locals, &block)
      template_path = TemplatePath.new scope
      template_namespace = HoganAssets::Config.template_namespace

      text = if template_path.is_hamstache?
        raise "Unable to compile #{template_path.full_path} because haml is not available. Did you add the haml gem?" unless HoganAssets::Config.haml_available?
        ::Haml::Engine.new(data, HoganAssets::Config.haml_options.merge(@options)).render(scope, locals)
      elsif template_path.is_slimstache?
        raise "Unable to compile #{template_path.full_path} because slim is not available. Did you add the slim gem?" unless HoganAssets::Config.slim_available?
        ::Slim::Template.new(HoganAssets::Config.slim_options.merge(@options)) { data }.render(scope, locals)
      else
        data
      end

      compiled_template = Hogan.compile(text)

      # Only emit the source template if we are using lambdas
      text = '' unless HoganAssets::Config.lambda_support?
      <<-TEMPLATE
        this.#{template_namespace} || (this.#{template_namespace} = {});
        this.#{template_namespace}[#{template_path.name}] = new Hogan.Template(#{compiled_template}, #{text.inspect}, Hogan, {});
      TEMPLATE
    end

    protected

    def load_haml
      require 'haml'
    rescue LoadError
      # haml not available
    end

    def load_slim
      require 'slim'
    rescue LoadError
      # slim not available
    end

    def prepare; end

    class TemplatePath
      attr_accessor :full_path

      def initialize(scope)
        self.template_path = scope.logical_path
        self.full_path = scope.pathname
      end

      def is_hamstache?
        file_path = full_path.to_s
        HoganAssets::Config.hamstache_extensions.any? { |ext| file_path.to_s.end_with? ext }
      end

      def is_slimstache?
        file_path = full_path.to_s
        HoganAssets::Config.slimstache_extensions.any? { |ext| file_path.to_s.end_with? ext }
      end

      def name
        @name ||= relative_path.dump
      end

      private

      attr_accessor :template_path

      def relative_path
        @relative_path ||= template_path.gsub(/^#{HoganAssets::Config.path_prefix}\/(.*)$/i, "\\1")
      end
    end
  end
end
