#!/usr/bin/env ruby
require "dato"
require 'dotenv'
require 'pathname'
require 'yaml'

def header(msg)
  puts "\n\n--------------------------------------"
  puts "==> #{msg}"
  puts "--------------------------------------"
end

def slugify(c, suffix="")
  if c.present?
    s = suffix.present? ? "-#{suffix}" : ""
    "#{c.parameterize}#{s}"
  else
    nil
  end
end

# Connect to DatoCms through .env
header("DatoCMS Connect")
Dotenv.load
puts ENV["DATO_API_TOKEN_RW"]
client = Dato::Site::Client.new(ENV["DATO_API_TOKEN_RW"])
puts client

# Load models data via config YAML file
@exec_path = Pathname.new($0).realpath().sub("datocms_slugify.rb", "")
@config_file = "#{@exec_path}config.yml"
yml     = YAML.load_file(@config_file)

# Execute the script!
header("Models")
@models  = yml["models"]
@models.each do |k, model|
  puts "Model #{k} with ID #{model["model_id"]}"
  puts "Slug from field: #{model["original_field"]}"
  puts "-------"
  client.items.all(
    "filter[type]": model["model_id"],
    "page[limit]": 2000
  ).each do |item|
    if !item["slug"].present?
      from_field = item[model['original_field']]
      new_slug = slugify(from_field, item['id'])

      puts "Update Slug: #{from_field}"
      puts new_slug

      client.items.update(item['id'],
        slug: new_slug
      )
      puts "-----------------------"
    end
  end
end
