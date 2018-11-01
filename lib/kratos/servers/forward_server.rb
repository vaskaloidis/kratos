module Kratos
  module Server
    class ForwardServer


      def call
        require 'net/ssh'

        Net::SSH.start("remote_host", "remote_user") do |ssh|
          ssh.forward.remote(4567, "localhost", 43210)
          ssh.loop { true }
        end

      end
    end
  end
end