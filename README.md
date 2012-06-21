# HoganAssets

**HoganAssets** compiles your [mustache](http://mustache.github.com/) templates with [hogan.js](http://twitter.github.com/hogan.js/) on **sprockets** and the Rails asset pipeline.

**hogan.js** is a templating engine developed at [Twitter](http://twitter.com) that follows the **mustache** spec and compiles the templates to JavaScript. The first bit is *cool*, since **mustache** is *cool*. The second bit is **awesome and full of win** because we can now compile our **mustache** templates on the server using the asset pipeline/sprockets.

This gem contains **hogan.js v3.0.0**

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

Templates are named for the sub-path from your manifest with `require_tree`. For example, the file `app/assets/javascripts/templates/pages/person.mustache` will be named `templates/pages/person`. _(TODO: make this nicer)_

### Installation with sprockets

Add this line to your `Gemfile`:

    gem 'hogan_assets'

And then execute:

    $ bundle

Require `hogan.js` somewhere in your JavaScript.

*TODO* Templates?

## Hamstache!

_hamstache_ is the quite popular combination of `haml` and `mustache`, a more robust solution exists using [haml_assets](https://github.com/infbio/haml_assets), but if all you want is nicer markup, you need to take these two additional steps:

Add this line to your `Gemfile`:

    group :assets do
      gem 'haml'
    end

And then execute:

    $ bundle

## Configuration

### Template Extensions

**HoganAssets** recognizes templates ending in `.mustache` and if you have haml available, `.hamstache`. You can change the template extensions by setting the `template_extensions` configuration option in an initializer:

    HoganAssets::Config.configure do |config|
      config.template_extensions = %w(mustache hamstache stache)
    end

### Lambda Support

**HoganAssets** supports **mustache** lambdas. Set the `lambda_support` option to true to enable lambdas for your templates. This will include the raw template text as part of the compiled template; each template will be correspondingly larger.

*TODO* Should this be on by default?

    HoganAssets::Config.configure do |config|
      config.lambda_support = true
    end

## Usage

Templates are compiled to a global JavaScript object named `HoganTemplates`. To render `pages/person`:

    HoganTemplates['templates/pages/person'].render(context, partials);

# Author

I made this because I <3 **mustache** and want to use it in Rails. Follow me on [Github](https://github.com/leshill) and [Twitter](https://twitter.com/leshill).

# Contributors

* @mdavidn     (Matthew Nelson)  :  Remove unnecessary template source
* @ajacksified (Jack Lawson)     :  Configurable file extension
* @mikesmullin (Mike Smullin)    :  hamstache support
* @gleuch      (Greg Leuch)      :  Mustache lambdas
* @lautis      (Ville Lautanala) :  hamstache fix

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
