class SpotifiesController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:artist] && params[:artist] != "" && !params[:artist].nil?
      RSpotify.authenticate(ENV['SPOTI_CLIENT_ID'], ENV['SPOTI_API_SECRET'])
      if !RSpotify::Artist.search(params[:artist]).first
        flash[:error] = "Mince il semble que cet artiste n'existe pas :/"
      else 
        @artist = RSpotify::Artist.search(params[:artist]).first
        @album = @artist.albums.sample
        @tracks = @album.tracks
        @track = @tracks.sample
        @uri = @album.external_urls['spotify']
      end
    end
  end

end
