# frozen_string_literal: true

require_relative '../command'
require_relative "../util"
require_relative "../config"
require_relative "../bin/nmap"


module Kratos
  module Commands
    class Recon < Kratos::Command
      include Kratos::Util
      include Kratos::Nmap

      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        config = Config.new

        target =
            if config.nil?
              prompt.ask('Target IP:')
            else
              prompt.ask('Target IP:', default: config.target)
            end
        if config.nil? || config.target != target
          prompt.say "Saving target #{target}"
          config.target
          save_outcome = config.save!
          if save_outcome
            prompt.ok "Target Save Succesful!"
          else
            prompt.error "Error saving target"
          end
          prompt.say "Target Save Data: #{save_outcome}" # DEBUGGING

        end

        anon = prompt.yes?('Covert Mission?', default: true)

        running = true

        while running

          operation = prompt.select("Operation:", %w(scan scan-descriptions list-vulners list-vulscan list-nmap-scripts))

          case operation
          when 'list-vulners' then
            Nmap::list_vulners

          when 'list-vulscan' then
            Nmap::list_vulscan

          when 'list-vulscan-database' then
            Nmap::list_vulscan_database

          when 'list-nmap-scripts' then
            Nmap::list_nmap_scripts

          when 'exit' then
            running = false

          when 'scan'

            actively_scanning = true

            if target.include? '/'
              choices = Nmap::MULTI_SCANS << "exit" << "switch"
            else
              choices = Nmap::SINGLE_SCANS << "exit" << "switch"
            end

            while actively_scanning
              scan_selected = prompt.select("Scan Mission:", choices)

              if scan_selected == 'exit'
                running = false
              elsif scan_selected == 'switch'
                actively_scanning = false
              else
                scan_cmd = nmap scan_selected target, query: true
                prompt.warn "CMD: #{scan_cmd}"

                if prompt.yes? "Execute?"
                  result = send scan_selected.to_sym, target, anon

                  if result.success?
                    prompt.ok "Scan Successful!"
                    prompt.say result.output
                  else
                    prompt.error "Scan error"
                    prompt.say result.error
                  end
                else
                  prompt.warn "Scan aborted"
                end
              end
            end
          end
        end

      end

    end
  end
end
