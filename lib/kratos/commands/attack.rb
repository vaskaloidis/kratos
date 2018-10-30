# frozen_string_literal: true

require_relative '../command'

module Kratos
  module Commands
    class Attack < Kratos::Command
      def initialize(type, options)
        @type = type
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        p = prompt
        config = Kratos::Config.new

        target =
            if config.nil?
              p.ask('Target IP:')
            else
              p.ask('Target IP:', default: config.target)
            end

        anon = p.yes?('Covert Mission?', default: true)

        running = true
        scan_count = 0

        while running
          puts Nmap::SCAN_DESC + " (EXIT to Quit. SWITCH target."
          choices = Nmap::AVAILABLE_SCANS << "exit"
          scan = prompt.multi_select("Scan Mission:", choices)

          if scan == 'exit'
            running = false
          else
            Nmap.send scan.to_sym, target, anon
          end
        end

      end

      def ftp_attack

      end

      def mysql_attack

      end

      def autpwn_attack

      end

    end
  end
end
