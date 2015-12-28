shared_context 'api' do
  let(:base_uri) { 'https://api.letsfreckle.com/v2' }
  let(:valid_api_key) { 'valid_api_key' }
  let(:invalid_api_key) { 'valid_api_key' }

  let(:existing_project_id) { 37_396 }
  let(:existing_user_id) { 5_538 }

  let(:api) { FreckleApi.new(valid_api_key) }
end
