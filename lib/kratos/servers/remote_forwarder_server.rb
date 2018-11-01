module Kratos
  module Server
    class ReverseForwarderServer


      def call
        Net::SSH.start("remote_host", "remote_user") do |ssh|
          ssh.forward.remote(22, "localhost", 43210)
          ssh.loop { true }
        end
      end


    end
  end
end