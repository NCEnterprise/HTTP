require 'net/http'

# Check if an input file is provided as an argument
if ARGV.empty?
  puts 'Please provide an input file containing a list of URLs.'
  exit
end

input_file = ARGV[0]

# Read the list of URLs from the input file
urls = File.readlines(input_file).map(&:chomp)

# Define a method to check the protocol of a URL
def check_protocol(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')
  
  begin
    response = http.head(uri.request_uri)
    protocol = http.use_ssl? ? 'HTTPS' : 'HTTP'
    return "#{url}: #{protocol}"
  rescue StandardError => e
    return "#{url}: Unable to determine protocol - #{e.message}"
  end
end

# Loop through the URLs and check their protocols
urls.each do |url|
  result = check_protocol(url)
  puts result
end
