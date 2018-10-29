module Kratos
  module Nmap
    include Kratos::Bin
    attr_accessor :nmap_scripts

    def nmap_scripts
      @nmap_scripts ||= '/usr/share/nmap/scripts/'
    end

    def script_scan(target, script)
      script = File.basename script, '.nse' if script.end_with? '.nse'
      nmap "-p80,443 --script http-waf-fingerprint #{target}"
    end

    def finterprint_webapp(target)
      nmap "-p80,443 --script http-waf-fingerprint #{target}"
    end

    def webapp_firewall_detect(target)
      nmap "-p80,443 --script http-waf-detect --script-args='http-waf-detect.aggro,http-waf-detect.detectBodyChanges' #{target}"
    end

    def vulners_scripts(target)
      nmap "--script nmap-vulners -sV  #{target}", export: 'vulners'
    end

    def vulscan_scripts(target, database = nil)
      if database.nil?
        nmap "--script vulscan -sV  #{target}", export: 'vulscan'
      else
        database += '.csv' unless database.end_with? '.csv'
        nmap "--script-vulscan --script-args vulscandb=#{database} -sV #{target}"
      end
    end


    def full_scan(target)
      target += '.csv' unless target.end_with? '.csv'
      nmap "--script nmap-vulners,vulscan -v --script-args vulscandb=scipvuldb.csv -sV ${target}", export: 'full'
    end

    def list_vulscan(location = nmap_script)
      Dir.glob "*.nse", File.join(nmap_scripts, 'vulscan')
    end

    def list_vulscan_database
      Dir.glob "*.csv", File.join(nmap_scripts, 'vulscan')
    end

    def list_vulners
      Dir.glob "*.nse", File.join(nmap_scripts, 'vulners')
    end

    def list_nmap_scripts
      Dir.glob "*.nse", File.nmap_scripts
    end

    def http_errors(target)
      nmap "-p80,443 --script http-errors #{target}"
    end

    def dns_brute_force(target)
      nmap "-p80,443 --script dns-brute #{target}"
      #   nmap -p80,443 --script dns-brute --script-args dns-brute.threads=25,dns-brute.hostlist=/root/Desktop/custom-subdomain-wordlist.txt targetWebsite.com
    end

    def exif_data(target)
      nmap "-p80,443 --script http-exif-spider #{target}"
    end

  end
end