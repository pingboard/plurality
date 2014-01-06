# Plurality

Plurality lets you define different sentence pluralizations based on the number of nouns passed to it. 

## Installation

Add this line to your application's Gemfile:

    gem 'plurality'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plurality

## Usage

Plurality relies on on I18n's backend for storing the plural forms.  It also follows I18n's own conventions for storing plurals with the added exception of being able to pluralize up to 1000 sentences instead of the the limitation of the current language.

If you are using Simple backend then below is what your `en.yml` would look like.  The tokens are the ordinals representation of where the noun falls in the array.  They are calculated by the gem [`numbers_and_words`](https://github.com/kslazarev/numbers_and_words).  The `additonal` token is a special one that is calculated based on the number of nouns minus the ordinal tokens used. 
```
en:
  email:
    subject:
      one: "%{first} was added"
      two: "%{first} and %{second} were added"
      other: "%{first}, %{second} and %{additional} others were added"
```

Then you simply call `Plurality.t` or `Plurality.translate` with the array of nouns and it'll spit out the rest for you.  

```
require 'plurality'

users = %w(Evan Rob Bill Josh)

Plurality.t 'email.subject', nouns: users #=> "Evan, Rob and 3 others were added"

```

You may also pass additional options that'll be passed through to `I18n.translate` assuming they don't conflict with the reserved tokens.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
