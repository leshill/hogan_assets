require 'tilt'

module HoganAssets
  class Tilt < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def self.engine_initialized?
      defined? ::Haml::Engine
    end

    def initialize_engine
      require_template_library 'haml'
    end

    def evaluate(scope, locals, &block)

require 'pry'
binding.pry

      compiled_template = Hogan.compile(data)
      template_name = scope.logical_path.inspect
      options = @options.merge(:filename => eval_file, :line => line)
      Haml::Engine.new(compiled_template, options).render(scope)

      <<-TEMPLATE
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[#{template_name}] = new Hogan.Template(#{compiled_template});
      TEMPLATE
    end

    protected

    def prepare; end
  end
end
