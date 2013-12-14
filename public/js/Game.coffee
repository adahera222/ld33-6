View = require './View'
Player = require './Player'

class Game
	lastTime: 0
	p: null
	v: null
	constructor: ->
		@p = new Player()
		@v = new View(@)
		requestAnimationFrame @tick
	over: (x, y) =>
		@p.target.x = x
		@p.target.y = y
	tick: (time) =>
		elapsed = time - @lastTime
		@lastTime = time
		@p.tick elapsed
		@v.render()
		requestAnimationFrame @tick

module.exports = Game