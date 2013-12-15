View = require './View'
Player = require './Player'
Enemy = require './Enemy'
STATES = require './STATES'
Sound = require './Sound'

_ = require 'underscore'

raf = require './raf' # request animation frame polyfill

class Game
	state: STATES.LOADING
	lastTime: null
	lastStart: null
	enemiesSpawned: 0
	p: null
	enemies: null
	v: null
	lastMouse: x: 0, y: 0
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
	detonatePressed: =>
		if @state is STATES.PLAY
			@sound.play('detonate')
			@p.detonate()
	tick: (time) =>
		if !@lastStart
			@lastStart = time
			@lastTime = time
			raf @tick
		else if @state is STATES.PLAY
			elapsed = time - @lastTime
			# elapsed = Math.max(elapsed, 1000) # protect against long delays
			@lastTime = time
			while (not @p.detonated) and @enemiesSpawned < (time - @lastStart) / 2000
				@spawnEnemy()
			@p.tick elapsed
			@enemies.forEach (e, index) => 
				e.tick(elapsed)
				xdiff = @p.x - e.x
				ydiff = @p.y - e.y
				if (@collisionCheck(@p, e))
					@sound.play('small-explosion')
					if @p.detonated # hit player's detonation
						e.detonate()
					else # hit player
						@endGame()
				@enemies[index + 1..].forEach (otherE) =>
					if (@collisionCheck otherE, e) # hit other enemy; combine
						if otherE.detonated and not e.detonated
							@sound.play('small-explosion')
							e.detonate()
						else if e.detonated and not otherE.detonated
							@sound.play('small-explosion')
							otherE.detonate()
						else
							@enemies = _.without @enemies, otherE
							e.targetSize = Math.sqrt(Math.pow(e.size, 2) + Math.pow(otherE.size, 2))
							@sound.play('blip')
			@v.render()
		raf @tick
	spawnEnemy: =>
		x = 0
		y = 0
		mod = @enemiesSpawned % 4
		if mod is 1 or mod is 2
			x = @width
		if mod is 2 or mod is 3
			y = @height
		e = new Enemy(x, y)
		@enemiesSpawned++
		e.target = @p
		@enemies.push e
		@sound.play 'blip2'
	collisionCheck: (a, b) =>
		xdiff = a.x - b.x
		ydiff = a.y - b.y
		if a.collidable() and b.collidable()
			return Math.sqrt(Math.pow(xdiff, 2) + Math.pow(ydiff, 2)) < b.collidableSize() + a.collidableSize()
		else return false
	playClicked: =>
		if @state isnt STATES.MENU then throw new Error 'Somehow clicked play while not in menu state'
		else
			@v.hideMenu() 
			@startGame()
	replayClicked: =>
		if @state isnt STATES.DEAD then throw new Error 'Somehow clicked play while not in menu state'
		else
			@v.hideDead()
			@startGame()
	startGame: =>
		@state = STATES.PLAY
		center = x: @width / 2, y: @height / 2
		@p = new Player(center.x, center.y)
		@p.target = center
		@enemies = []
		@lastTime = null
		@lastStart = null
		@enemiesSpawned = 0
		raf @tick
	endGame: =>
		@state = STATES.DEAD
		@v.showDead()
	resize: (@width, @height) =>

module.exports = Game