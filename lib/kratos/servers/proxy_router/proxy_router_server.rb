require 'proxymachine'

module Kratos
  module Server

    class ProxyRouterServer

      def initialize

      end

      def git_stream_header_router

        # Perform content-aware routing based on the stream data. Here, the
        # header information from the Git protocol is parsed to find the
        # username and a lookup routine is run on the name to find the correct
        # backend server. If no match can be made yet, do nothing with the
        # connection.
        proxy do |data|
          if data =~ %r{^....git-upload-pack /([\w\.\-]+)/[\w\.\-]+\000host=\w+\000}
            name = $1
            {:remote => GitRouter.lookup(name)}
          else
            {:noop => true}
          end
        end

      end

    end
  end
end