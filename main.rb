require 'sinatra'
require 'json'
require 'net/http'
require 'uri'

class Display < Sinatra::Base
  get '/' do
    uri = URI.parse('https://www.redbubble.com/api/products/recent?ref=sort_order_change_recent')
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body, symbolize_names: true)
    product = json[:products][0]

    result = "<a href='https://redbubble.com#{product[:product_url]}'><img src='#{product[:images][:feed_image_url]}' alt='#{product[:full_title]}' /></a>"
    erb result, layout: :layout
  end
end
