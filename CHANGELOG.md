## 1.5.1 (2013-2-26)

* hamstache\_extensions and slimstache\_extensions options - @AlexRiedler
* pass scope and locals to `haml` and `slim` - @AlexRiedler

## 1.5.0 (2013-2-06)

* YAML configuration support - @apai4

## 1.4.0 (2013-1-02)

* **slimstache** support, use `HoganAssets::Config.slim_options` to set options for `slim` - @sars
* Silence tilt require warning

## 1.3.4 (2012-11-09)

* Use `HoganAssets::Config.haml_options` to set options for `haml` - @lautis

## 1.3.3 (2012-09-10)

* Use `HoganAssets::Config.template_namespace` to use a custom namespace for your templates - @adamstrickland

## 1.3.2 (2012-08-04)

* Use `HoganAssets::Config.path_prefix` to strip a common path prefix from your template names

## 1.3.1 (2012-06-21)

* #11 - Fix **hamstache** support, broken in 1.3.0

## 1.3.0 (2012-06-18)

* #9 - Support lambda construct in **mustache**, set via `config.lambda_support = true`
