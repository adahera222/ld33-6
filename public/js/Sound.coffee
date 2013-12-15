sjs = require './soundjs.min'

class Sound
	constructor: ->
		createjs.Sound.addEventListener("fileload", createjs.proxy(@fileload, @))
		['blip', 'blip2', 'detonate', 'small-explosion'].forEach (sound) =>
			createjs.Sound.registerSound("sounds/" + sound + ".wav", sound);
	fileload: (e) =>
		console.log "loaded " + e.src
	play: (soundname = 'blip') =>
		instance = createjs.Sound.play(soundname)
		instance.volume = 0.5;

module.exports = Sound