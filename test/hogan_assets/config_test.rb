require 'test_helper'

module HoganAssets
  module Config
    extend self

    def yml_path=(yml_path)
      @yml_path = yml_path
    end
  end

  class ConfigTest < Test::Unit::TestCase
    include TestSupport

    def setup
      HoganAssets::Config.env = 'test'
      HoganAssets::Config.yml_path = Pathname.new('.') + 'test/config/hogan_assets.yml'
      HoganAssets::Config.load_yml!
    end

    def teardown
      HoganAssets::Config.env = nil
      HoganAssets::Config.haml_options = nil
      HoganAssets::Config.template_extensions = nil
      HoganAssets::Config.yml_path = nil
    end

    def test_yaml_options
      scope = make_scope '/myapp/app/assets/javascripts', 'path/to/template.custom'
      template = HoganAssets::Tilt.new(scope.s_path) { "This is {{mustache}}" }
      assert_match /This is/, template.render(scope, {})
      assert_equal HoganAssets::Config.haml_options, ugly: true
    end
  end
end
