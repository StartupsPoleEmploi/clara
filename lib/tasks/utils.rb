def run_and_stop_if_error command
  res = ""
  Bundler.with_clean_env do
    puts command
    res = `#{command}`
    if $? != 0
      abort "Command (#{command}) finished with errors : #{res}" 
    end
  end
  res.strip
end