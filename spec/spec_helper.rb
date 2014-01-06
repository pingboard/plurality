require 'plurality'

I18n.config.enforce_available_locales = true
I18n.load_path = Dir[File.dirname(__FILE__) + '/fixtures/*.yml']
I18n.backend.load_translations
I18n.locale = :en
