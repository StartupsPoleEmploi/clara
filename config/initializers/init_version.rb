major = ENV["MAJOR_VERSION"] || 20
minor = ENV["MINOR_VERSION"] || 7
build = ENV["BUILD_VERSION"] || 0


ARA_VERSION = "#{[major.to_s, minor.to_s, build.to_s].join('.')}"
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
