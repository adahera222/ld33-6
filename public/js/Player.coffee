Vector = require './Vector'

class Player
	maxSpeed: 10
	target: {x: 0, y: 0}
	constructor: ->
		@x = 0
		@y = 0
		@velocity = new Vector(0,0)
	tick: (elapsed) =>
		@velocity.x = @target.x - @x
		@velocity.y = @target.y - @y
		if @velocity.length() > @maxSpeed
			@velocity.sizeTo(@maxSpeed)
		@x += @velocity.x
		@y += @velocity.y
	toString: =>
		return @x + ", " + @y
		

module.exports = Player