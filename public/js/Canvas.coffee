class Canvas
	constructor: ->
		@elt = document.createElement('canvas')
		document.getElementsByTagName('body')[0].appendChild(@elt)
		@ctx = @elt.getContext('2d')
		window.addEventListener('resize', @resize)
		@resize()
	resize: =>
		attrs = width: window.innerWidth, height: window.innerHeight
		for attr, val of attrs
			@elt.setAttribute(attr, val + 'px')
			@[attr] = val
		@render()
	render: =>
		@drawCircle(100, 100, 100)
		@drawLine(200, 200, 300, 300)
	drawLine: (x1, y1, x2, y2, color = '#F00', width = 10) =>
		@ctx.beginPath()
		@ctx.moveTo(x1, y1)
		@ctx.lineTo(x2, y2)
		@ctx.lineWidth = width
		@ctx.strokeStyle = color
		@ctx.stroke()
	drawCircle: (x, y, radius, color = '#F00') =>
		@ctx.beginPath()
		@ctx.arc(x, y, radius, 0, Math.PI * 2)
		@ctx.fillStyle = color
		@ctx.fill()

module.exports = Canvas