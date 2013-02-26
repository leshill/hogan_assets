require 'hogan_assets'

require 'test/unit'

module HoganAssets::Config
  def reset!
    %w(env lambda_support path_prefix template_extensions template_namespace haml_options slim_options slimstache_extensions hamstache_extensions).each do |option|
      send "#{option}=", nil
    end


  end
end
module TestSupport
  # Try to act like sprockets.
  def make_scope(root, file)
    Class.new do
      define_method(:logical_path) { pathname.to_s.gsub(root + '/', '').gsub(/\..*/, '') }

      define_method(:pathname) { Pathname.new(root) + file }

      define_method(:root_path) { root }

      define_method(:s_path) { pathname.to_s }
    end.new
  end
end
