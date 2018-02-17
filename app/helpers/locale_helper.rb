module LocaleHelper
  def set_locale # Sets the users language via the locale index.
    if current_user && current_user.language != I18n.locale.to_s
      I18n.locale = current_user.language
    elsif !current_user
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales) || 'en'
    end
  end
end
