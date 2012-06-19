require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
    def scope
      Class.new do
        def logical_path ; 'path/to/template' ; end

        def pathname ; Pathname.new logical_path ; end
      end.new
    end

    def test_mime_type
      assert_equal 'application/javascript', HoganAssets::Tilt.default_mime_type
    end

    def test_render
      template = HoganAssets::Tilt.new('/myapp/app/assets/templates/path/to/template.mustache') { "This is {{mustache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "", Hogan, {});
      END_EXPECTED
    end

    def test_render_with_lambdas
      HoganAssets::Config.lambda_support = true
      template = HoganAssets::Tilt.new('/myapp/app/assets/templates/path/to/template.mustache') { "This is {{mustache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "This is {{mustache}}", Hogan, {});
      END_EXPECTED
    end
  end
end
