Canvas = require './Canvas'
STATES = require './STATES'

class View
	targetTouch: null
	constructor: (@game) ->
		@c = new Canvas()
		@ui = document.getElementById 'ui'
		@score = document.getElementById 'score'
		@touchDetonator = document.getElementById 'touch-detonate'
		@mainMenu = document.getElementById 'main-menu'
		@deadMenu = document.getElementById 'dead-menu'
		@deadScore = document.getElementById 'dead-score'
		@helpText = document.getElementById 'help'
		@loading = document.getElementById 'loading'
		@playButton = document.getElementById 'play-button'
		@playButton.addEventListener 'click', @passthruBlur(@playButton, @game.playClicked)
		@replayButton = document.getElementById 'play-again-button'
		@replayButton.addEventListener 'click', @passthruBlur(@replayButton, @game.replayClicked)
		window.addEventListener('resize', @resize)
		window.addEventListener('mousemove', @mousemove)
		window.addEventListener('keydown', @keydown)
		if window.ontouchstart isnt undefined
			window.addEventListener('touchstart', @touchstart)
			window.addEventListener('touchmove', @touchmove)
			window.addEventListener('touchend', @touchend)
			@touchDetonator.classList.toggle('hidden', false)
			@touchDetonator.addEventListener('touchstart', @game.detonatePressed)
		@resize()
	passthruBlur: (element, cb) =>
		return (e) =>
			element.blur()
			cb e
	hideLoading: =>
		@loading.classList.toggle('fade-out', true)
	showMenu: =>
		@showElement @mainMenu
	hideMenu: =>
		@hideElement @mainMenu
	showDead: () =>
		@showElement @deadMenu
		score = Math.round @game.score
		@deadScore.textContent = score + ' point'
		if score isnt 1 then @deadScore.textContent += 's'
		@showElement @score
	hideDead: =>
		@hideElement @deadMenu
	showUI: =>
		@showElement @ui
	hideUI: =>
		@hideElement @ui
	showScore: =>
		@showElement @score
	showElement: (e) =>
		e.classList.toggle('hidden', false)
		e.classList.toggle('fade-out', false)
	hideElement: (e) =>
		e.classList.toggle('fade-out', true)
	resize: =>
		@width = window.innerWidth
		@height = window.innerHeight
		@game.resize(@width, @height)
		@c.resize(@width, @height)
		@render()
	mousemove: (e) =>
		@game.mousemove(e.x, e.y)
	touchstart: (e) =>
		if @game.state is STATES.PLAY
			e.preventDefault()
			if @targetTouch is null
				tt = e.changedTouches[0]
				@targetTouch = tt.identifier
				@game.mousemove(tt.pageX, tt.pageY)
	touchmove: (e) =>
		if @game.state is STATES.PLAY
			i = 0
			while i < e.changedTouches.length
				ct = e.changedTouches[i]
				i++
				if @targetTouch is ct.identifier
					@game.mousemove(ct.pageX, ct.pageY)
			e.preventDefault()
	touchend: (e) =>
		if @game.state is STATES.PLAY
			i = 0
			while i < e.changedTouches.length
				ct = e.changedTouches[i]
				i++
				if @targetTouch is ct.identifier
					@targetTouch = null
	keydown: (e) =>
		if e.keyCode is 32 # space bar
			@game.detonatePressed()
	render: () =>
		@c.clear()
		@score.textContent = Math.round(@game.score)
		if @game.state is STATES.PLAY
			if @game.p.detonated
				ratio = @game.p.detonated / @game.p.detonationTime
				if ratio < 1
					ratio = 1 - ratio
					detStroke = 'rgba(0,0,0,' + ratio/2 + ')'
					detFill = 'rgba(0,0,0,' + (ratio / 4) + ')'
					@c.drawCircle @game.p.x, @game.p.y, @game.p.detonationSize(), detFill, detStroke
			else
				# player
				@c.drawCircle @game.p.x, @game.p.y, @game.p.size, 'rgba(0,0,0,1)'
				# target
				@c.drawCircle @game.p.target.x, @game.p.target.y, 5, 'rgba(0,0,0,0.5)'
				@c.drawLine @game.p.x, @game.p.y, @game.p.target.x, @game.p.target.y, 2, 'rgba(0,0,0,0.1)'
			# enemies
			@game.enemies.forEach (e) =>
				if e.detonated
					ratio = e.detonated / e.detonationTime
					if ratio < 1
						ratio = 1 - ratio
						detStroke = 'rgba(0,0,0,' + (ratio / 2) + ')'
						detFill = 'rgba(0,0,0,' + (ratio / 4) + ')'
						@c.drawCircle e.x, e.y, e.detonationSize(), detFill, detStroke
				else
					@c.drawCircle e.x, e.y, e.size, '#F00'

module.exports = View