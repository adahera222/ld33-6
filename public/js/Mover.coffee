Vector = require './Vector'

class Mover
	maxSpeed: 0.75
	constructor: ->
		@x = 0
		@y = 0
		@velocity = new Vector(0,0)
	tick: (elapsed) =>
		targDistance = @velocity.length()
		max = @maxSpeed * elapsed
		threshold = @maxSpeed * 400
		if targDistance > threshold
			@velocity.sizeTo(max)
		else
			@velocity.sizeTo(max * targDistance / threshold)
		@x += @velocity.x
		@y += @velocity.y
	toString: =>
		return @x + ", " + @y

module.exports = Mover