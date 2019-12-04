require 'simplecov'

namespace :ruby_cov do

  task :merge do
    results = []
    # all_results = Dir["#{base_dir}/.resultset*.json"]
    all_results = []
    all_results << "/Users/david/workspace/clara/coverage/ruby/unit/.resultset.json"
    all_results << "/Users/david/workspace/clara/coverage/ruby/functional/.resultset.json"
    all_results.each do |result_file_name|
      ap "Processing #{result_file_name}"
      results << SimpleCov::Result.from_hash(JSON.parse(File.read(result_file_name)))
    end
    merged_result = SimpleCov::ResultMerger.merge_results(*results)
    merged_result.format!
  end

end
