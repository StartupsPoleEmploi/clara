file_location = File.file?('CHANGELOG.md') ? 'CHANGELOG.md' : '../CHANGELOG.md'

lines = File.foreach(file_location).first(10)

begin
  ARA_VERSION = lines.detect {|e| e.start_with?("## ")}.split("## ")[1].split(" (")[0]
rescue => e
  puts e.class
  ARA_VERSION="development"
end
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
