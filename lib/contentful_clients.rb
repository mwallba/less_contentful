require 'contentful'

module ContentfulClients
  extend self

  def credentials
    YAML.load_file('config.yml').dig('development', :delivery)
  rescue Errno::ENOENT
    fail 'Contentful credentials file (config.yml) is missing!'
  end

  def local
    Contentful::Client.new(
      api_url: 'localhost:9292',
      space: 'random_space_id',
      access_token: 'random_token',
      secure: false,
      raw_mode: true
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
