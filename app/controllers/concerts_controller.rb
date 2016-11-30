require "http"
class ConcertsController < ApplicationController
  before_action :current_user, only: [:index]
  def index
    #introducir if para en caso de que pete
    user = User.find_by(token: params[:token])
    concerts = user.concerts.all
    render json: concerts
  end

  def show
    # hacer show method para un caso concreto
  end



  def last
    tomorrow = Date.tomorrow.to_s
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&startDateTime=#{tomorrow}T00:00:00Z&size=20&classificationName=Music"
    handle_ticketmaster_API(url)
    render json: {response: @concerts}
  end

  def search
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&keyword=#{params[:search]}"
    handle_ticketmaster_API(url)
    render json: {response: @concerts}
  end

  private


  def current_user
    @user = User.find_by(token: params[:token])
    unless @user
      render json: { error: "user not found"}, status: 404
      return
    end
  end

  def handle_ticketmaster_API(url)
    response = HTTP.get(url)
    events = JSON.parse(response.body)['_embedded']['events']
    @concerts = []
    events.each do |event|
      concert = {
        name: event["name"],
        date: event["dates"]["start"]["localDate"],
        url: event["url"],
        # IMAGES
        genre: event["classifications"][0]["genre"]["name"],
        subgenre: event["classifications"][0]["subGenre"]["name"],
        country: event["_embedded"]["venues"][0]["country"]["name"],
        lat:event["_embedded"]["venues"][0]["location"]["latitude"],
        lon: event["_embedded"]["venues"][0]["location"]["longitude"],
        city: event["_embedded"]["venues"][0]["city"]["name"],
        venue: event["_embedded"]["venues"][0]["name"],
        concert_id: event["id"]
      }
      sale = event["dates"]["status"]["code"]
      if sale == "onsale"
        concert["sale"] = true
      else
        concert["sale"] = false
      end

      images_array = event["images"]
      images_array.each do |image|
        concert["image"] =  image["url"] if image["ratio"] == "4_3"
      end

      @concerts.push(concert);
    end
  end

end
