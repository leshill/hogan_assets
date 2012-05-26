module HoganAssets
  # Change config options in an initializer:
  #
  # HoganAssets::Config.template_extensions = ['mustache']
  #
  # Or in a block:
  #
  # HoganAssets::Config.configure do |config|
  #   config.template_extensions = ['mustache']
  # end

  module Config
    def self.configure
      yield self
    end

    def self.template_extensions
      @template_extensions ||= ['mustache']
    end

    def self.template_extensions=(value)
      @template_extensions = value
    end
  end
end
