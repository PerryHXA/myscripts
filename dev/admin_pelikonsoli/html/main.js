var categoryInput = false

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data
      if (item.type == "open") {
          document.getElementById("stg_switch").style.display = "block"
          setTimeout(() => document.getElementById("stg_switch").style.transform = "scale(1)", 100);
      }
  })
})

function goHome() {
   document.getElementById('stg-gameArea').style.display = "none"
   document.querySelectorAll(".game").forEach(function(a){a.remove()})
}

function closeGame() {
   document.getElementById("stg_switch").style.display = "none"
   $.post('http://stg_switch/exit', JSON.stringify({}));
   document.getElementById("stg_switch").style.transform = "scale(0.6)"
}

function openGame(game) {
  document.getElementById('stg-gameArea').style.display = "block"
  if(game == "mario")
   {
      div = `<iframe class="games-mario game" src="https://jcw87.github.io/c2-smb1/" id="stg-game"></iframe>`
   }
   else if(game == "undertale")
   {
      div = `<iframe class="games-undertale game" src="https://jcw87.github.io/c2-sans-fight/" id="stg-game"></iframe>`
   }
   else if(game == "bird")
   {
      div = `<iframe class="games-bird game" src="https://ellisonleao.github.io/clumsy-bird/" id="stg-game"></iframe>`
   }
   else if(game == "snake")
   {
      div = `<iframe class="games-snake game" src="http://slither.io/" id="stg-game"></iframe>`
    }
  $("#stg-gameArea").append(div)
}

function Time() {
   const date = new Date();
   let hours = date.getHours();
   let minutes = date.getMinutes();
   hours = hours < 10 ? "0" + hours : hours;
   minutes = minutes < 10 ? "0" + minutes : minutes;

   $('#stg-infoText').html(hours+':'+minutes);
   setTimeout(Time, 1000);
}

Time()