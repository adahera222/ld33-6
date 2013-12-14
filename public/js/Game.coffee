View = require './View'
Player = require './Player'
Enemy = require './Enemy'
STATES = require './STATES'

class Game
	state: STATES.LOADING
	lastTime: 0
	p: null
	enemies: null
	v: null
	constructor: ->
		@state = STATES.LOADING
		@v = new View(@)
		window.addEventListener 'load', @loaded
	loaded: =>
		@state = STATES.MENU
		@v.hideLoading()
	mousemove: (x, y) =>
		if @p
			@p.target.x = x
			@p.target.y = y
	tick: (time) =>
		if @state is STATES.PLAY
			elapsed = time - @lastTime
			@lastTime = time
			while @enemies.length + 2 < time / 2000
				e = new Enemy()
				e.target = @p
				@enemies.push e
			@p.tick elapsed
			@enemies.forEach (e) => 
				e.tick(elapsed)
				xdiff = @p.x - e.x
				ydiff = @p.y - e.y
				if (@collisionCheck(@p, e))
					@state = STATES.MENU
					@v.showMenu()
			@v.render()
		requestAnimationFrame @tick
	collisionCheck: (a, b) =>
		xdiff = a.x - b.x
		ydiff = a.y - b.y
		return Math.sqrt(Math.pow(xdiff, 2) + Math.pow(ydiff, 2)) < b.size + a.size
	playClicked: =>
		if @state isnt STATES.MENU
			throw new Error 'Somehow clicked play while not in menu state'
		else
			@state = STATES.PLAY
			@v.hideMenu()
			@p = new Player()
			@enemies = []
			requestAnimationFrame @tick

module.exports = Game