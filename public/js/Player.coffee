Mover = require './Mover'

class Player extends Mover
	target: {x: 0, y: 0}
	tick: (elapsed) =>
		super(elapsed)
		@velocity.x = @target.x - @x
		@velocity.y = @target.y - @y

module.exports = Player