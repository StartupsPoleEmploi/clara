major = ENV["MAJOR_VERSION"] || 9
minor = ENV["MINOR_VERSION"] || 2
build = ENV["BUILD_VERSION"] || 1
ARA_VERSION = "#{[major.to_s, minor.to_s, build.to_s].join('.')}"
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
