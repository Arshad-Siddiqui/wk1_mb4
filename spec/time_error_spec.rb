require 'time_error'

RSpec.describe TimeError do
  describe '#error' do
    context 'Delay simulated to 10s' do
      it 'returns the 10s time delay' do
        api = double :fake_api
        delay_10s = DateTime.now + Rational(10, 86400)
        json = {
          'utc_datetime' => delay_10s
        }
        json_string = JSON[json]
        allow(api).to receive(:get).with(URI("https://worldtimeapi.org/api/ip"))
        .and_return(json_string)
        time_error = TimeError.new(api)
        expect(time_error.error).to eq 10
      end
    end

    context 'No time delay' do
      it 'returns 0' do
        api = double :fake_api
        json = {
          'utc_datetime' => DateTime.now
        }
        json_string = JSON[json]
        allow(api).to receive(:get).with(URI("https://worldtimeapi.org/api/ip"))
        .and_return(json_string)
        time_error = TimeError.new(api)
        expect(time_error.error).to eq 0
      end
    end

    context '5s delay' do
      it 'returns 5' do
        api = double :fake_api
        delay_5s = DateTime.now + Rational(5, 86400)
        json = {
          'utc_datetime' => delay_5s
        }
        json_string = JSON[json]
        allow(api).to receive(:get).with(URI("https://worldtimeapi.org/api/ip"))
        .and_return(json_string)
        time_error = TimeError.new(api)
        expect(time_error.error).to eq 5
      end
    end

    context 'Delay 100s' do
      it 'returns 100' do
        api = double :fake_api
        delay_100s = DateTime.now + Rational(100, 86400)
        json = {
          'utc_datetime' => delay_100s
        }
        json_string = JSON[json]
        allow(api).to receive(:get).with(URI("https://worldtimeapi.org/api/ip"))
        .and_return(json_string)
        time_error = TimeError.new(api)
        expect(time_error.error).to eq 100
      end
    end
  end
end