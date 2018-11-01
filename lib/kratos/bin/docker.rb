module Kratos
  module Docker
    include Bin
    attr_accessor :containers_running, :command_result

    def self.included(base)
      @containers_running = {}
    end

    def initialized
      @initialized = false
    end

    def run(cmd, persist: false, container_name: nil)
      if persist
        rm = ''
        if container_name.nil?
          raise 'You must'
        end
      else
        rm = '--rm '
        container_name = name
      end

      docker "run #{rm}-it #{port_argument} #{home_volume} #{temp_volume} --name #{container_name} #{image} #{cmd}"
      containers_running[container_name] = command_result.output
    end

    # docker restart msf
    # docker attach msf
    # docker rm msf

    def background(cmd, entrypoint: "/bin/bash -c")
      docker "exec -it #{name} #{entrypoint} #{cmd}"
    end

    def build
      docker "build -t #{image} ."
    end

    def pull
      docker "pull #{image}"
    end

    protected

    def docker(cmd)
      command_result = execute_cmd "docker #{cmd}"
      command_result
    end

  end
end