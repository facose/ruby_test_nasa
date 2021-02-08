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
 
def photos_count(nasa_hash)
    
    nasa_hash.each do |hash|
        photos = hash[1]
        photo_count_arry = []

        for i in (0...photos.count) do 
            photo_count_arry.push(photos[i]["camera"]["full_name"])
        end 

        cameras = Hash.new(0)    
        photo_count_arry.each do |photo|
            cameras[photo] += 1
        end

=begin ** uncomment this block of code to have a more user friendly message in the terminal console**         
        cameras.each do |camera, photo|  
            puts "la cámara #{camera} realizó #{photo} fotografías"
        end  
=end

        return cameras

    end
end

nasa_request = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "pofO238yhgKQk0AxaSjYiBHCOQYuV51ax7AfSmwT")

build_web_page(nasa_request)
print photos_count(nasa_request)