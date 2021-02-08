require "uri"
require "net/http"
require "json"

def request(url, token = nil)
    url = URI("#{url}&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

def build_web_page(info_hash)
    File.open("rover_curiosity.html", "w") do |hash|
        hash.puts "<html>" 
        hash.puts "<head>"
        hash.puts "</head>"
        hash.puts "<body>"
        hash.puts "<ul>"
        hash.puts "<li><img></li>"
        hash.puts "<li><img></li>"
        hash.puts "</ul>"
        hash.puts "</body>"
        hash.puts "</html>"
    end   
end    

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "pofO238yhgKQk0AxaSjYiBHCOQYuV51ax7AfSmwT")
build_web_page(nasa_hash)