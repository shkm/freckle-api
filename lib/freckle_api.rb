require 'net/http'
require 'json'

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

  def self.uri(*path)
    URI.parse [BASE_URI, *[path]].join('/')
  end

  def initialize(api_key)
    @api_key = api_key
  end

  def project(id)
    Project.new(request :get, self.class.uri('projects', id))
  end

  def projects
    request(:get, self.class.uri('projects'), coerce_to: Project)
  end

  # TODO: consider whether it's necessary to find a timer by ITS id,
  # not that of the project.
  def timer(project)
    project_id = project&.id || project

    Timer.new(request :get, self.class.uri('projects', project_id, 'timer'))
  end

  def timers
    request(:get, self.class.uri('timers'), coerce_to: Timer)
  end

  def request(method, uri, parse: true, coerce_to: Hash, params: {})
    request = build_request(method, uri, params)
    response = send_request(request, uri)

    parse ? JSON.parse(response.body, object_class: coerce_to) : response
  end

  private

  def build_request(method, uri, params: {})
    http_class(method).new(uri.path, headers).tap do |request|
      request.set_form_data(params)
    end
  end

  def send_request(request, uri)
    https = Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true }
    https.request(request)
  end

  def http_class(method)
    Object.const_get "Net::HTTP::#{method.to_s.capitalize}"
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'User-Agent' => USER_AGENT,
      'X-FreckleToken' => @api_key
    }
  end
end
