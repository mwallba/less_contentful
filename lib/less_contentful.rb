# frozen_string_literal: true

require 'sinatra'
require 'content'

class LessContentful < Sinatra::Base
  set :public_folder, File.expand_path('public')
  set :views, File.expand_path('views')
  set :database, Content.database

  BASE_CONTENTFUL_API_PATH = '/spaces/:space_id/environments/:environment'
  ENTRIES_PATH = "#{BASE_CONTENTFUL_API_PATH}/entries"
  ENTRY_PATH = "#{BASE_CONTENTFUL_API_PATH}/entries/:entry_id"

  get '/' do
    erb :index, locals: { database: settings.database }
  end

  get '/:entry_id' do
    entry = settings.database[params['entry_id']]
    erb :entry, locals: { entry: entry }
  end

  get(ENTRIES_PATH) do |_space_id, _environment|
    content_type 'application/vnd.contentful.delivery.v1+json'
    # contentful_content_type = params[:content_type]
    entries_response(params: params)
  end

  get(ENTRY_PATH) do |_space_id, _environment, entry_id|
    content_type 'application/vnd.contentful.delivery.v1+json'
    settings.database[entry_id].to_json
  end

  private

  def single_entry_for_entries(params)
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
  end

  def entries_response(params:)
    return single_entry_for_entries(params) if params['sys.id']

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
