require 'time_error'

RSpec.describe TimeError do
    describe "#error" do
        it "returns the difference in seconds between the remote time and time on the computer" do
            fake_requester = double :fake_requester
            allow(fake_requester).to receive(:get).with(URI("https://worldtimeapi.org/api/ip")).and_return"{\"abbreviation\":\"BST\",\"client_ip\":\"2a02:c7e:3696:f800:2cbe:b6d:c951:db08\",\"datetime\":\"2022-09-22T14:55:46.710722+01:00\",\"day_of_week\":4,\"day_of_year\":265,\"dst\":true,\"dst_from\":\"2022-03-27T01:00:00+00:00\",\"dst_offset\":3600,\"dst_until\":\"2022-10-30T01:00:00+00:00\",\"raw_offset\":0,\"timezone\":\"Europe/London\",\"unixtime\":1663854946,\"utc_datetime\":\"2022-09-22T14:59:10+00:00\",\"utc_offset\":\"+01:00\",\"week_number\":38}" 
            time = Time.new(2022, 9, 22, 14, 59, 10, 00)
            p "time being tested: #{time}"
            time_error = TimeError.new(fake_requester)
            expect(time_error.error(time)).to eq 0
        end

        it "10 seconds difference" do
          fake_requester = double :fake_requester
          allow(fake_requester).to receive(:get).with(URI("https://worldtimeapi.org/api/ip")).and_return"{\"abbreviation\":\"BST\",\"client_ip\":\"2a02:c7e:3696:f800:2cbe:b6d:c951:db08\",\"datetime\":\"2022-09-22T14:55:46.710722+01:00\",\"day_of_week\":4,\"day_of_year\":265,\"dst\":true,\"dst_from\":\"2022-03-27T01:00:00+00:00\",\"dst_offset\":3600,\"dst_until\":\"2022-10-30T01:00:00+00:00\",\"raw_offset\":0,\"timezone\":\"Europe/London\",\"unixtime\":1663854946,\"utc_datetime\":\"2022-09-22T14:59:10+00:00\",\"utc_offset\":\"+01:00\",\"week_number\":38}" 
          time = Time.new(2022, 9, 22, 14, 59, 00, 00)
          p "time being tested: #{time}"
          time_error = TimeError.new(fake_requester)
          expect(time_error.error(time)).to eq 10
        end
    end
end
