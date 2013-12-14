class Vector
	constructor: (@x = 0, @y = 0) ->
	length: () =>
		return Math.sqrt(Math.pow(@x, 2) + Math.pow(@y, 2))
	sizeTo: (length) =>
		curLen = @length()
		if curLen isnt 0
			ratio = length / curLen
			@x *= ratio
			@y *= ratio
	toString: () =>
		return "x: " + @x + ", y: " + @y

module.exports = Vector