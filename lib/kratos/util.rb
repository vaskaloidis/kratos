require 'yaml' # Built in, no gem required
require 'fileutils'

module Kratos
  module Util

    def config_dir
      File.join Dir.home, '/.kratos'
    end

    def config_file
      File.join config_dir, 'config.yml'
    end

    def config_exists?
      File.exists? config_file
    end

    def load_config_data
      YAML::load_file config_file if config_exists?
      c Kratos::Config.new
      c.target = load_config_data['configuration']['target']
      c
    end

    def save_config_data(data)
      Dir.mkdir kratos_dir, "0700" unless Dir.exists? config_dir
      FileUtils.touch  config_file unless config_exists?
      File.write config_file, data.to_yaml
    end

  end
end