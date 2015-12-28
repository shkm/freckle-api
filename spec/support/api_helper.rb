module ApiHelper
  def stub_api(method, remote_path, body: '', file_path: nil, status: 200)
    headers = {
      'User-Agent': 'freckle-api',
      'X-FreckleToken': valid_api_key
    }

    if file_path
      body = File.open("spec/fixtures/#{file_path || remote_path}.json").read
    end

    stub_request(method, [base_uri, remote_path].join('/'))
      .with(headers: headers)
      .to_return(status: status, body: body)
  end

  def stub_get_project(id)
    stub_api(:get,
             "projects/#{id}",
             file_path: 'projects/show')
  end

  def stub_get_projects
    stub_api(:get, 'projects', file_path: 'projects')
  end

  def stub_get_timer(project_id, file: nil)
    path = 'projects/show/timer'
    path = [path, file].join('/') if file

    stub_api(:get,
             "projects/#{project_id}/timer",
             file_path: path)
  end

  def stub_put_timer_event(project_id, event)
    stub_api(:put, "projects/#{project_id}/timer/#{event}",
             file_path: "projects/show/timer/#{event}")
  end

  def stub_put_timer_log(project_id)
    stub_api(:put, "projects/#{project_id}/timer/log", status: 204)
  end
end
