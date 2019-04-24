module HoganAssets
  class Transformer
    def self.register(env, ext)
      mime_type = "text/#{ext}"
      extension = ".#{ext}"

      if env.respond_to?(:register_transformer)
        env.register_mime_type mime_type, extensions: [extension], charset: :unicode
        env.register_mime_type 'application/javascript', extensions: ['.js']

        env.register_transformer(mime_type, 'application/javascript', Tilt)
      end

      if env.respond_to?(:register_engine)
        args = [extension, Tilt]
        args << { mime_type: mime_type, silence_deprecation: true } if Sprockets::VERSION.start_with?("3")
        env.register_engine(*args)
      end
    end
  end
end
