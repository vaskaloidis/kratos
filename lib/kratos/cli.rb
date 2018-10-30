# frozen_string_literal: true

require 'thor'

module Kratos
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'kratos version'
    def version
      require_relative 'version'
      puts "v#{Kratos::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'attack [TYPE]', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def attack(type = nil)
      if options[:help]
        invoke :help, ['attack']
      else
        require_relative 'commands/attack'
        Kratos::Commands::Attack.new(type, options).execute
      end
    end

    desc 'recon', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def recon(*)
      if options[:help]
        invoke :help, ['recon']
      else
        require_relative 'commands/recon'
        Kratos::Commands::Recon.new(options).execute
      end
    end
  end
end
