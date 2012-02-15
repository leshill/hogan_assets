require 'tilt'

module HoganAssets
  class Tilt < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def evaluate(scope, locals, &block)
      compiled_template = Hogan.compile(data)
      template_name = scope.logical_path.inspect
      <<-TEMPLATE
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[#{template_name}] = new Hogan.Template(#{compiled_template});
      TEMPLATE
    end

    protected

    def prepare; end
  end
end
