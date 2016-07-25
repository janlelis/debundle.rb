### START debundle.rb ###

# MIT License
# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com>
# Copyright (c) Jan Lelis <mail@janlelis.de>

module Debundle
  VERSION = '1.1.0.pre'

  def self.debundle!
    if Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
      ENV.replace(Bundler::EnvironmentPreserver.new(ENV, %w(GEM_PATH)).backup) if defined? Bundler::EnvironmentPreserver
      Gem.clear_paths
      load 'rubygems/core_ext/kernel_require.rb'
      load 'rubygems/core_ext/kernel_gem.rb'
    end
  rescue => e
    warn "DEBUNDLE.RB FAILED: #{e.class}\n#{e.message}"
  end
end

Debundle.debundle!

### END debundle.rb ###

