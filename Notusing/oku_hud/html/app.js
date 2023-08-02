const { ref, onBeforeUnmount } = Vue

const app = Vue.createApp({
  data: function() {
		return {
      isDynamicHungerChecked: this.initIsDynamicHungerChecked(),
      isDynamicThirstChecked: this.initIsDynamicThirstChecked(),
      isDynamicHealthChecked: this.initIsDynamicHealthChecked(),
	  isDynamicHorsehChecked: this.initIsDynamicHorsehChecked(),
	  isDynamicHorsesChecked: this.initIsDynamicHorseChecked(),
		};
	},
  setup () {
    const progress = ref([
      { loading: false, percentage: 0 },
      { loading: false, percentage: 0 },
      { loading: false, percentage: 0 }
    ])
    
    const intervals = [ null, null, null ]

    function startComputing (id) {
      progress.value[ id ].loading = true
      progress.value[ id ].percentage = 0

      intervals[ id ] = setInterval(() => {
        progress.value[ id ].percentage += Math.floor(Math.random() * 8 + 10)
        if (progress.value[ id ].percentage >= 100) {
          clearInterval(intervals[ id ])
          progress.value[ id ].loading = false
        }
      }, 700)
    }

    onBeforeUnmount(() => {
      intervals.forEach(val => {
        clearInterval(val)
      })
    }) 
    return {
      framework: {
        plugins: [
          'LocalStorage',
          'SessionStorage'
        ]
      },
      tab: ref('hud'),
      splitterModel: ref(20),
      selection: ref([]),
      progress,
      startComputing,
    }
  },
  watch: {
    isDynamicHealthChecked: function() {
			localStorage.setItem("isDynamicHealthChecked", this.isDynamicHealthChecked);
		},
    isDynamicHungerChecked: function() {
			localStorage.setItem("isDynamicHungerChecked", this.isDynamicHungerChecked);
		},
    isDynamicThirstChecked: function() {
			localStorage.setItem("isDynamicThirstChecked", this.isDynamicThirstChecked);
		},
    isDynamicHorsehChecked: function() {
			localStorage.setItem("isDynamicHorsehChecked", this.isDynamicHorsehChecked);
		},
    isDynamicHorsesChecked: function() {
			localStorage.setItem("isDynamicHorsesChecked", this.isDynamicHorsesChecked);
		},
	},
  methods: {
    initIsDynamicHealthChecked: function() {
			const stored = localStorage.getItem("isDynamicHealthChecked");
			if (stored === null) {
				return false;
			} else {
				return stored == 'true';
			}
		},
    initIsDynamicHorsehChecked: function() {
			const stored = localStorage.getItem("isDynamicHorsehChecked");
			if (stored === null) {
				return false;
			} else {
				return stored == 'true';
			}
		},
    initIsDynamicHorsesChecked: function() {
			const stored = localStorage.getItem("isDynamicHorsesChecked");
			if (stored === null) {
				return false;
			} else {
				return stored == 'true';
			}
		},
    initIsDynamicHungerChecked: function() {
			const stored = localStorage.getItem("isDynamicHungerChecked");
			if (stored === null) {
				return false;
			} else {
				return stored == 'true';
			}
		},
    initIsDynamicThirstChecked: function() {
			const stored = localStorage.getItem("isDynamicThirstChecked");
			if (stored === null) {
				return false;
			} else {
				return stored == 'true';
			}
		},
    resetStorage: function(event) {
      targetId = event.currentTarget.id;
      localStorage.clear();
      resetStorage()
    },
    restartHud: function(event) {
      targetId = event.currentTarget.id;
      restartHud()
    },
    dynamicHealth: function(event) {
      targetId = event.currentTarget.id;
      dynamicHealth()
    },
    dynamicHorseh: function(event) {
      targetId = event.currentTarget.id;
      dynamicHorseh()
    },
    dynamicHorses: function(event) {
      targetId = event.currentTarget.id;
      dynamicHorses()
    },
    dynamicHunger: function(event) {
      targetId = event.currentTarget.id;
      dynamicHunger()
    },
    dynamicThirst: function(event) {
      targetId = event.currentTarget.id;
      dynamicThirst()
    },
  },
  mounted() {
    this.listener = window.addEventListener("message", (event) => {
        if (event.data.event === 'isToggleMapShapeChecked' || event.data.event === 'isChangeFPSChecked') {
          eval(`this.${event.data.event} = "${event.data.toggle}"`)
        }
    });
  },
})

app.use(Quasar, { config: {} })
app.mount('#menu')

document.onkeyup = function (data) {
  if (data.key == 'Escape') {
    closeMenu()
  }
};

function closeMenu() {
  $("#openmenu").fadeOut(550);
  $.post('https://oku_hud/closeMenu');
}
function restartHud() {
  closeMenu()
  $.post('https://oku_hud/restartHud');
}
function dynamicHunger() {
  $.post('https://oku_hud/dynamicHunger');
}
function dynamicThirst() {
  $.post('https://oku_hud/dynamicThirst');
}
function dynamicHealth() {
  $.post('https://oku_hud/dynamicHealth');
}
function dynamicHorseh() {
  $.post('https://oku_hud/dynamicHorseh');
}
function dynamicHorses() {
  $.post('https://oku_hud/dynamicHorses');
}

$(document).ready(function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    }
  });
});

Open = function (data) {
  $("#openmenu").fadeIn(150);
}
$('.closeMenu').click(() => {
  closeMenu()
});

// PLAYER HUD

const playerHud = {
  data() {
    return {
      dynamicHealth: 0,
	  dynamicHorses: 0,
	  dynamicHorseh: 0,
      dynamicHunger: 0,
      dynamicThirst: 0,
      health: 0,
      horses: 0,
	  horseh: 0,
      hunger: 0,
      thirst: 0,
      show: false,
      talking: false,
      showVoice: true,
      showHealth: true,
	  showHorses: false,
	  showHorseh: false,
      showHunger: true,
      showThirst: true,
      voiceIcon: "fas fa-microphone",
      talkingColor: "#FFFFFF",
      hungerColor: "",
      thirstColor: "",
    };
  },
  
  destroyed() {
    window.removeEventListener("message", this.listener);
  },
  mounted() {
    this.listener = window.addEventListener("message", (event) => {
      if (event.data.action === "hudtick") {
        this.hudTick(event.data);
      } 
      // else if(event.data.update) {
      //   eval(event.data.action + "(" + event.data.show + ')')
      // }
    });
    Config = {};
  },
  methods: {
    hudTick(data) {
      this.show = data.show;
	  this.health = data.health;
      this.hunger = data.hunger;
      this.thirst = data.thirst;
	  this.horses = data.horses;
	  this.horseh = data.horseh;
	  this.temp = data.temp;
	  this.dynamicHealth = data.dynamicHealth;
      this.dynamicHunger = data.dynamicHunger;
      this.dynamicThirst = data.dynamicThirst;
	  this.dynamicHorses = data.dynamicHorses;
	  this.dynamicHorseh = data.dynamicHorseh;
	  
      if(data.temp) { 
          $("#varTemp small").text(data.temp);
      }
      if (data.dynamicHealth == true) {
        if (data.health >= 100) {
          this.showHealth = false; }
          else{
            this.showHealth = true;
          }
      } else if (data.dynamicThirst == false){
        this.showHealth = true;
      } 
      if (data.health >= 100) {
        this.healthColor = "#ff6b77";
      } else if(data.health <= 30){
        this.healthColor = "#636363";
      } else if(data.health <= 0){
        this.healthColor = "#000000";
      } else{
        this.healthColor = "#ffffff";
      }

      if (data.dynamichorses == true) {
        if (data.horses >= 100) {
          this.showHorses = false; }
          else{
            this.showHorses = true;
          }
      } else if (data.dynamicHorses == false){
        this.showHorses = true;
      } 
      if (data.horses >= 100) {
        this.horsesColor = "#ffffff";
      } else if(data.horses <= 30){
        this.horsesColor = "#ffc7c7";
      } else{
        this.horsesColor = "#ffffff";
      }
	  
      if (data.dynamichorseh == true) {
        if (data.horseh >= 100) {
          this.showHorseh = false; }
          else{
            this.showHorseh = true;
          }
      } else if (data.dynamicHorseh == false){
        this.showHorseh = true;
      } 
      if (data.horseh >= 100) {
        this.horsehColor = "#ffffff";
      } else if(data.horseh <= 30){
        this.horsehColor = "#ffc7c7";
      } else{
        this.horsehColor = "#ffffff";
      }

      if (data.dynamicHunger == true) {
        if (data.hunger >= 100) {
          this.showHunger = false; }
          else{
            this.showHunger = true;
          }
      } else if (data.dynamicHunger == false){
        this.showHunger = true;
      } 
      if (data.hunger >= 100) {
        this.hungerColor = "#ffffff";
      } else if(data.hunger <= 30){
        this.hungerColor = "#ffc7c7";
      } else{
        this.hungerColor = "#ffffff";
      }

      if (data.dynamicThirst == true) {
        if (data.thirst >= 100) {
          this.showThirst = false; }
          else{
            this.showThirst = true;
          }
      } else if (data.dynamicThirst == false){
        this.showThirst = true;
      } 
      if (data.thirst >= 100) {
        this.thirstColor = "#ffffff";
      } else if(data.thirst <= 30){
        this.thirstColor = "#c7e5ff";
      } else{
        this.thirstColor = "#ffffff";
      }

      if (data.talking) {
        this.talkingColor = "#D64763";
      } else if (data.talking) {
        this.talkingColor = '#FFFF3E';
      } else {
        this.talkingColor = "#FFFFFF";
      }

      if (data.isPaused === 1) {
        this.show = false;
      }
    },
  },
};
const app2 = Vue.createApp(playerHud);
app2.use(Quasar);
app2.mount("#ui-container");

const app4 = Vue.createApp(baseplateHud);
app4.use(Quasar);
app4.mount("#baseplate-container");
