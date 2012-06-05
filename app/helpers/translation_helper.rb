module TranslationHelper
  def tt(key, default, options={})
    options[:default] = default
    I18n.t(["pages", controller.controller_name, key].join("."), options)
  end
end