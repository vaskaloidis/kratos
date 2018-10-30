module Kratos
  module Docker
    class Metasploit < Container
      METASPLOIT_VOLUME = true
      METASPLOIT_HOME_VOLUME = true
      TMP_VOLUME = true


      def build
      end

      def run(cmd)
        run(cmd: cmd, params: arguments, image: image, name: name, it: true, rm: true)
      end

      def image
        "phocean/msf"
      end

      def name
        "msf"
      end

      def arguments
        "#{port_argument} #{volume_argument}"
      end

      private

      def scripts_volume_name
        "kali-scripts"
      end

      def host_scripts_path
        "/opt/metasploit-framework/embedded/framework/scripts"
      end

      def port_argument
        "-p 9990-9999:9990-9999"
      end

      def volume_argument
        volume = ""
        volume = "-v #{metasploit_volume_path} " if METASPLOIT_HOME_VOLUME
        volume = "-v #{metasploit_scripts} #{volume}" if METASPLOIT_VOLUME
        volume = "-v #{metasploit_temp} #{volume}" if TMP_VOLUME
        volume
      end

    end
  end
end