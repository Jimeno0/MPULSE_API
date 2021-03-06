module TicketmasterApi
  def last
    tomorrow = Date.tomorrow.to_s
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&startDateTime=#{tomorrow}T00:00:00Z&size=9&classificationName=Music"
    self.handle_ticketmaster_API(url)
  end

  def search
    artist = params[:search].gsub(" ","%")
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj&keyword=#{artist}"
    self.handle_ticketmaster_API(url)
  end
  
  def handle_ticketmaster_API(url)
    response = HTTP.get(url)
    if JSON.parse(response.body)["page"]["totalElements"] == 0
      render json: { error: "No concerts for this artist yet"}, status: 404
      return
    end

    events = JSON.parse(response.body)["_embedded"]["events"]
    @concerts = []

    events.each do |event|
      concert = {
        name: event["name"],
        date: event["dates"]["start"]["localDate"],
        url: event["url"],
        genre: event["classifications"][0]["genre"]["name"],
        subgenre: event["classifications"][0]["subGenre"]["name"],
        concert_id: event["id"]
      }

      if (event["_embedded"]["venues"][0]["country"] && event["_embedded"]["venues"][0]["location"])
        concert["country"] = event["_embedded"]["venues"][0]["country"]["countryCode"]
        concert["lat"] = event["_embedded"]["venues"][0]["location"]["latitude"]
        concert["lon"] = event["_embedded"]["venues"][0]["location"]["longitude"]
        concert["city"] = event["_embedded"]["venues"][0]["city"]["name"]
        concert["venue"] = event["_embedded"]["venues"][0]["name"]
      end

      sale = event["dates"]["status"]["code"]
      if sale == "onsale"
        concert["sale"] = true
      else
        concert["sale"] = false
      end
      images_array = event["images"]
      images_array.each do |image|
        concert["image"] =  image["url"] if image["ratio"] == "16_9"
      end
      @concerts.push(concert);
    end
    render json: @concerts, status: 200
  end
end