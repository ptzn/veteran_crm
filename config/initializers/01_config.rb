config_file = ActiveSupport::ConfigurationFile.new("#{Rails.root.to_s}/config/config.yml").parse
Config = JSON.parse(config_file[Rails.env].to_json, object_class: HashWithIndifferentAccess).freeze
