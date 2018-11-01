# docker run --rm -it --net=host --hostname msf -v /home/<USER>/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data --name msf phocean/msf

module Kratos
  module Metasploit
      include Docker

    def image
      "phocean/msf"
    end

    def name
      "msf"
    end

    def host_scripts_path
      "/opt/metasploit-framework/embedded/framework/scripts"
    end

    def port
      "-p 9990-9999:9990-9999"
    end

    def volume
      "#{home_volume} #{temp_volume}"
    end

    private

    def home_volume
      "-v /home/$(whoami)/.msf4:/root/.msf4"
    end

    def temp_volume
      "-v /tmp/msf:/tmp/data"
    end

  end
end