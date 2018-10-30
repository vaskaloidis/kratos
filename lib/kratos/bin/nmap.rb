require_relative "bin"

module Kratos
  module Nmap
    include Kratos::Bin
    attr_accessor :nmap_scripts
    NMAP_DEFAULT_PATH = '/usr/bin/nmap'
    SINGLE_SCANS = %w[basic_target_scan advanced_target_scan_t4 advanced_target_scan_t5 samba_exploit_scan fingerprint_webapp webapp_firewall_detect vulners_scripts vulscan_scripts full_scan list_vulscan list_vulscan_database list_vulners list_vulscan_database list_vulners list_nmap_scripts http_errors dns_brute_force exif_data]
    MULTI_SCANS = %w[basic_network_scan]

    def nmap_location
      NMAP_DEFAULT_PATH

    end

    def basic_network_scan(target, anon = false)
      nmap "-sP #{target}", anon: anon
    end

    def basic_target_scan(target, anon = false)
      nmap "-p 1-65535 -sV -sS -T4 #{target}", anon: anon
    end

    def advanced_target_scan_t4(target, anon = false)
      nmap "-v -p 1-65535 -sV -O -sS -T4 #{target}", anon: anon
    end

    def advanced_target_scan_t5(target, anon = false)
      nmap "-v -p 1-65535 -sV -O -sS -T5 #{target}", anon: anon
    end

    def samba_exploit_scan(target, anon = false)
      nmap "--script-args=unsafe=1 --script smb-check-vulns.nse -p 445 #{target}", anon: anon
    end

    # TODO: This is not implemented (extra script arg)
    def script_scan(target, script, anon = false)
      script = File.basename script, '.nse' if script.end_with? '.nse'
      nmap "-p80,443 --script #{script} #{target}", anon
    end

    def fingerprint_webapp(target, anon = false)
      nmap "-p80,443 --script http-waf-fingerprint #{target}", anon: anon
    end

    def webapp_firewall_detect(target, anon = false)
      nmap "-p80,443 --script http-waf-detect --script-args='http-waf-detect.aggro,http-waf-detect.detectBodyChanges' #{target}", anon: anon
    end

    def vulners_scripts(target, anon = false)
      nmap "--script nmap-vulners -sV  #{target}", anon: anon, export: 'vulners'
    end

    def vulscan_scripts(target, database = nil)
      if database.nil?
        nmap "--script vulscan -sV  #{target}", anon: anon, export: 'vulscan'
      else
        database += '.csv' unless database.end_with? '.csv'
        nmap "--script-vulscan --script-args vulscandb=#{database} -sV #{target}", anon: anon
      end
    end

    def full_scan(target, anon = false)
      target += '.csv' unless target.end_with? '.csv'
      nmap "--script nmap-vulners,vulscan -v --script-args vulscandb=scipvuldb.csv -sV ${target}", export: 'full'
    end

    def list_vulscan(location = nmap_script)
      location = File.join(nmap_scripts, 'vulscan')
      command "ls -lra #{location} | grep .nse"
    end

    def list_vulscan_database
      location = File.join(nmap_scripts, 'vulscan')
      command "ls -lra #{location} | grep .csv"
    end

    def list_vulners
      location = File.join(nmap_scripts, 'vulners')
      command "ls -lra #{location} | grep .nse"
    end

    def list_nmap_scripts
      Dir.glob "*.nse", File.nmap_scripts
    end

    def script_info(script)
      nmap "--script-help='#{script}'"
    end

    def http_errors(target, anon = false)
      nmap "-p80,443 --script http-errors #{target}", anon: anon
    end

    def dns_brute_force(target, anon = false)
      nmap "-p80,443 --script dns-brute #{target}", anon: anon
      #   nmap -p80,443 --script dns-brute --script-args dns-brute.threads=25,dns-brute.hostlist=/root/Desktop/custom-subdomain-wordlist.txt targetWebsite.com
    end

    def exif_data(target, anon = false)
      nmap "-p80,443 --script http-exif-spider #{target}", anon: anon
    end

    SCAN_DESCRIPTION = {
        "webapp TARGET": "Web-Application Fingerprint",
        "webapp_firewall_detect TARGET": "Web-Application Firewall Detection",
        "script_scan TARGET SCRIPT": "Scan using a specified nmap script",
        "list_vulscan": "List VulScan Scripts",
        "list_vulscan_database": "List VulScan Databases",
        "list_vulners": "List Vulners Scripts",
        "list_nmap_scripts": "List Nmap Scripts",
        "vulners_scripts TARGET": "Vulners Scan",
        "vulscan TARGET DATABASE=nil": "Vulscan scan all databases (optional scan a specified vulscan database)",
        "full_scan TARGET": "Web-Application Full Scan",
        "http_errors TARGET": "HTTP-Errors Scan",
        "dns_brute_force TARGET": "DNS Brute Force Scan",
        "exif_data TARGET": "EXIF Photo Data Scan"}

  end
end