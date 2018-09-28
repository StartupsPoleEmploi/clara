major = ENV["MAJOR_VERSION"] || 13
minor = ENV["MINOR_VERSION"] || 4
build = ENV["BUILD_VERSION"] || 4



ARA_VERSION = "#{[major.to_s, minor.to_s, build.to_s].join('.')}"
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
