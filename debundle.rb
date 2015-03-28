### START debundle.rb ###

# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com> -- MIT License
# Source: https://github.com/ConradIrwin/pry-debundle
# Pry references removed by Jan Lelis <mail@janlelis.de>

module Debundle
  VERSION = '1.0.0'

  # Break out of the Bundler jail.
  #
  # This can be used to load files in development that are not in your Gemfile (for
  # example if you want to test something with a tool that you have locally).
  #
  # @example
  #   Debundle.debundle!
  #   require 'all_the_things'
  #
  # See https://github.com/carlhuda/bundler/issues/183 for some background.
  # 
  def self.debundle!
    return unless defined?(Bundler)
    raise ArgumentError, 'gem version below 2.0 not supported' unless Gem::VERSION.to_i >= 2

    if Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
      Bundler.preserve_gem_path
      Gem.clear_paths
      Gem::Specification.reset
      load 'rubygems/core_ext/kernel_require.rb'
      remove_bundler_monkeypatches
    end
  rescue => e
    puts "Debundling failed: #{e.message}"
    puts "When reporting bugs to https://github.com/janlelis/debundle.rb, please include:"
    puts "* gem version: #{Gem::VERSION rescue 'undefined'}"
    puts "* bundler version: #{Bundler::VERSION rescue 'undefined'}"
    puts "* ruby version: #{RUBY_VERSION rescue 'undefined'}"
    puts "* ruby engine: #{RUBY_ENGINE rescue 'undefined'}"
  end

  def self.remove_bundler_monkeypatches

    Kernel.module_eval do
      def gem(gem_name, *requirements) # :doc:
        skip_list = (ENV['GEM_SKIP'] || "").split(/:/)
        raise Gem::LoadError, "skipping #{gem_name}" if skip_list.include? gem_name
        spec = Gem::Dependency.new(gem_name, *requirements).to_spec
        spec.activate if spec
      end
    end
  end
end

Debundle.debundle!

### END debundle.rb ###

