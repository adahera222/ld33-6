class Canvas
	controlFactor: 4 * (Math.sqrt(2) - 1) / 3 
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
	drawCircle: (x, y, radius, color = '#F00', stroke = 'none') =>
		@ctx.beginPath()
		@ctx.arc(x, y, radius, 0, Math.PI * 2)
		@ctx.fillStyle = color
		@ctx.fill()
		@ctx.strokeStyle = stroke
		@ctx.stroke()
	drawText: (string, x, y, color = '#F00') =>
		@ctx.font = '1em \'Alegreya Sans\''
		@ctx.textAlign = 'center'
		@ctx.fillStyle = color
		@ctx.fillText(string, x, y)
	drawQCurve: (startX, startY, controlX, controlY, endX, endY, width = 1, color = '#FFF') =>
		@ctx.beginPath()
		@ctx.moveTo(startX, startY)
		@ctx.quadraticCurveTo(controlX, controlY, endX, endY)
		@ctx.strokeStyle = color
		@ctx.lineWidth = width
		@ctx.stroke()
	drawMyCurveH: (startX, startY, endX, endY, height, width = 1, color = '#FFF') =>
		@ctx.beginPath()
		@ctx.moveTo(startX, startY)
		midX = (startX + endX) / 2
		midY = ((startY + endY) / 2) + height
		controlHeight = height * @controlFactor
		@ctx.bezierCurveTo(startX, startY + controlHeight, midX - Math.abs(controlHeight), midY, midX, midY)
		@ctx.bezierCurveTo(midX + Math.abs(controlHeight), midY, endX, endY + controlHeight, endX, endY)
		@ctx.strokeStyle = color
		@ctx.lineWidth = width
		@ctx.stroke()
	drawMyCurveV: (startX, startY, endX, endY, height, width = 1, color = '#FFF') =>
		@ctx.beginPath()
		@ctx.moveTo(startX, startY)
		midX = ((startX + endX) / 2) + height
		midY = (startY + endY) / 2
		controlHeight = height * @controlFactor
		@ctx.bezierCurveTo(startX + controlHeight, startY, midX, midY - Math.abs(controlHeight), midX, midY)
		@ctx.bezierCurveTo(midX, midY + Math.abs(controlHeight), endX  + controlHeight, endY, endX, endY)
		@ctx.strokeStyle = color
		@ctx.lineWidth = width
		@ctx.stroke()

module.exports = Canvas