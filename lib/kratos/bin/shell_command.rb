require 'tty-command'

module Kratos
  module ShellCommand
    ANON_DEFAULT = false # TODO: Replace with config

    attr_accessor :ttycmd, :commands, :log, :anon

    def shell_execute(cmd, anon: ANON_DEFAULT)
      cmd = proxychain cmd if anon
      result = ttycmd.run cmd

      commands << cmd if result.success?
      log << result.out

      OpenStruct.new(command: cmd, error: result.err, output: result.out, success?: result.success?)
    end

    def commands
      @commands ||= []
    end

    def ttycmd
      @ttycmd ||= TTY::Command.new
    end

  end
end