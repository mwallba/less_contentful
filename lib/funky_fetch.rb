require 'yaml'
require 'contentful'
require 'redis'
require 'contentful_clients'
require 'json'
require 'pry-byebug'

module FunkyFetch
  extend self

  def call
    client = ContentfulClients.online
    first_request = client.entries(limit: 1000, skip: 0, include: 0).object
    total = first_request['total']
    results = (1000..total).each_slice(1000).count.times.each_with_object([first_request]) do |i, arr|
      arr << client.entries(limit: 1000, skip: (i+1)*1000, include: 0).object
    end

    database = results.map { |a| a['items'] }.flatten.each_with_object({}) do |item, hash|
      id = item.dig('sys', 'id')
      hash[id] = item
    end

    first_request = client.assets(limit: 1000, skip: 0, include: 0).object
    total = first_request['total']
    results = (1000..total).each_slice(1000).count.times.each_with_object([first_request]) do |i, arr|
      arr << client.assets(limit: 1000, skip: (i+1)*1000, include: 0).object
    end

    results.map { |a| a['items'] }.flatten.each_with_object(database) do |item, hash|
      id = item.dig('sys', 'id')
      hash[id] = item
    end
  end
end
