require 'net/http'

require 'freckle_api/coercions.rb'
require 'freckle_api/model.rb'
require 'freckle_api/import.rb'
require 'freckle_api/group.rb'
require 'freckle_api/invoice.rb'
require 'freckle_api/user.rb'
require 'freckle_api/project.rb'
require 'freckle_api/timer.rb'

class FreckleApi
  BASE_URI = URI('https://api.letsfreckle.com/v2').freeze
  USER_AGENT = 'freckle-api' # TODO: make this flexible?

  def initialize(api_key)
    @api_key = api_key
  end

  def get(*path)
    uri = URI.parse [BASE_URI, *path].join('/')

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(uri.path, headers)

    response = https.request(request)

    JSON.parse(response.body)
  end

  def project(id)
    Project.new(get 'projects', id)
  end

  def projects
    get('projects').map do |project|
      Project.new(project)
    end
  end

  def timer(project)
    project_id = project.respond_to?(:id) ? project.id : project

    Timer.new(get 'projects', project_id, 'timer')
  end

  private

  def headers
    {
      'Content-Type' => 'application/json',
      'User-Agent' => USER_AGENT,
      'X-FreckleToken' => @api_key
    }
  end
end
