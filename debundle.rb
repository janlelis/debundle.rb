### START debundle.rb ###

# MIT License
# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com>
# Copyright (c) Jan Lelis <mail@janlelis.de>

module Debundle
  VERSION = '1.0.0'

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

