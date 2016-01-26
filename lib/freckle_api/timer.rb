# TODO: actual error handling
class FreckleApi
  class Timer < FreckleApi::Model
    coerce_key :state, Symbol
    coerce_key :date, coerce_to_date
    coerce_key :user, FreckleApi::User
    coerce_key :project, FreckleApi::Project

    def start!(api)
      update api.request(:put, timer_uri(:start))
    end

    def pause!(api)
      update api.request(:put, timer_uri(:pause))
    end

    def log!(api, entry_date: nil, minutes: nil, description: '')
      response = api.request(:put,
                             timer_uri(:log),
                             parse: false,
                             body: {
                               description: description
                             })

      response.code.to_i == 204
    end

    def discard!(api)
      api.request(:put, timer_uri(:discard), parse: false)

      response.code.to_i == 204 ? true : nil
    end

    def reload!(api)
      response = api.request(:get,
                             FreckleApi.uri('projects', project.id, 'timer'),
                             parse: false)

      response.code.to_i == 204 ? update(response.body) : nil
    end

    private

    def timer_uri(action)
      FreckleApi.uri('projects', project.id, 'timer', action)
    end
  end
end
