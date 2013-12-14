Canvas = require './Canvas'

class View
	constructor: (@game) ->
		@c = new Canvas()
		window.addEventListener('resize', @resize)
		window.addEventListener('mousemove', @over)
		@resize()
	resize: =>
		@width = window.innerWidth
		@height = window.innerHeight
		@c.resize(@width, @height)
		@render()
	over: (e) =>
		@game.over(e.x, e.y)
	render: () =>
		@c.clear()
		p = @game.p
		@c.drawCircle p.x, p.y, 10
		@c.drawCircle p.target.x, p.target.y, 10
		@c.drawLine p.x, p.y, p.target.x, p.target.y

module.exports = View