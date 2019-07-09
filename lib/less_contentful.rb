# frozen_string_literal: true

require 'sinatra'
require 'content'

class LessContentful < Sinatra::Base
  set :public_folder, File.expand_path('public')
  set :views, File.expand_path('views')
  set :database, Content.database

  get '/' do
    erb :index, locals: { database: settings.database }
  end

  get '/:entry_id' do
    entry = settings.database[params['entry_id']]
    erb :entry, locals: { entry: entry }
  end

  get '/spaces/:space_id/environments/:environment/entries' do |space_id, environment|
    content_type 'application/vnd.contentful.delivery.v1+json'
    contentful_content_type = params[:content_type]
    if params['sys.id']
      item = settings.database[params['sys.id']]
      {
        sys: {
          type: 'Array'
        },
        total: 1,
        skip: 0,
        limit: 1,
        items: [item]
      }.to_json
    else
      items = settings.database.values
      {
        sys: {
          type: 'Array'
        },
        total: items.count,
        skip: 0,
        limit: items.count,
        items: items
      }.to_json
    end
  end

  get '/spaces/:space_id/environments/:environment/entries/:entry_id' do |space_id, environment, entry_id|
    content_type 'application/vnd.contentful.delivery.v1+json'
    settings.database[entry_id].to_json
  end
end
