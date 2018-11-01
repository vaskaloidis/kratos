require_relative 'shell_command'
# require_relative 'docker'

module Kratos
  module Bin
    include Kratos::ShellCommand
    attr_accessor :anon

    ANON_DEFAULT = false # TODO: Replace with config
    DEFAULT_OUTPUT = '/tmp/'

    def proxychain(cmd)
      execute_cmd "proxychain #{cmd}"
    end

    def msf_nmap(cmd)
      execute_cmd "nmap #{cmd}"
    end

    def msf_nmap(cmd)
      execute_cmd msf "db_nmap #{cmd}"
    end

    def msf(cmd)
      execute_cmd "mfsconsole -x #{cmd}"
    end

    def nmap(cmd, query: false, anon: ANON_DEFAULT, export: nil, location: DEFAULT_OUTPUT)
      result =
          if export.nil?
            "nmap #{cmd}"
          else
            raise 'Export param must be set to desired output filename' unless export.is_a? String
            export += '.xml' unless export.end_with? '.xml'
            file = File.join location, export
            "nmap -oX #{file} #{cmd}"
          end
      if query
        result
      else
        execute_cmd query
      end
    end

    def docker(cmd)
      execute_cmd "docker #{cmd}"
    end

    def execute_cmd(cmd, **args)
      shell_execute cmd, args
    end


  end
end