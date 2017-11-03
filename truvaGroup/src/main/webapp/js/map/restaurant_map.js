/**
 * MapIt
 *
 * @copyright	Copyright 2013, Dimitris Krestos
 * @license		Apache License, Version 2.0 (http://www.opensource.org/licenses/apache2.0.php)
 * @link		http://vdw.staytuned.gr
 * @version		v0.2.2
 */

document.write('<scr' + 'ipt type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false" ></scr' + 'ipt>');
;(function($, window, undefined) {
    "use strict";

    $.fn.mapit = function(options) {

        var defaults = {
            latitude: -37.813294,
            longitude: 144.959676,
            zoom: 15,
            type: 'ROADMAP',
            scrollwheel: false,
            marker: {
                latitude: -37.815994,
                longitude: 144.952676,
                icon: 'assets/images/map/res_map_07.png',
                title: 'Restaurants Details',
                open: false,
                center: true
            },
            address: '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_04.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">2016 Italian Restaurant </a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Non-Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>',
            styles: 'GRAYSCALE',
            locations: [
                [-37.818294, 144.956676, 'assets/images/map/res_map_01.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_04.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Italian pasta restaurant</a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0'],
                [-37.821294, 144.959676, 'assets/images/map/res_map_02.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_05.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Turkish Ravioli</a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Non-Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0'],
                [-37.819294, 144.951676, 'assets/images/map/res_map_03.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_06.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Wine & Meat House </a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0'],
                [-37.811294, 144.959676, 'assets/images/map/res_map_04.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_07.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Inner meat restaurant</a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Non-Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0'],
                [-37.811294, 144.951676, 'assets/images/map/res_map_05.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_08.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Fresh fish restaurant</a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Non-Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0'],
                [-37.817294, 144.944376, 'assets/images/map/res_map_06.png', 'Restaurants Details', '<div class="mapbox-wrap clearfix"><div class="mapbox-figure"><img src="assets/images/uploads/restaurant_09.jpg" alt="" class="img-responsive"></div><div class="mapbox-content"><h4><a href="#">Vegetable market area</a></h4><div class="mapbox-rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><small class="mapbox-price">Vegetarian</small><div class="mapbox-address"><p>PO Box 16122 Collins Street West Victoria 8007 Australia</p></div></div></div>', false, '0']
            ],
            origins: [
                ['-37.818294', '144.956676'],
                ['-37.811294', '144.959676']
            ]
        };

        var options = $.extend(defaults, options);

        $(this).each(function() {

            var $this = $(this);


            // Init Map
            var directionsDisplay = new google.maps.DirectionsRenderer();

            var mapOptions = {
                scrollwheel: options.scrollwheel,
                scaleControl: false,
                center: options.marker.center ? new google.maps.LatLng(options.marker.latitude, options.marker.longitude) : new google.maps.LatLng(options.latitude, options.longitude),
                zoom: options.zoom,
                mapTypeId: eval('google.maps.MapTypeId.' + options.type)
            };
            var map = new google.maps.Map(document.getElementById($this.attr('id')), mapOptions);
            directionsDisplay.setMap(map);

                // Styles
                if (options.styles) {
                    var GRAYSCALE_style = [{featureType:"all",elementType:"all",stylers:[{saturation: -100}]}];
                    var MIDNIGHT_style  = [{featureType:'water',stylers:[{color:'#e4745a'}]},{featureType:'landscape',stylers:[{color:'#e4745a'}]},{featureType:'poi',elementType:'geometry',stylers:[{color:'#e4745a'},{lightness:5}]},{featureType:'road.highway',elementType:'geometry.fill',stylers:[{color:'#000000'}]},{featureType:'road.highway',elementType:'geometry.stroke',stylers:[{color:'#0b434f'},{lightness:25}]},{featureType:'road.arterial',elementType:'geometry.fill',stylers:[{color:'#000000'}]},{featureType:'road.arterial',elementType:'geometry.stroke',stylers:[{color:'#0b3d51'},{lightness:16}]},{featureType:'road.local',elementType:'geometry',stylers:[{color:'#000000'}]},{elementType:'labels.text.fill',stylers:[{color:'#ffffff'}]},{elementType:'labels.text.stroke',stylers:[{color:'#000000'},{lightness:13}]},{featureType:'transit',stylers:[{color:'#146474'}]},{featureType:'administrative',elementType:'geometry.fill',stylers:[{color:'#000000'}]},{featureType:'administrative',elementType:'geometry.stroke',stylers:[{color:'#144b53'},{lightness:14},{weight:1.4}]}]
                    var BLUE_style          = [{featureType:'water',stylers:[{color:'#46bcec'},{visibility:'on'}]},{featureType:'landscape',stylers:[{color:'#f2f2f2'}]},{featureType:'road',stylers:[{saturation:-100},{lightness:45}]},{featureType:'road.highway',stylers:[{visibility:'simplified'}]},{featureType:'road.arterial',elementType:'labels.icon',stylers:[{visibility:'off'}]},{featureType:'administrative',elementType:'labels.text.fill',stylers:[{color:'#444444'}]},{featureType:'transit',stylers:[{visibility:'off'}]},{featureType:'poi',stylers:[{visibility:'off'}]}]
                    var mapType = new google.maps.StyledMapType(eval(options.styles + '_style'), { name: options.styles });
                    map.mapTypes.set(options.styles, mapType);
                    map.setMapTypeId(options.styles);
                }
                
            // Home Marker
            var home = new google.maps.Marker({
                map: map,
                position: new google.maps.LatLng(options.marker.latitude, options.marker.longitude),
                icon: new google.maps.MarkerImage(options.marker.icon),
                title: options.marker.title
            });

            // Add info on the home marker
            var info = new google.maps.InfoWindow({
                content: options.address
            });

            // Open the info window immediately
            if (options.marker.open) {
                info.open(map, home);
            } else {
                google.maps.event.addListener(home, 'click', function() {
                    info.open(map, home);
                });
            };

            // Create Markers (locations)
            var infowindow = new google.maps.InfoWindow();
            var marker, i;
            var markers = [];

            for (i = 0; i < options.locations.length; i++) {

                // Add Markers
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(options.locations[i][0], options.locations[i][1]),
                    map: map,
                    icon: new google.maps.MarkerImage(options.locations[i][2] || options.marker.icon),
                    title: options.locations[i][3]
                });

                // Create an array of the markers
                markers.push(marker);

                // Init info for each marker
                google.maps.event.addListener(marker, 'click', (function(marker, i) {
                    return function() {
                        infowindow.setContent(options.locations[i][4]);
                        infowindow.open(map, marker);
                    }
                })(marker, i));

            };

            // Directions
            var directionsService = new google.maps.DirectionsService();

            $this.on('route', function(event, origin) {
                var request = {
                    origin: new google.maps.LatLng(options.origins[origin][0], options.origins[origin][1]),
                    destination: new google.maps.LatLng(options.marker.latitude, options.marker.longitude),
                    travelMode: google.maps.TravelMode.DRIVING
                };
                directionsService.route(request, function(result, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(result);
                    };
                });
            });

            // Hide Markers Once (helper)
            $this.on('hide_all', function() {
                for (var i = 0; i < options.locations.length; i++) {
                    markers[i].setVisible(false);
                };
            });

            // Show Markers Per Category (helper)
            $this.on('show', function(event, category) {
                $this.trigger('hide_all');
                $this.trigger('reset');

                // Set bounds
                var bounds = new google.maps.LatLngBounds();
                for (var i = 0; i < options.locations.length; i++) {
                    if (options.locations[i][6] == category) {
                        markers[i].setVisible(true);
                    };

                    // Add markers to bounds
                    bounds.extend(markers[i].position);
                };

                // Auto focus and center
                map.fitBounds(bounds);
            });

            // Hide Markers Per Category (helper)
            $this.on('hide', function(event, category) {
                for (var i = 0; i < options.locations.length; i++) {
                    if (options.locations[i][6] == category) {
                        markers[i].setVisible(false);
                    };
                };
            });

            // Clear Markers (helper)
            $this.on('clear', function() {
                if (markers) {
                    for (var i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                    };
                };
            });

            $this.on('reset', function() {
                map.setCenter(new google.maps.LatLng(options.latitude, options.longitude), options.zoom);
            });

            // Hide all locations once
            //$this.trigger('hide_all');

        });

    };

    $(document).ready(function() {
        $('[data-toggle="mapit"]').mapit();
    });

})(jQuery);


// Run javascript after DOM is initialized
$(document).ready(function() {

    $('#similar_map_wrap').mapit();

});