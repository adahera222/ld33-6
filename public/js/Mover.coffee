Vector = require './Vector'

class Mover
	maxSpeed: 0.75
	size: 10
	constructor: (@x = 0, @y = 0) ->
		@velocity = new Vector(0,0)
		@targetSize = @size
	tick: (elapsed, slow = true) =>
		prespeed = @velocity.length()
		max = @maxSpeed * elapsed
		threshold = @maxSpeed * 400
		if prespeed > threshold or not slow
			@velocity.sizeTo(max)
		else
			@velocity.sizeTo(max * prespeed / threshold)
		@x += @velocity.x
		@y += @velocity.y
		sDiff = @targetSize - @size
		@size += elapsed * sDiff / 60
	toString: =>
		return @x + ", " + @y

module.exports = Mover