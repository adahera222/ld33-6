Jsfxr = require './jsfxr'

class Sound
	constructor: ->
		@s1 = jsfxr([2,0,0.0225,0.0155,0.29,0.37,0.11,-0.0007,0.6833,0.15,0.63,0.0248,0.67,0,-0.0505,0.19,-0.04,-0.3199,0.82,-0.82,0.09,0.01,-0.071,0.5])
		@player = new Audio()
		@player.src = @s1
	blip: =>
		console.log 'blip'
		@player.play()

module.exports = Sound