require 'tilt'

module HoganAssets
  class Tilt < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def initialize_engine
      require_template_library 'haml'
    rescue LoadError
      # haml not available
    end

    def evaluate(scope, locals, &block)
      text = data # Ugly, yes, but to not taint data variable

      if scope.pathname.extname == '.hamstache'
        raise "Unable to complile #{scope.pathname} because haml is not available. Did you add the haml gem?" unless HoganAssets::Config.haml_available?
        text = Haml::Engine.new(data, @options).render
        compiled_template = Hogan.compile(text)
      else
        compiled_template = Hogan.compile(data)
      end

      template_name = scope.logical_path.inspect

      # Only emit the source template if we are using lambdas
      text = '' unless HoganAssets::Config.lambda_support?
      <<-TEMPLATE
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[#{template_name}] = new Hogan.Template(#{compiled_template}, #{text.inspect}, Hogan, {});
      TEMPLATE
    end

    protected

    def prepare; end
  end
end
