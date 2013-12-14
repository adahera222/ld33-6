Canvas = require './Canvas'

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
		@c.resize(@width, @height)
		@render()
	mousemove: (e) =>
		@game.mousemove(e.x, e.y)
	render: () =>
		@c.clear()
		p = @game.p
		if p
			@c.drawCircle p.x, p.y, 10
			@c.drawCircle p.target.x, p.target.y, 5, 'rgba(0,0,0,0.5)'
			@c.drawLine p.x, p.y, p.target.x, p.target.y, 2, 'rgba(0,0,0,0.1)'

module.exports = View