Detonator = require './Detonator'

class Enemy extends Detonator
	maxSpeed: 0.1
	size: 5
	constructor: (x, y) ->
		@maxSpeed = 0.05 + Math.random() * 0.2
		super(x,y)
	detonationSize: () =>
		ds = super()
		return ds
	tick: (elapsed) =>
		if @target
			@velocity.x = @target.x - @x
			@velocity.y = @target.y - @y
		super(elapsed, false)
	multiplier: =>
		return Math.max(1, Math.round(@area() / (Math.PI * 12)))

module.exports = Enemy