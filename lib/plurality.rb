require "plurality/version"
require "numbers_and_words"

module Plurality
  extend self

  class MissingPluralData < ArgumentError
  end

  ORDINALS = (1..1000).each_with_object({}) { |i, h| h[i] = i.to_words(ordinal: true) }
  WORDS = (1..1000).each_with_object({}) { |i, h| h[i] = i.to_words.to_sym }

  TOKENS = /%?%\{([^\}]+)\}/

  def translate(*args)
    options = args.last.is_a?(Hash) ? args.pop.dup : {}
    key = args.shift
    nouns = options.delete(:nouns).to_a
    translations = I18n.t!(key, scope: options[:scope])
    numbers = translations.keys
    other = numbers.delete(:other)
    count = nouns.count
    threshold = WORDS.key(numbers.last)

    if other.nil? || count <= threshold
      number = WORDS[count]
      string = translations[number]
    else
      number = :other
      string = translations[:other]
    end

    raise MissingPluralData, "Missing for #{WORDS[count]} nouns" if string.nil?

    options[:scope] = generate_scope key, options[:scope]  
    options[:additional] = calculate_additonal(count, string)
    options.merge! ordinalized_nouns(nouns, threshold)

    I18n.t number, options
  end
  alias :t :translate

  private

    def calculate_additonal(count, string)
      tokens = string.scan(TOKENS).flatten.count { |t| ORDINALS.has_value? t }
      count - tokens
    end

    def generate_scope(key, scope)
      I18n.normalize_keys(nil, key, scope)
    end

    def ordinalized_nouns(nouns, number)
      Hash[ORDINALS.values.take(number).map(&:to_sym).zip(nouns.take(number))].delete_if { |k, v| v.nil? }
    end

end
