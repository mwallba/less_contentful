# frozen_string_literal: true

require 'contentful'

module ContentfulClients
  module_function

  def environment
    ENV['RACK_ENV'] || 'development'
  end

  def credentials
    YAML.load_file('config.yml').dig(environment, :delivery)
  rescue Errno::ENOENT
    raise 'Contentful credentials file (config.yml) is missing!'
  end

  def local
    Contentful::Client.new(
      api_url: 'localhost:9292',
      space: 'random_space_id',
      access_token: 'random_token',
      secure: false
    )
  end

  def online
    Contentful::Client.new(
      space: credentials[:space],
      access_token: credentials[:access_token],
      raw_mode: true
    )
  end
end
