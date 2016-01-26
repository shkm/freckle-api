RSpec.describe FreckleApi::Timer do
  include_context 'api'
  let(:timer) { api.timer(existing_project_id) }

  describe '#pause!' do
    context 'when the timer is running' do
      before do
        stub_get_timer(existing_project_id)
        stub_put_timer_event(existing_project_id, :pause)

        timer.pause!(api)
      end

      it 'pauses the timer' do
        expect(timer.state).to eq :paused
      end
    end
  end

  describe '#start!' do
    context 'when the timer is paused' do
      before do
        stub_get_timer(existing_project_id, file: 'pause')
        stub_put_timer_event(existing_project_id, :start)

        timer.start!(api)
      end

      it 'starts the timer' do
        expect(timer.state).to eq :running
      end
    end
  end

  describe '#log!' do
    context 'when the timer is running' do
      before do
        stub_get_timer(existing_project_id)
        stub_put_timer_log(existing_project_id)
      end

      let(:result) { timer.log!(api) }

      it 'logs the timer, returning true' do
        expect(result).to eq true
      end

      it 'no longer exists' do
        result

        stub_api(:get, "projects/#{existing_project_id}/timer", status: 404)

        expect(timer.reload!(api)).to be_nil
      end
    end
  end

  describe '#discard!' do
  end
end
