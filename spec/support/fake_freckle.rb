require 'sinatra/base'
require 'sinatra/namespace'

class FakeFreckle < Sinatra::Base
  register Sinatra::Namespace

  set :port, 443

  namespace '/v2' do
    namespace '/projects' do
      get do
        json_response 200, 'projects'
      end

      get '/:id' do
        json_response 200, 'projects/37396'
      end
    end
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code

    File.open("#{File.dirname(__FILE__)}/fixtures/#{file_name}.json", 'rb').read
  end
end
