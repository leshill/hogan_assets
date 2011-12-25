require 'tilt'

module HoganAssets
  class Tilt < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def evaluate(scope, locals, &block)
      compiled_template = Hogan.compile(data)
      code = data.inspect
      template_name = scope.logical_path.inspect
      <<-TEMPLATE
        (function() {
          this.HoganTemplates || (this.HoganTemplates = {});
          this.HoganTemplates[#{template_name}] = new HoganTemplate(#{code});
          this.HoganTemplates[#{template_name}].r = #{compiled_template};
          return HoganTemplates[#{template_name}];
        }).call(this);
      TEMPLATE
    end

    protected

    def prepare; end
  end
end
