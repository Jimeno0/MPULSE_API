class ArtistsController < ApplicationController
  before_action :current_user
  def create

    artist = Artist.find_by(name: params[:artists][:name].capitalize)
    # binding.pry
    if artist
      if @user.artists.push(artist)
        render json: artist, status: 200
      else
        render json: {error: 'error to push artist' }, status: 400
      end

    else
      artist = Artist.new(name: params[:artists][:name])
      if artist.save
        # binding.pry
        render json: artist, status: 201
      else
        render json: {error: 'impossible to create artist' }, status: 400
      end
    end
  end

  def destroy
    artist = @user.artists.find_by(name: params[:artists][:name].capitalize)
    unless artist
      return render json: {error: "user dont have this route as favourite"}, status: 400
    end
    if artist.users.size = 1
      @user.artists.delete
    else
      @user.artists.delete(artist)
    end
    render json: {error: "artist removed as favorite"}, status: 200
  end

  def current_user
    @user = User.find_by(token: params[:token])
    unless @user
      render json: { error: "user not found"}, status: 404
      return
    end
  end

end
