window.GMap = (function ($, window) {

    var GMap = {};
    GMap.Drives = [];
    GMap.Shops = [];
    GMap.MarkerClusterer = null;
    GMap.Follow = {
        id: 0
    };
    GMap.init = function (mapId) {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 6,
            maxZoom: 40,
            center: { lat: 15.8436595, lng: 108.2820999 }
        });
        GMap.map = map;
    };
    GMap.icon = function (bearing) {

    };
    var infoWindows = [];
    GMap.Markers = {
        markers: [],
        clear: function () {
            for (var i = 0; i < this.markers.length; i++) {
                this.markers[i].marker.setMap(null);
            }
            this.markers = [];
        },
        add: function (key, lat, lng, title, content, _linkicon) {
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(lat, lng),
                title: title,
                map: GMap.map,
                maxZoom: 18,
                //icon: '../Images/ic-point-co1.png'
                icon: _linkicon
            });
            var winInfo = new google.maps.InfoWindow({
                content: content
            });

            var obj = new Object();
            obj.marker = marker;
            obj.key = key;
            obj.InfoWindow = winInfo;
            this.markers.push(obj);
            infoWindows.push(winInfo);
            //GMap.map.setZoom(15);

            google.maps.event.addListener(marker, 'click', function () {
                closeAllInfoWindows();
                winInfo.open(GMap.map, marker);
                //GMap.map.panTo(marker.getPosition());
                //GMap.map.setZoom(15);
            });
        },
        //panTo: function (key) {
        //    for (var i = 0; i < this.markers.length; i++) {
        //        var item = this.markers[i];
        //        if (item.key == key) {
        //            item.marker.setMap(GMap.map);
        //            item.InfoWindow.open(GMap.map, item.marker);
        //            GMap.map.panTo(item.marker.getPosition());
        //            GMap.map.setZoom(15);
        //        }
        //        else {
        //            item.InfoWindow.close();
        //        }
        //    }
        //},
        hide: function () {
            for (var i = 0; i < this.markers.length; i++) {
                var item = this.markers[i];
                item.marker.setMap(null);
            }
        },
        show: function () {
            for (var i = 0; i < this.markers.length; i++) {
                var item = this.markers[i];
                item.marker.setMap(GMap.map);
            }
        }
    };
    function closeAllInfoWindows() {
        for (var i = 0; i < infoWindows.length; i++) {
            infoWindows[i].close();
        }
    }
    GMap.loadClusterer = function () {
        var options = {
            imagePath: '/images/m'
        };

        GMap.MarkerClusterer = new MarkerClusterer(GMap.map, GMap.Shops, options);
    }
    GMap.addShop = function (shop) {
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(shop.LocationLatitude, shop.LocationLongitude),
            //map: GMap.map,
            // icon: GMap.icon(location.Bearing),
            data: shop,
            icon: shop.icon
        });
        marker.addListener('click', function () {
            var marker = this;
            var infowindow = new google.maps.InfoWindow({
                content: "<div id=\"content\">" +
                    '<div id="siteNotice">' +
                    '</div>' +
                    '<h5 id="firstHeading" class="firstHeading">' + marker.data.ShopName + '</h5>' +
                    '<div id="bodyContent">' +
                    '<p>' +
                    '<b>ShopId: </b>' + marker.data.ShopId + '<br/>' +
                    '<b>Address: </b>' + marker.data.ShopAddress + '<br/>' +
                    '</p>' +
                    "<button type=\"button\" class=\"btn btn-default\" data-toggle=\"modal\" data-target=\"#modal-xl\" onclick=\"return view_report('" + marker.data.ShopId + "')\" > Xem chi tiết </button>" +
                    //"<button onclick=\"return view_report('" + marker.data.ShopId + "')\">Xem chi tiết</button>" +
                    //'<button onclick="return view_report(' + marker.data.ShopId + ')">Xem chi tiết</button>' +
                    '</div>' +
                    '</div>'
            });
            infowindow.open(GMap.map, marker);
        });
        GMap.Shops.push(marker);
    };
    GMap.clearShops = function () {
        if (GMap.MarkerClusterer) {
            GMap.MarkerClusterer.clearMarkers();
        }
        GMap.Shops = [];
    };
    //GMap.loadShops = function () {
    //    $.ajax({
    //        url: "/api/digitalmap.ashx",
    //        type: "POST",
    //        success: function (data) {
    //            GMap.clearShops();
    //            if (data && data.length && data.length > 0) {
    //                for (var i = 0; i < data.length; i++) {
    //                    GMap.addShop(data[i])
    //                }
    //            }
    //            GMap.loadClusterer();
    //        },
    //        error: function () {

    //        }
    //    });
    //}
    //GMap.loadShops();
    return GMap;
})(jQuery, window);