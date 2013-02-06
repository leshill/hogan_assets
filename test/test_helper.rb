require 'hogan_assets'

require 'test/unit'

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
