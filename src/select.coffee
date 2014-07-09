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
	class SelectPlugin

		defaults:
			searchable: false
			paramB: 'bar'

		constructor: (el, options) ->
			@options = $.extend({}, @defaults, options)
			@$el = $(el)
			@init()

		# Additional plugin methods go here
		init: (echo) ->

			self = @
						
			@$el.wrap('<div class="customSelectContainer"></div>')
			
			parent = @$el.parent()


			@$el.parent().append('<div class="customSelect"></div>')		

			@$el.parent().append('<div class="customSelectLabel"><label>aaa<label></div>')		

			if @options.searchable	
				@$el.siblings('.customSelect').append('<div class="customSelectSearch"><input type="text"/></div>')

			dropdown = parent.find('.customSelect')
				
			container = @$el.siblings('.customSelect').append('<ul></ul>')

			selectedLabel = ''
			
			selectedValue = $(@$el).val()

			@$el.find('option').each (i,opt) ->
				txt = opt.text
				val = opt.value
				container.find('ul').append("<li data-val='#{opt.value}'>#{opt.text}</li>")
				if opt.value is selectedValue
					selectedLabel = opt.text
				return

			@$el.siblings('.customSelectLabel').click (event)->				
				$('.customSelectLabel').not(@).siblings('.customSelect').slideUp('slow')				
				dropdown.slideToggle('slow')

			$(document).on 'click',(event)->
				comp  = event.target
				if $(comp).closest('.customSelectContainer').length is 0
					# parent.removeClass('open')
					dropdown.slideUp('slow')
					return true
				else					
					return true	


			@$el.siblings('.customSelect').find('li').click (event)->
				selectedLabel = $(event.target).text()
				selectedValue = $(event.target).attr('data-val')
				$(self.$el).siblings('.customSelectLabel').find('label').text selectedLabel		
				# parent.removeClass('open')	
				dropdown.slideUp('slow')
				$(self.$el).val selectedValue
				$(self.$el).change(event)

			@$el.addClass('hidden')	  	      

			if selectedLabel.trim().length == 0
				selectedLabel = @$el.find('option:eq(0)').text

			@$el.siblings('.customSelectLabel').find('label').text selectedLabel		
			
			if @options.searchable	
				parent.find('.customSelectSearch input').keyup (event)->
					val = $(@).val()
					re = new RegExp(val,'i')
					parent.find('li').each (i,elem)->
						txt = $(elem).text()
						if re.exec(txt) is null
							$(elem).hide()
						else
							$(elem).show()	

			return 
								
	# Define the plugin
	$.fn.extend customSelect: (option, args...) ->
		@each ->
			$this = $(this)
			data = $this.data('selectPlugin')
			if !data
				$this.data 'selectPlugin', (data = new SelectPlugin(this, option))
			if typeof option == 'string'
				data[option].apply(data, args)

) window.jQuery, window