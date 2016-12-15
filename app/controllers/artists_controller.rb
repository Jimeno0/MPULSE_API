class ArtistsController < ApplicationController

  def index
    artists = @user.artists.all
    if artists
      render json: artists, status: 200
      return
    end
    render json: {error: "Cant get artists artist" }, status: 400
  end

  def create
    artist = Artist.find_or_create_by(name: params[:artists][:name].capitalize)
    if artist
      @user.artists.push(artist)
      render json: artist, status: 201
      return
    end
    render json: {error: "impossible to create artist" }, status: 400
  end

  def destroy
    artist = Artist.find_by(name: params[:name].capitalize)
    user_artist = @user.artists.find_by(name: artist.name)
    if user_artist
      user_artist.destroy if user_artist.users.size <= 1
      @user.artists.delete(user_artist) if user_artist.users.size > 1
      render json: artist, status: 200
      return
    end
    render json: {error: "user dont have this artist as favourite"}, status: 400
  end
end

