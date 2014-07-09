# A class-based template for jQuery plugins in Coffeescript
#
#     $('.target').myPlugin({ paramA: 'not-foo' });
#     $('.target').myPlugin('myMethod', 'Hello, world');
#
# Check out Alan Hogan's original jQuery plugin template:
# https://github.com/alanhogan/Coffeescript-jQuery-Plugin-Template	
#
(($, window) ->

	# Define the plugin class
	class CheckboxPlugin

		defaults:
			paramA: 'foo'
			paramB: 'bar'

		constructor: (el, options) ->
			@options = $.extend({}, @defaults, options)
			@$el = $(el)
			@init()

		# Additional plugin methods go here
		init: (echo) ->

			self = @
						
			@$el.wrap('<div class="customCheckboxContainer"></div>')
			
			parent = @$el.parent()

			@$el.addClass('hidden')
			
			parent.click (event)->				
				self.$el.click()	

			@$el.click (event)->
				parent.toggleClass('checked')
				
			return 
								
	# Define the plugin
	$.fn.extend customCheckbox: (option, args...) ->
		@each ->
			$this = $(this)
			data = $this.data('checkboxPlugin')

			if !data
				$this.data 'checkboxPlugin', (data = new CheckboxPlugin(this, option))
			if typeof option == 'string'
				data[option].apply(data, args)

) window.jQuery, window