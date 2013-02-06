require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
    include TestSupport

    def teardown
      HoganAssets::Config.lambda_support = false
      HoganAssets::Config.path_prefix = 'templates'
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
      HoganAssets::Config.configure do |config|
        config.lambda_support = true
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "This is {{mustache}}", Hogan, {});
      END_EXPECTED
    end

    def test_path_prefix
      HoganAssets::Config.configure do |config|
        config.path_prefix = 'app/templates'
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'app/templates/template.mustache'

      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "", Hogan, {});
      END_EXPECTED
    end

    def test_template_namespace
      HoganAssets::Config.configure do |config|
        config.template_namespace = 'JST'
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.JST || (this.JST = {});
        this.JST[\"path/to/template\"] = new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||\"\");t.b(\"This is \");t.b(t.v(t.f(\"mustache\",c,p,0)));return t.fl(); },partials: {}, subs: {  }}, "", Hogan, {});
      END_EXPECTED
    end

    def test_haml_options
      HoganAssets::Config.configure do |config|
        config.haml_options[:ugly] = true
      end
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.hamstache'
      template = HoganAssets::Tilt.new(scope.s_path) { "%p\n  This is {{mustache}}" }
      assert_match /<p>/, template.render(scope, {})
    end

    def test_slim_options
      HoganAssets::Config.configure do |config|
        config.slim_options[:pretty] = false
      end
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.slimstache'
      template = HoganAssets::Tilt.new(scope.s_path) { "p This is {{mustache}}" }
      assert_match /<p>/, template.render(scope, {})
    end
  end
end
