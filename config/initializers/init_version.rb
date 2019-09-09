# major = ENV["MAJOR_VERSION"] || 21
# minor = ENV["MINOR_VERSION"] || 10
# build = ENV["BUILD_VERSION"] || 0



lines = File.foreach('CHANGELOG.md').first(10)



ARA_VERSION = lines.detect {|e| e.start_with?("## ")}.split("## ")[1].split(" (")[0]
# ARA_VERSION = "#{[major.to_s, minor.to_s, build.to_s].join('.')}"
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
