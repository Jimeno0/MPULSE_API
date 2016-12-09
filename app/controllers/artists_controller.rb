class ArtistsController < ApplicationController
  before_action :find_artist

  def create
    binding.pry
    if @artist
      return render json: @artist, status: 200 if @user.artists.push(@artist)
      return render json: {error: "error to push artist" }, status: 400
    else
      @artist = Artist.new(name: params[:artists][:name])
      return render json: @artist, status: 201 if @artist.save
      return render json: {error: "impossible to create artist" }, status: 400
    end
  end

  def destroy
    user_artist = @user.artists.find_by(name: @artist.name)
    return render json: {error: "user dont have this artist as favourite"}, status: 400 unless user_artist

    user_artist.delete if user_artist.users.size <= 1
    @user.artists.delete(user_artist) if user_artist.users.size > 1

    render json: {message: "artist removed as favorite"}, status: 200
  end


  private
  def find_artist
    binding.pry
    @artist = Artist.find_by(name: params[:artists][:name].capitalize)
  end
end
