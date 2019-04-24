module HoganAssets
  class Transformer
    def self.register(env, ext)
      # NOTE: The Transformer API is a bit different in the latest Sprockets versions.
      # Removing the transformer registration until we check the API and implement it properly
      #
      # if env.respond_to?(:register_transformer)
      #   env.register_mime_type mime_type, extensions: [extension], charset: :unicode
      #   env.register_mime_type 'application/javascript', extensions: ['.js']

      #   env.register_transformer(mime_type, 'application/javascript', Tilt)
      # end

      env.register_engine(".#{ext}", Tilt, silence_deprecation: true)
    end
  end
end
