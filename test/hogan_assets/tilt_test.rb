require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
   # Try to act like sprockets.
    def make_scope(root, file)
      Class.new do
        define_method(:logical_path) { pathname.to_s.gsub(root + '/', '').gsub(/\..*/, '') }

        define_method(:pathname) { Pathname.new(root) + file }

        define_method(:root_path) { root }

        define_method(:s_path) { pathname.to_s }
      end.new
    end

    def test_mime_type
      assert_equal 'application/javascript', HoganAssets::Tilt.default_mime_type
    end

    def test_render
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "", Hogan, {});
      END_EXPECTED
    end

    def test_hamstache_render
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.hamstache'

      template = HoganAssets::Tilt.new(scope.s_path) { "%p This is {{hamstache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"<p>This is \");t.b(t.v(t.f(\"hamstache\",c,p,0)));t.b(\"</p>\");t.b(\"\\n\");return t.fl(); },partials: {}, subs: {  }}, \"\", Hogan, {});
      END_EXPECTED
    end

    def test_render_with_lambdas
      HoganAssets::Config.lambda_support = true

      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "This is {{mustache}}", Hogan, {});
      END_EXPECTED
    end
  end
end
