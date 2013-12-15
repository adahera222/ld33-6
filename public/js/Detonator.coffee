Mover = require './Mover'

class Detonator extends Mover
	detonated: false
	detonationTime: 2000
	detonate: =>
		unless @detonated then @detonated = 1
	tick: (elapsed) =>
		if @detonated
			@detonated += elapsed
		else # move player if not detonated
			super(elapsed)
	detonationSize: () =>
		if @detonated and @detonated < @detonationTime
			return @size + @detonated / 25
		else return 0
	collidable: () =>
		return not @detonated or @detonated < @detonationTime
	collidableSize: () =>
		if not @detonated then return @size
		else return @detonationSize()

module.exports = Detonator