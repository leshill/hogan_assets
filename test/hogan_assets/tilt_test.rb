require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
    include TestSupport

    def teardown
      HoganAssets::Config.reset!
    end

    def test_mime_type
      assert_equal 'application/javascript', HoganAssets::Tilt.default_mime_type
    end

    def test_render
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      source = "This is {{mustache}}"
      template = HoganAssets::Tilt.new(scope.s_path) { source }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates["path/to/template"] = new Hogan.Template(#{compiled_template source}, "", Hogan, {});
      END_EXPECTED
    end

    def test_hamstache_render
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.hamstache'

      source = "%p This is {{mustache}}"
      template = HoganAssets::Tilt.new(scope.s_path) { source }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates["path/to/template"] = new Hogan.Template(#{compiled_template haml_compiled scope, source}, "", Hogan, {});
      END_EXPECTED
    end

    def test_render_with_lambdas
      HoganAssets::Config.configure do |config|
        config.lambda_support = true
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      source = "This is {{mustache}}"
      template = HoganAssets::Tilt.new(scope.s_path) { source }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates["path/to/template"] = new Hogan.Template(#{compiled_template source}, "This is {{mustache}}", Hogan, {});
      END_EXPECTED
    end

    def test_path_prefix
      HoganAssets::Config.configure do |config|
        config.path_prefix = 'app/templates'
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'app/templates/template.mustache'

      source = "This is {{mustache}}"
      template = HoganAssets::Tilt.new(scope.s_path) { source }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates["template"] = new Hogan.Template(#{compiled_template source}, "", Hogan, {});
      END_EXPECTED
    end

    def test_template_namespace
      HoganAssets::Config.configure do |config|
        config.template_namespace = 'JST'
      end

      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.mustache'

      source = "This is {{mustache}}"
      template = HoganAssets::Tilt.new(scope.s_path) { source }

      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.JST || (this.JST = {});
        this.JST["path/to/template"] = new Hogan.Template(#{compiled_template source}, "", Hogan, {});
      END_EXPECTED
    end

    def test_haml_options
      HoganAssets::Config.configure do |config|
        config.haml_options[:ugly] = true
        config.hamstache_extensions = ['hamlhbs']
      end
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.hamlhbs'
      template = HoganAssets::Tilt.new(scope.s_path) { "%p\n  This is {{mustache}}" }
      assert_match /<p>/, template.render(scope, {})
    end

    def test_slim_options
      HoganAssets::Config.configure do |config|
        config.slim_options[:pretty] = false
        config.slimstache_extensions = ['slimhbs']
      end
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.slimhbs'
      template = HoganAssets::Tilt.new(scope.s_path) { "p This is {{mustache}}" }
      assert_match /<p>/, template.render(scope, {})
    end
  end
end
