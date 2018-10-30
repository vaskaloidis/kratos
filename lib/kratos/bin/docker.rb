module Kratos
  module Docker
    DOCKER_NAME = 'kali'

    attr_accessor :metasploit, :kali, :empire

    def docker(cmd)
      kali
    end


    def metasploit
      @metasploit ||= Metasploit.new
    end

    def kali
      @kali ||= Kali.new
    end

    def empire
      @empire ||= Empire.new
    end


    def docker_kali(cmd)
      docker_run cmd, params: "-p 9990-9999:9990-9999 #{msf_volumes}", image: "phocean/msf", name: 'msf'
    end

    def docker_empire(cmd)
      ""
    end

    class String
      def spacer
        self + ' ' if self == ''
      end
    end

    private

  end
end