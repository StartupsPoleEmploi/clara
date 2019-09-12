lines = File.foreach('CHANGELOG.md').first(10)



ARA_VERSION = lines.detect {|e| e.start_with?("## ")}.split("## ")[1].split(" (")[0]
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
