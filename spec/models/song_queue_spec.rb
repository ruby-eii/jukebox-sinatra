require 'spec_helper'

describe SongQueue do

  let(:queue) { SongQueue.new }

  let(:song) { Song.create({:artist => "Benny Goodman", :title => "So Many Memories", :url => "http://audio.com"}) }
  let(:other_song) { Song.create({:artist => "Fakeman", :title => "Keep it real", :url => "http://audio2.com"}) }

  context "songs container" do
    it "adds songs" do
      queue.songs.push(song)

      expect(queue.songs.size).to eql 1
    end

    it "doesn't allow duplicated songs" do
      queue.songs.push(song)
      queue.songs.push(song)

      expect(queue.songs.size).to eql 1
    end

    it "deletes songs" do
      queue.songs.push(song)
      queue.songs.delete(song)

      expect(queue.songs.size).to eql 0
    end
  end

  describe "#instance" do
    it "returns the same object between calls" do
      SongQueue.instance.songs.push(song, other_song)

      expect(SongQueue.instance.songs.size).to eql 2
    end
  end

  describe "#audio_sources" do
    it "returns a list containing all songs' URLs" do
      queue.songs.push(song, other_song)

      expect(queue.audio_sources).to eql [song.url, other_song.url]
    end

    it "returns an empty list if there are no songs" do
      expect(queue.audio_sources).to eql []
    end
  end


end
