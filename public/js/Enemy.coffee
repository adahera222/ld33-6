Mover = require './Mover'

class Enemy extends Mover
	maxSpeed: 0.1
	size: 5
	tick: (elapsed) =>
		if @target
			@velocity.x = @target.x - @x
			@velocity.y = @target.y - @y
		super(elapsed, false)

module.exports = Enemy