module Kratos
  module Bin
    attr_accessor :ttycmd, :commands, :log, :anon

    def anon
      @anon ||= true
    end

    DEFAULT_OUTPUT='/tmp/'

    def proxychain(cmd)
      command "proxychain #{cmd}"
    end

    def msf_nmap(cmd)
      command "nmap #{cmd}"
    end

    def msf_nmap(cmd)
      command msf "db_nmap #{cmd}"
    end

    def msf(cmd)
      command "mfsconsole -x #{cmd}"
    end

    def nmap(cmd, export: nil, location: DEFAULT_OUTPUT)
      if export.nil?
        command "nmap #{cmd}"
      else
        raise 'Export param must be set to desired output filename' unless export.is_a? String
        export += '.xml' unless export.end_with? '.xml'
        file = File.join location, export
        command "nmap -oX #{file} #{cmd}"
      end
    end

    def command(cmd)
      result =
          if anon
            ttycmd.run proxychain cmd
          else
            ttycmd.run cmd
          end
      commands << cmd if result.success?
      log << result.out

      if result.success?
        result.out
      else
        result.err + result.out
      end
    end

    def commands
      @commands ||= []
    end

    def ttycmd
      @ttycmd ||= TTY::Command.new
    end

  end
end