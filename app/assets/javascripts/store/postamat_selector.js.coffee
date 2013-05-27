$ ->
	window.pickpoint_data = {}
	images = {
		pvz: new google.maps.MarkerImage('/assets/store/pickpoint_office.png'),
		apt: new google.maps.MarkerImage('/assets/store/pickpoint_postamat.png'),
		main: new google.maps.MarkerImage('/assets/store/pickpoint_home.png')
	}
	
	generate_small_map = (data)->
		map_opts =
			center: new google.maps.LatLng(data.lat, data.lng),
			zoom: 14,
			streetViewControl: false,
			overviewMapControl: false,
			mapTypeControl: false,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		map = new google.maps.Map document.getElementById("small_map_canvas"), map_opts
		marker_opts =
			position: new google.maps.LatLng(data.lat, data.lng),
			content: data.name,
			icon: images[data.ptype]
			map: map
		marker = new google.maps.Marker marker_opts
		
	if selected_pickpoint = ($ '#selected_pickpoint').data('point')
		($ '#pickpoint_type_select').hide()
		($ '#pickpoint_form_wrapper').slideDown()
		($ '#selected_pickpoint').html JST['store/templates/selected_point'](point: selected_pickpoint, week_days: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'])
		generate_small_map(selected_pickpoint)

	if ($ '#pickpoint_map_widget').length == 1
		geocoder = new google.maps.Geocoder
		map_opts =
			center: new google.maps.LatLng(55.751801,37.616059),
			zoom: 10,
			streetViewControl: false,
			overviewMapControl: false,
			mapTypeControl: false,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		map = new google.maps.Map document.getElementById("map_canvas"), map_opts

		info_window = new google.maps.InfoWindow

		markers = []
		$.each pickpoints, (i, p) ->
			marker_opts =
				position: new google.maps.LatLng(p.lat, p.lng),
				content: p,
				icon: images[p.ptype]
				map: map
			marker = new google.maps.Marker marker_opts
			google.maps.event.addListener marker, 'click', ->
				unless marker.detailed_html
					info_window.setContent JST['store/templates/point_loading']()
					$.ajax(url: "/pickpoints/#{p.id}").done (data) ->
						window.pickpoint_data[data.num] = data
						# marker.detailed = data
						marker.detailed_html = JST['store/templates/point'](point: data, week_days: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'])
						info_window.setContent marker.detailed_html
				else
					info_window.setContent marker.detailed_html
				info_window.open map, marker
			markers.push marker

		google.maps.event.addListener map, 'click', -> info_window.close()

		mc_opts =
			gridSize: 50, 
			maxZoom: 9
		mc = new MarkerClusterer map, markers, mc_opts

		($ '#map_finder').on 'submit', ->
			address = ($ this).find('input.search_field').val()
			geocoder.geocode {address: address}, (results, status) ->
				if (status == google.maps.GeocoderStatus.OK)
					loc = results[0].geometry.location
					nst = getNearest(loc).position
					sw = new google.maps.LatLng(Math.min(loc.lat(), nst.lat()), Math.min(loc.lng(), nst.lng()))
					ne = new google.maps.LatLng(Math.max(loc.lat(), nst.lat()), Math.max(loc.lng(), nst.lng()))
					bounds = new google.maps.LatLngBounds(sw, ne)
					map.fitBounds(bounds)
				else
					alert 'Адрес не найден'
			return false

		($ 'body').on 'click', '.pickpoint_select a', (e) ->
			e.preventDefault()
			point = window.pickpoint_data[($ e.target).data('pickpoint')]
			($ '#order_pickpoint_customer_attributes_pickpoint_num').val(point.num)
			info_window.close()
			($ '#pickpoint_map_widget').slideUp()
			($ '#selected_pickpoint').data('point', point)
			($ '#selected_pickpoint').html JST['store/templates/selected_point'](point: point, week_days: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'])
			generate_small_map(point)
			false

		($ 'body').on 'click', '.pickpoint_change a', (e) ->
			e.preventDefault()
			($ '#order_pickpoint_customer_attributes_pickpoint_num').val('')
			($ '#selected_pickpoint').html('')
			($ '#pickpoint_form_wrapper').slideUp()
			($ '#pickpoint_type_select').slideDown()
			false
			
		($ '#pickpoint_choose_point').click (e) ->
			e.preventDefault()
			($ '#pickpoint_type_select').slideUp()
			($ '#pickpoint_map_widget').slideDown()
			($ '#pickpoint_form_wrapper').slideDown()
			google.maps.event.trigger(map, 'resize')
			map.setCenter(new google.maps.LatLng(55.751801,37.616059))
			false

		($ '#pickpoint_chose_self').click (e) ->
			e.preventDefault()
			point = ($ '#selected_pickpoint').data('homePoint')
			($ '#order_pickpoint_customer_attributes_pickpoint_num').val(point.num)
			($ '#pickpoint_type_select').slideUp()
			($ '#pickpoint_form_wrapper').slideDown()
			($ '#selected_pickpoint').data('point', point)
			($ '#selected_pickpoint').html JST['store/templates/selected_point'](point: point, week_days: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'])
			generate_small_map(point)
			false

		getNearest = (geocoded) ->
			nearest =
				marker: null,
				distance: 1000000
			$.each markers, (i, marker) ->
				d = distance(marker.position, geocoded)
				if d < nearest.distance
					nearest.marker = marker
					nearest.distance = d
			nearest.marker

		distance = (a, b) ->
			r = 6371
			k = Math.PI / 180
			x = k * (b.lng() - a.lng()) * Math.cos(k * (a.lat() + b.lat()) / 2)
			y = k * (b.lat() - a.lat())
			Math.sqrt(x * x + y * y) * r