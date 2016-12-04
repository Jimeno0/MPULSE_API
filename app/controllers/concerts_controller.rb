require "http"
class ConcertsController < ApplicationController
  before_action :current_user, except: [:last, :search]
  def index
    concerts = @user.concerts.all
    render json: concerts, status: 200
  end

  def show
    concert = @user.concerts.find_by(concert_id: params[:id])
    render json: concert
  end

  def create
    concert = Concert.find_by(concert_id: params[:concert][:concert_id])

    concert = Concert.new(params[:concert]) unless concert
    render json: {error: 'error to create concert' }, status: 400 if concert.error
    concert.save

    @user.concerts.push(concert)
    render json: concert, status: 201
  end

  def destroy
    concert = @user.concerts.find_by(concert_id: params[:id])
    unless concert
      render json: {error: "user dont have this route as favourite"}, status: 400
    end
    if concert.users.size = 1
      @user.concerts.delete
    else
      @user.concerts.delete(concert)
    end
  end

  def last
    tomorrow = Date.tomorrow.to_s
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&startDateTime=#{tomorrow}T00:00:00Z&size=8&classificationName=Music"
    handle_ticketmaster_API(url)
  end

  def search
    @artist = params[:search]
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&keyword=#{@artist}"
    handle_ticketmaster_API(url)
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
    if JSON.parse(response.body)["page"]["totalElements"] == 0
      render json: { error: "No concerts for this artist yet"}, status: 404
      return
    end

    events = JSON.parse(response.body)['_embedded']['events']
    @concerts = []
    events.each do |event|
      concert = {
        name: event["name"],
        date: event["dates"]["start"]["localDate"],
        url: event["url"],
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
    render json: @concerts, status: 200
  end

end
