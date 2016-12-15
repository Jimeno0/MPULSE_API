class ConcertsController < ApplicationController
  skip_before_action :current_user, only: [:last, :search]

  def index
    concerts = @user.concerts.all
    render json: concerts, status: 200
  end

  def create
    concert = Concert.find_or_create_by(concert_params)
    if concert
      @user.concerts.push(concert)
      render json: concert, status: 201
      return
    end
    render json: {error: "impossible to create concert" }, status: 400
  end

  def destroy
    user_concert = @user.concerts.find_by(concert_id: params[:concert_id])
    if user_concert
      user_concert.destroy if user_concert.users.size <= 1
      @user.concerts.delete(user_concert) if user_concert.users.size > 1
      render json: user_concert, status: 200
      return
    end
    render json: {error: "user dont have this concert as favourite"}, status: 400
  end

  def last
    tomorrow = Date.tomorrow.to_s
    # url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&startDateTime=#{tomorrow}T00:00:00Z&size=9&classificationName=Music"
    partial_url = "&startDateTime=#{tomorrow}T00:00:00Z&size=9&classificationName=Music"
    render TicketmasterApi.handle_ticketmaster_API(partial_url)
  end

  def search
    artist = params[:search].gsub(" ","%20")
    # url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&keyword=#{artist}"
    partial_url = "&keyword=#{artist}"
    render TicketmasterApi.handle_ticketmaster_API(partial_url)
  end

  private
  def concert_params
   params.require(:concert).permit(:name, :date, :url, :genre, :subgenre, :country, :lat, :long, :city, :venue, :concert_id, :sale, :image)
  end
end
