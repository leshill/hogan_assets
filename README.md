# HoganAssets

**HoganAssets** compiles your [mustache](http://mustache.github.com/) templates with [hogan.js](http://twitter.github.com/hogan.js/) on **sprockets** and the Rails asset pipeline.

**hogan.js** is a templating engine developed at [Twitter](http://twitter.com) that follows the **mustache** spec and compiles the templates to JavaScript. The first bit is *cool*, since **mustache** is *cool*. The second bit is **awesome and full of win** because we can now compile our **mustache** templates on the server using the asset pipeline/sprockets.

This gem contains **hogan.js 3.0.0** as of this [commit](https://github.com/twitter/hogan.js/commit/9a9eb1ab8fbbfedc9de73aeac4f9c1798d190a21)

## Installation

### Installation with Rails 3.1+

Add this to your `Gemfile` as part of the `assets` group

    group :assets do
      gem 'hogan_assets'
    end

And then execute:

    $ bundle

Require `hogan.js` somewhere in your JavaScript manifest, for example in `application.js` if you are using Rails 3.1+:

    //= require hogan.js

Locate your `.mustache` templates with your other JavaScript assets, usually in `app/assets/javascripts/templates`.
Require your templates with `require_tree`:

    //= require_tree ./templates

Templates are named for the sub-path from your manifest with `require_tree`. For example, the file `app/assets/javascripts/templates/pages/person.mustache` will be named `templates/pages/person`. See `path_prefix` below!

### Installation with sprockets

Add this line to your `Gemfile`:

    gem 'hogan_assets'

And then execute:

    $ bundle

Require `hogan.js` somewhere in your JavaScript.

## Hamstache!

_hamstache_ is the quite popular combination of `haml` and `mustache`, a more robust solution exists using [haml_assets](https://github.com/infbio/haml_assets), but if all you want is nicer markup, you need to take these two additional steps:

Add this line to your `Gemfile`:

    group :assets do
      gem 'haml'
    end

And then execute:

    $ bundle

Hamstache compilation can be configured using [Haml options](http://haml.info/docs/yardoc/Haml/Options.html). For example:

    HoganAssets::Config.configure do |config|
      config.haml_options[:ugly] = true
    end

You can configure which recognized as _hamstache_. For example:

    HoganAssets::Config.configure do |config|
      config.hamstache_extensions = %w(hamstache hamlhbs)
    end

## Slimstache!

_slimstache_ is the also popular combination of `slim` and `mustache`. Works just like hamstache above.

## Configuration

You can configure options using either an intializer or with a YAML file (`config/hogan_assets.yml`). See `lib/hogan_assets/config.rb` for details.

### Lambda Support

**mustache** lambdas are off by default. (Not sure what that is? Read the [mustache](http://mustache.github.com/mustache.5.html) man page!) If you want them on, set the `lambda_support` option to true. This will include the raw template text as part of the compiled template; each template will be correspondingly larger. *TODO* Should this be on by default?

    HoganAssets::Config.configure do |config|
      config.lambda_support = true
    end

### Path Prefix

You can strip a prefix from your template names. For example, when using Rails, if you place your templates in `app/assets/javascripts/app/templates` and organize them like Rails views (i.e. `posts/index.mustache`); then the `index.mustache` template gets compiled into:

    HoganTemplates['app/templates/posts/index']

You can strip the common part of the template name by setting the `path_prefix` option.  For example:

    HoganAssets::Config.configure do |config|
      config.path_prefix = 'app/templates'
    end

will give you a compiled template:

    HoganTemplates['posts/index']

*TODO* Can this be done in a nicer way?

### Template namespace

You can change the namespace for the generated templates. By default, the
namespace is `HoganTemplates`. To change it, use the `template_namespace`
option. For example:

    HoganAssets::Config.configure do |config|
      config.template_namespace = 'JST'
    end

### Template Extensions

By default, templates are recognized if they have an extension of `.mustache` (and if you have haml available, `.hamstache`.) You can change the template extensions by setting the `template_extensions` configuration option in an initializer:

    HoganAssets::Config.configure do |config|
      config.template_extensions = %w(mustache hamstache stache)
    end


## Usage

Templates are compiled to a global JavaScript object named `HoganTemplates`. To render `pages/person`:

    HoganTemplates['templates/pages/person'].render(context, partials);

# Author

I made this because I <3 **mustache** and want to use it in Rails. Follow me on [Github](https://github.com/leshill) and [Twitter](https://twitter.com/leshill).

# Contributors

* @mdavidn        (Matthew Nelson)  : Remove unnecessary template source
* @ajacksified    (Jack Lawson)     : Configurable file extension
* @mikesmullin    (Mike Smullin)    : hamstache support
* @gleuch         (Greg Leuch)      : Mustache lambdas
* @lautis         (Ville Lautanala) : hamstache fix
* @adamstrickland (Adam Strickland) : Custom template namespace
* @lautis         (Ville Lautanala) : haml_options configuration
* @sars           (Rodion)          : slimstache support
* @apai4                            : YAML configuration
* @AlexRiedler    (Alex Riedler)    : hamstache/slimstache extensions and helper support

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
