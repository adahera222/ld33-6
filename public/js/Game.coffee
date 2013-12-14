View = require './View'
Player = require './Player'
Enemy = require './Enemy'
STATES = require './STATES'
_ = require 'underscore'
Sound = require './Sound'

class Game
	state: STATES.LOADING
	lastTime: 0
	p: null
	enemies: null
	v: null
	lastMouse: x: 0, y: 0
	lastStart: 0
	constructor: ->
		@state = STATES.LOADING
		@v = new View(@)
		@sound = new Sound()
		window.addEventListener 'load', @loaded
	loaded: =>
		@state = STATES.MENU
		@v.hideLoading()
	mousemove: (x, y) =>
		@lastMouse = x: x, y: y
		if @p
			@p.target.x = x
			@p.target.y = y
	tick: (time) =>
		if @state is STATES.PLAY
			elapsed = time - @lastTime
			# elapsed = Math.max(elapsed, 1000) # protect against long delays
			@lastTime = time
			while @enemies.length + 2 < (time - @lastStart) / 2000# and false
				x = 0
				y = 0
				mod = @enemies.length % 4
				if mod is 1 or mod is 2
					x = @width
				if mod is 2 or mod is 3
					y = @height
				e = new Enemy(x, y)
				e.target = @p
				@enemies.push e
			@p.tick elapsed
			@enemies.forEach (e, index) => 
				e.tick(elapsed)
				xdiff = @p.x - e.x
				ydiff = @p.y - e.y
				if (@collisionCheck(@p, e)) # hit player
					@state = STATES.MENU
					@v.showMenu()
				@enemies[index + 1..].forEach (otherE) =>
					if (@collisionCheck otherE, e) # hit other enemy; combine
						@enemies = _.without @enemies, otherE
						e.targetSize = Math.sqrt(Math.pow(e.size, 2) + Math.pow(otherE.size, 2))
						@sound.blip()
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
			@p = new Player(@lastMouse.x, @lastMouse.y)
			@p.target = @lastMouse
			@enemies = []
			@lastStart = @lastTime
			requestAnimationFrame @tick
	resize: (@width, @height) =>

module.exports = Game