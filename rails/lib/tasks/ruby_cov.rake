
namespace :ruby_cov do

  task :merge do
    require 'simplecov'
    results = []
    all_results = []
    all_results << "coverage/ruby/unit/.resultset.json"
    all_results << "coverage/ruby/functional/.resultset.json"
    all_results.each do |result_file_name|
      puts "Processing #{result_file_name}"
      results << SimpleCov::Result.from_hash(JSON.parse(File.read(result_file_name)))
    end
    merged_result = SimpleCov::ResultMerger.merge_results(*results)
    merged_result.format!
  end

end
