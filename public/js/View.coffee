Canvas = require './Canvas'
STATES = require './STATES'

class View
	constructor: (@game) ->
		@c = new Canvas()
		@menu = document.getElementById 'menu'
		@loading = document.getElementById 'loading'
		@playButton = document.getElementById 'play-button'
		@playButton.addEventListener 'click', @game.playClicked
		window.addEventListener('resize', @resize)
		window.addEventListener('mousemove', @mousemove)
		@resize()
	hideLoading: =>
		@loading.classList.toggle('fade-out', true)
	showMenu: =>
		@menu.classList.toggle('hidden', false)
	hideMenu: =>
		@menu.classList.toggle('hidden', true)
	resize: =>
		@width = window.innerWidth
		@height = window.innerHeight
		@game.resize(@width, @height)
		@c.resize(@width, @height)
		@render()
	mousemove: (e) =>
		@game.mousemove(e.x, e.y)
	render: () =>
		@c.clear()
		if @game.state is STATES.PLAY
			# player
			@c.drawCircle @game.p.x, @game.p.y, @game.p.size
			# target
			@c.drawCircle @game.p.target.x, @game.p.target.y, 5, 'rgba(0,0,0,0.5)'
			@c.drawLine @game.p.x, @game.p.y, @game.p.target.x, @game.p.target.y, 2, 'rgba(0,0,0,0.1)'
			# enemies
			@game.enemies.forEach (e) =>
				@c.drawCircle e.x, e.y, e.size, '#0F0'

module.exports = View