`debundle` allows you to require gems that are not in your `Gemfile` when inspecting
programs that are run with Bundler.

Usage
=====

Paste the code of debundle.rb and you are done! A good place would be your `.irbrc` file
before requiring [irbtools](https://github.com/janlelis/irbtools). Use at your own risk!


pry-debundle
============

The code is directly taken from [pry-debundle](https://github.com/ConradIrwin/pry-debundle).
Please look there for any further information. This repo exists to simplify debundling
without using `pry`.

Meta-fu
=======

Licensed under the MIT license (see `LICENSE.MIT`). Bug reports and pull requests are
welcome.

It's possible that Bundler will solve this issue themselves, in which case I expect to
deprecate this gem. See https://github.com/carlhuda/bundler/issues/183 for some
discussion.
