require 'rubygems'
require 'rest_client'
require 'json'

url = "http://ec2-54-225-45-197.compute-1.amazonaws.com:3000/posts.json"
result_file = File.new 'ping_results.txt', 'a'

while true
  results = RestClient.get url
  result_file.puts Time.now
  if (results.code != 200)
    result_file.puts "\tstatus code #{results.code} returned"
  else
    result_object = JSON.parse results.body
    result_file.puts "\tgot #{result_object.length} objects in response"
  end
  result_file.flush
  sleep(1.5)
end


