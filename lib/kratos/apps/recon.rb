# frozen_string_literal: true

require "nmap"
require "bin"

require "thor"
require 'date'
require 'tmpdir' # Not needed if you are using rails.
require "thor/zsh_completion"

module Kratos
  class Recon < Thor
    include Thor::Actions
    include ZshCompletion::Command

    include Kratos::Nmap


    def self.source_root
      __FILE__
    end


    # Create an initial web-app scan then follow-up based on findings
    # v1 - Initial: Racoon, NMAP-Vulners, Nikto(opt flag), Wikto (opt flag), open_vas, nessus, armitage attack vectors
    # - FTP
    # - SQL Injection sqlmap
    # - XSS Vuln scan

    # v2- Create a client scan
    # - LAN Scanning
    # - WIFI Scanning
    # - NMAP Zombie Scan


    desc "webapp TARGET", "Web-Application Fingerprint"

    desc "webapp_firewall_detect TARGET", "Web-Application Firewall Detection"

    desc "script_scan TARGET SCRIPT", "Scan using a specified nmap script"

    desc "list_vulscan", "List VulScan Scripts"

    desc "list_vulscan_database", "List VulScan Databases"

    desc "list_vulners", "List Vulners Scripts"

    desc "list_nmap_scripts", "List Nmap Scripts"

    desc "vulners_scripts TARGET", "Vulners Scan"

    def vulners(target)
      vulners_scripts target
    end

    desc "vulscan TARGET DATABASE=nil", "Vulscan scan all databases, (optional) scan specified vulscan database. list_vulscan to list databases"

    def vulscan(target, database)
      vulscan_scripts target, database
    end

    desc "full_scan TARGET", "Web-Application Full Scan"

    desc "http_errors TARGET", "HTTP-Errors Scan"

    desc "dns_brute_force TARGET", "DNS Brute Force Scan"

    desc "exif_data TARGET", "EXIF Photo Data Scan"


  end
end