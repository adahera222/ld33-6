View = require './View'
Player = require './Player'

STATES = {
	LOADING: "Loading"
	MENU: "Menu"
	PLAY: "Playing"
}

class Game
	state: STATES.LOADING
	lastTime: 0
	p: null
	v: null
	constructor: ->
		@v = new View(@)
		window.addEventListener 'load', @loaded
	loaded: =>
		console.log "LOADED"
		@state = STATES.MENU
		@v.hideLoading()
	mousemove: (x, y) =>
		if @p
			@p.target.x = x
			@p.target.y = y
	tick: (time) =>
		elapsed = time - @lastTime
		@lastTime = time
		@p.tick elapsed
		@v.render()
		requestAnimationFrame @tick
	playClicked: =>
		if @state isnt STATES.MENU
			throw new Error 'Somehow clicked play while not in menu state'
		else
			@v.hideMenu()
			@p = new Player()
			requestAnimationFrame @tick

module.exports = Game