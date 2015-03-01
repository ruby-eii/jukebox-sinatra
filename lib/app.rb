require 'sinatra'
require_relative 'config'

module Jukebox
  class App < Sinatra::Application

    configure do
      Song.create_sample_songs
    end

    get "/" do
      redirect "/songs"
    end

    get "/queue" do
      @queue = SongQueue.instance
      erb :"queue/show"
    end

    post "/queue/add" do
      song = Song.find(params[:song_id])

      SongQueue.instance.songs.push(song)

      status 200
      body ''
    end

    post "/queue/remove" do
      song = Song.find(params[:song_id])

      SongQueue.instance.songs.delete(song)

      status 200
      body ''
    end

    get "/song/:id" do
      @song = Song.find(params[:id])
      erb :"songs/play"
    end

    get "/songs" do
      @songs = Song.all
      erb :"songs/index"
    end

    get "/songs/new" do
      @song = Song.new
      erb :"songs/new"
    end

    post "/song" do
      Song.create(params)
      redirect "/songs"
    end

  end
end
