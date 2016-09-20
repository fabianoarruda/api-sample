describe API do
  include ApiHelpers

  let!(:page) { create(:page) }
  let!(:tag) { create(:tag, page: page) }

  describe 'GET  /api/v1/pages' do
    it 'returns a list of pages indexed' do
      get "/api/v1/pages"
      expect(response).to have_http_status(200)
      expect(json_response).to be_an Array
      expect(json_response.size).to eq(1)
      expect(json_response.first['url']).to eq(page.url)
    end
  end

  describe 'GET /api/v1/pages/:id' do
    it 'returns a page if found by id' do
      get "/api/v1/pages/#{page.id}"
      expect(response).to have_http_status(200)
      expect(json_response).to be_an Hash
      expect(json_response['url']).to eq page.url
    end

    it 'returns status 404 if not found by id' do
      get "/api/v1/pages/99999999"
      expect(response).to have_http_status(404)
    end

  end

  describe 'GET /api/v1/pages/:id/tags' do
    let!(:tag2) { create(:tag, name: 'a', content: 'example link', page: page)}

    it 'returns a list of all tags indexed for a page' do
      get "/api/v1/pages/#{page.id}/tags"
      expect(response).to have_http_status(200)
      expect(json_response).to be_an Array
      expect(json_response.first['content']).to eq tag.content
    end

    it 'returns a list of tags filtered by tag name' do
      get "/api/v1/pages/#{page.id}/tags?name=#{tag2.name}"
      expect(response).to have_http_status(200)
      expect(json_response).to be_an Array
      expect(json_response.first['name']).to eq tag2.name
    end
  end

  describe 'POST /api/v1/pages' do
    it 'returns indexed page when params correct' do
      post "/api/v1/pages/", url: 'http://cnn.com'
      expect(response).to have_http_status(201)
      expect(json_response['url']).to eq('http://cnn.com')
    end

    it 'returns error 400 if url invalid' do
      post "/api/v1/pages/", url: 'not_an_url'
      expect(response).to have_http_status(400)
    end

  end
end