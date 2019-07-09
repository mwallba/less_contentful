require 'funky_fetch'

module Content
  extend self

  def delete(entry_id); end

  def create(entry_id, data); end

  def read(entry_id); end

  def update(entry_id, data); end

  def database
    cached_data = redis.get('less_contentful/database')
    puts "Using cached data..." if cached_data
    return JSON.parse(cached_data) if cached_data
    new_data = FunkyFetch.call
    redis.set('less_contentful/database', new_data.to_json)
    puts "Using new data..."
    new_data
  end

  def redis
    Redis.new
  end
end
