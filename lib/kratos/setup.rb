# frozen_string_literal: true

require "thor"
require 'date'

module Kratos
  class Recon < Thor
    include Thor::Actions

    def self.source_root
    end


    desc "KALI", "Setup Kali Docker"

    def kali
      `docker pull kalilinux/kali-linux-docker`
      `docker run -ti kalilinux/kali-linux-docker /bin/bash`
    end


    private

    def install_nmap_scripts
      `git clone https://github.com/vulnersCom/nmap-vulners.git #{File.join(target, 'vulners')}`
      `git clone https://github.com/scipag/vulscan.git #{File.join(target, 'vulscan')}`

      `cd vulscan/utilities/updater/`
      `chmod +x updateFiles.sh`
      `./updateFiles.sh`
    end

  end
end