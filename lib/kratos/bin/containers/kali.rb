module Kratos
  module Docker
    class Kali < Container
      include Volumes

      METASPLOIT_VOLUME = true
      METASPLOIT_SCRIPTS_VOLUME = true
      KALI_ROOT_VOLUME = true


      def install
        create_volume scripts_path, scripts_volume_name, image

        background_process 'tor'

        startup entrypoint
      end

      def build
        "-t #{image} ."
      end

      def image
        "kratos/kali:1.0"
      end

      def name
        "kali"
      end

      def entrypoint
        "/bin/bash"
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
        "-p 80:80 -p 3000:3000 -p 3001:3001"
      end

      def volume_arguments
        volume = ""
        volume = "-v #{kali_root} #{volume}" if KALI_ROOT_VOLUME
        volume = "-v #{metasploit_scripts} #{volume}" if METASPLOIT_SCRIPTS_VOLUME
        volume
      end

    end
  end
end