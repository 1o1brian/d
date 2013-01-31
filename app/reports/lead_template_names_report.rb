require 'yaml'

class LeadTemplateNamesReport < Dossier::Report

  attr_accessor :created_at_greater_than, :created_at_less_than, :name_like

  @@db_config = YAML.load(File.read(File.join(Rails.root, 'config', 'dossier.yml')))

  def sql
    q = LeadTemplate.select([:id, :name, :created_at, :updated_at])
    unless (options["created_at_greater_than"].empty?)
      date = Date.parse(options["created_at_greater_than"])
      q = q.where('created_at > ?', date)
    end
    unless (options[:name_like].empty?)
      q = q.where('name like ?', "%#{options['name_like']}%")
    end
    q.to_sql
  end

  def dossier_client
    Dossier::Client.new(@@db_config["development"])
  end

end
