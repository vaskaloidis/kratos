module Kratos
  class Config
    include Kratos::Util
    attr_accessor :target, :data, :recent_targets

    def initialize
      if config_exists?
        @data = load_config_data
        @target = @data['configuration']['target'] unless @data['configuration']['target'].nil?
        @target = @data['configuration']['recent_targets'] unless @data['configuration']['recent_targets'].nil?
      else
        @target = nil # Scrap
        @recent_targets = nil # Scrap
        @data = {}
        @data['configuration'] = {}
        @data['configuration']['target'] = nil # Scrap
        @data['configuration']['recent_targets'] = nil # Scrap
      end
    end

    def save!
      unless @target.nil?
        data['configuration']['target'] = @target

        if data['configuration']['recent_targets'].nil?
          data['configuration']['recent_targets'] = [@target]

        elsif !data['configuration']['recent_targets'].include? @target
          data['configuration']['recent_targets'] << @target
        end

        save_config_data data
      end
    end

  end
end