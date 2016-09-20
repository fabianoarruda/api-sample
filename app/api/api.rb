require 'open-uri'
class API < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  helpers do
    def get_tags(tag_type)
      @doc.css(tag_type).each do |t|
        tag = Tag.new(content: t.text)
        tag.name = tag_type
        @page.tags << tag
      end
    end
  end

  # If a invalid url is provided Nokogiri will raise Errno::ENOENT. We intercept it and return a nice error message.
  rescue_from Errno::ENOENT do
    error!('Invalid url.', 400)
  end

  # Rescue from inexistent records.
  rescue_from ActiveRecord::RecordNotFound do
    rack_response({ 'message' => '404 Not found' }.to_json, 404)
  end


  resource :pages do
    desc 'Return a list of Pages.'
    get do
      Page.all
    end

    desc 'Return a specific page by id.'
    route_param :id do
      get do
        Page.find params[:id]
      end

      resource :tags do
        desc 'Return all tags indexed on a given page. Can by optionally filtered by tag name'
        params do
          optional :name, type: String, desc: 'Tag name to filter.'
        end
        get do
          if params[:name].present?
            Page.find(params[:id]).tags.where(name: Tag.names[params[:name]])
          else
            Page.find(params[:id]).tags
          end

        end

      end

    end

    desc 'Receive an url and index its contents.'
    params do
      requires :url, type: String, desc: 'url to be parsed.'
    end
    post do
      # First we try to open the url, if it suceeds, its valid and we can proceed. If its invalid a error will be raised.
      @doc = Nokogiri::HTML(open(params[:url]))
      @page = Page.new(url: params[:url])
      get_tags('h1')
      get_tags('h2')
      get_tags('h3')
      get_tags('a')

      @page.save
      present @page
    end

  end

end