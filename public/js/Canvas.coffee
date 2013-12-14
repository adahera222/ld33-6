class Canvas
	constructor: ->
		@elt = document.createElement('canvas')
		document.getElementsByTagName('body')[0].appendChild(@elt)
		@ctx = @elt.getContext('2d')
	resize: (width, height) =>
		attrs = width: width, height: height
		for attr, val of attrs
			@elt.setAttribute(attr, val + 'px')
	clear: =>
		@ctx.clearRect(0, 0, window.innerWidth, window.innerHeight)
	drawLine: (x1, y1, x2, y2, width = 10, color = '#F00') =>
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