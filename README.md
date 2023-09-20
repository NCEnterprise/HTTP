# HTTP

To check whether websites in a list provided as an input file run on HTTP or HTTPS, you can create a Ruby script that reads the URLs from the file and makes HTTP requests to determine the protocol in use. Here's an example script:
```
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
```

Save this script in a `.rb` file (e.g., `check_protocol.rb`). You can run it from the command line, passing the input file as an argument:

`ruby check_protocol.rb input.txt`

Replace `input.txt` with the name of your input file containing a list of URLs, with one URL per line. The script will then check each URL and print whether it uses HTTP or HTTPS.
