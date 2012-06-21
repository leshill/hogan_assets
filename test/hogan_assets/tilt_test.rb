require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
    def scope(path)
      instance = Class.new do
        attr_accessor :_path

        def logical_path ; _path.gsub /\..*/, '' ; end

        def pathname ; Pathname.new _path ; end
      end.new
      instance._path = path
      instance
    end

    def test_mime_type
      assert_equal 'application/javascript', HoganAssets::Tilt.default_mime_type
    end

    def test_render
      path = 'path/to/template.mustache'
      template = HoganAssets::Tilt.new(path) { "This is {{mustache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope(path), {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "", Hogan, {});
      END_EXPECTED
    end

    def test_hamstache_render
      path = 'path/to/template.hamstache'
      template = HoganAssets::Tilt.new(path) { "%p This is {{hamstache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope(path), {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"<p>This is \");t.b(t.v(t.f(\"hamstache\",c,p,0)));t.b(\"</p>\");t.b(\"\\n\");return t.fl(); },partials: {}, subs: {  }}, \"\", Hogan, {});
      END_EXPECTED
    end

    def test_render_with_lambdas
      path = 'path/to/template.mustache'
      HoganAssets::Config.lambda_support = true
      template = HoganAssets::Tilt.new(path) { "This is {{mustache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope(path), {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "This is {{mustache}}", Hogan, {});
      END_EXPECTED
    end
  end
end
