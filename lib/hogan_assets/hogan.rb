# Based on https://github.com/josh/ruby-coffee-script
require 'execjs'
require 'pathname'

module HoganAssets
  class Hogan
    class << self
      def compile(source, options = {})
        context.eval("Hogan.compile(#{source.inspect}, {asString: true})")
      end

      private

      def context
        @context ||= ExecJS.compile(source)
      end

      def source
        @source ||= path.read
      end

      def path
        @path ||= assets_path.join('javascripts', 'hogan.js')
      end

      def assets_path
        @assets_path ||= Pathname(__FILE__).dirname.join('..','..','vendor','assets')
      end
    end
  end
end
