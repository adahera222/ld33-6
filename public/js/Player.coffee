Mover = require './Mover'

class Player extends Mover
	target: {x: 0, y: 0}
	tick: (elapsed) =>
		@velocity.x = @target.x - @x
		@velocity.y = @target.y - @y
		super(elapsed)

module.exports = Player