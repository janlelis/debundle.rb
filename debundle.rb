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
      load 'rubygems/core_ext/kernel_gem.rb'
    end
  rescue => e
    warn "DEBUNDLE.RB FAILED: #{e.class}\n#{e.message}"
  end
end

Debundle.debundle!

### END debundle.rb ###

