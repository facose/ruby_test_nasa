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

def build_web_page(nasa_hash)#=> here goes a hash returned from the request method
    File.open("nasa.html", "w") do |key|
        nasa_hash.each do |value| #=> class array

            photos = value[1]

            
            key.puts "<html>" 
            key.puts "<head>"
            key.puts "<title>NASA | Curiosity</title>"
            key.puts "<link rel='stylesheet' href='style.css'>"
            key.puts "</head>"
            key.puts "<body>"
            key.puts "<header>"
            key.puts "<img src='nasa.png'>"
            key.puts "<h1>Mars Rover Photos</h1>"
            key.puts "</header>"
            key.puts "<ul>"
            key.puts "<div class='img-wrapper'>"

            photos.each do |photo|
                key.puts "<h2>Date: #{photo["earth_date"]}</h2>"
                key.puts "<li><img src='#{photo["img_src"]}' alt='id: #{photo["id"]}'></li>"
            end    

            key.puts "</div>"
            key.puts "</ul>"
            key.puts "</body>"
            key.puts "</html>"
        end    
    end   
end
 
#def  photos_count()

#end

nasa_request = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "pofO238yhgKQk0AxaSjYiBHCOQYuV51ax7AfSmwT")
build_web_page(nasa_request)
