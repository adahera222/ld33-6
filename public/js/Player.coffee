Detonator = require './Detonator'

class Player extends Detonator
	target: {x: 0, y: 0}
	tick: (elapsed) =>
		super(elapsed)
		@velocity.x = @target.x - @x
		@velocity.y = @target.y - @y

module.exports = Player