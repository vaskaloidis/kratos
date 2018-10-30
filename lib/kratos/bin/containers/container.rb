require_relative '../shell_command'

module Kratos
  module Docker
    class Container
      include Kratos::ShellCommand
      attr_accessor :running

      def initialize
        build
      end

      def startup(entry = nil)
        args = { detach: true }
        args[:cmd] = "--entrypoint #{entry}" unless entry.nil?
        args[:params] = "#{arguments}" unless arguments.nil?
        run args
      end

      def run(cmd: '', entry: nil, detach: false, rm: false)
        params = "--rm #{arguments}" if rm
        params = "-d #{params}" if detach
        params = "-it #{params}"
        cmd = "--entrypoint #{entry} #{cmd}" unless entry.nil?
        case
        when image.nil? && name.nil? then raise 'Must pass an ATLEAST an image OR container-name'
        when !image.nil? && !name.nil? then shell_execute"docker run -it #{params.spacer}#{name} --name #{image} #{cmd}"
        when !image.nil? then shell_execute"docker run -it #{params.spacer}#{image} #{cmd}"
        when !name.nil? then shell_execute"docker run -it #{params.spacer}#{name} #{cmd}"
        end
      end

      def background_process(cmd)
        run cmd: '', entry: cmd, detach: true
      end

      def exec(cmd, detach: false, rm: false)
        params = "-d #{arguments}" if detach
        params = "--rm #{params}" if rm
        shell_execute"docker exec -it #{params.spacer}#{name} #{cmd}"
      end

      def create_volume(path, name, image)
        shell_execute"docker create -v #{path} --name #{name} #{image} "
      end

      protected

      def docker_build(cmd)
        shell_execute"docker build #{cmd}"
      end

      def arguments
        nil
      end

      def image
        raise 'You must define image in your docker container'
      end

      def name
        raise 'You must define a name in your docker container'
      end

    end
  end
end