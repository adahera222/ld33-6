Detonator = require './Detonator'

class Enemy extends Detonator
	maxSpeed: 0.1
	size: 5
	constructor: (x, y) ->
		@maxSpeed = 0.05 + Math.random() * 0.1
		super(x,y)
	detonationSize: () =>
		ds = super()
		console.log('ds: ' + ds)
		return ds
	tick: (elapsed) =>
		if @target
			@velocity.x = @target.x - @x
			@velocity.y = @target.y - @y
		super(elapsed, false)
	multiplier: =>
		return Math.round @area()

module.exports = Enemy