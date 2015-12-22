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

  def project(id)
    Project.new(request :get, uri('projects', id))
  end

  def projects
    Project.list(request :get, uri('projects'))
  end

  def timer(project)
    project_id = project.respond_to?(:id) ? project.id : project

    Timer.new(request :get, uri('projects', project_id, 'timer'))
  end

  def timers
    Timer.list(request :get, uri('timers'))
  end

  private

  def request(method, uri)
    https = Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true }

    response = https.request(http_class(method).new(uri.path, headers))

    JSON.parse(response.body)
  end

  def http_class(method)
    "Net::HTTP::#{method.to_s.capitalize}".constantize
  end

  def uri(*path)
    URI.parse [BASE_URI, *path].join('/')
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'User-Agent' => USER_AGENT,
      'X-FreckleToken' => @api_key
    }
  end
end
