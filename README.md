`debundle.rb` allows you to require gems that are not in your `Gemfile` when inspecting
programs that are run with Bundler.

**Use at your own risk!**

Paste the code of debundle.rb and you are done! A good place would be your `.irbrc` file
before requiring [irbtools](https://github.com/janlelis/irbtools).

The code is directly taken from [pry-debundle](https://github.com/ConradIrwin/pry-debundle).
Please look there for any further information. This repo exists to simplify debundling
without using the `pry` repl.
