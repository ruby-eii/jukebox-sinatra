$(document).ready(function() {

  var jukebox = new JukeboxClient();
  var $player = $("audio#jukebox-player")[0];

  $("button.play-button").on("click", function() {
    jukebox.start(playSongURL);
  });

  $player.addEventListener("ended", function() {
    jukebox.playNextSong(playSongURL);
  });

  $("button.stop-button").on("click", function() {
    $player.pause();
  });

  $("a.remove-song").on("click", function() {
    var songId = $(this).data("song-id");

    jukebox.removeSong(songId, reloadLocation);
  });

  var playSongURL = function(songURL, songIndex) {
    var sourceElement = document.createElement('source');
    sourceElement.type = 'audio/mp3';
    sourceElement.src = songURL;

    $player.appendChild(sourceElement);
    $player.play();

    highlightSongBlock(songIndex);
  };

  var reloadLocation = function() {
    location.reload();
  };

  var highlightSongBlock = function(songIndex) {
    $("tr.song-row:eq(" + songIndex + ")").css("background-color", "#E8E6B3");
  };

});