module Kratos
  module Volumes

    def kali_root
      "/home/kali:/root"
    end

    def metasploit_framework
      "/home/metasploit:/usr/share/metasploit-framework"
    end

    def metasploit_scripts
      "#{host_scripts_path}:/usr/share/metasploit-framework/scripts"
    end

    def metasploit_home_path
      "/home/$(whoami)/.msf4:/root/.msf4"
    end

    def metasploit_temp
      "/tmp/msf:/tmp/data"
    end

  end
end