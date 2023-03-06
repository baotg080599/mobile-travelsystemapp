import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/location_list_tile.dart';
import 'package:room_finder_flutter/components/nearby_places_component.dart';
import 'package:room_finder_flutter/models/autocomplete_prediction.dart';
import 'package:room_finder_flutter/models/place_auto_complete_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:room_finder_flutter/utils/network.dart';

import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';

class MapFragment extends StatefulWidget {
  const MapFragment({super.key});

  @override
  State<MapFragment> createState() => _MapFragmentState();
}

class _MapFragmentState extends State<MapFragment> {
  List<AutocompletePrediction> placePredictions = [];

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(10.8411276, 106.8098830);
  double lat = 0.0, lon = 0.0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  TextEditingController place = TextEditingController();

  FocusNode placeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    // Move camera to the current location
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLngPosition, 16));
    print('Toa do: ${lat}');
  }

  void placeAutoComplate(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        "/maps/api/place/autocomplete/json",
        {"input": query, "key": "AIzaSyCqLJDrUf7Nk3PG5EJ22LqiZMY01EN4tDs"});
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RFCommonAppComponent(
        scroll: true,
        // title: RFAppName,
        mainWidgetHeight: screenHeight * 0.2,
        subWidgetHeight: screenHeight * 0.1,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text('Tìm Kiếm', style: boldTextStyle(size: 18)),
            // 16.height,
            AppTextField(
              controller: place,
              focus: placeFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Bạn muốn tìm...",
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    Icon(Icons.search, color: rf_primaryColor, size: 16),
              ),
              onChanged: (value) => {placeAutoComplate(value)},
            ),
            16.height,
            AppButton(
              color: rf_primaryColor,
              child: Text('Tìm', style: boldTextStyle(color: white)),
              width: context.width(),
              elevation: 0,
              onTap: () {
                // RFSearchDetailScreen().launch(context);
              },
            ),
            // Container(
            //   height: 200,
            //   child: ListView.builder(
            //       itemCount: placePredictions.length,
            //       itemBuilder: (context, index) => LocationListTile(
            //           location: placePredictions[index].description!,
            //           press: () {})),
            // )
          ],
        ),
        subWidget: Column(
          children: [
            Container(
              width: context.width(),
              height: screenHeight * 0.5,
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 10.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                ),
              ),
            ),
            Text('Discovery'),
            NearbyPlacesComponent(
              latitude: lat,
              longitude: lon,
            ),
          ],
        ),
      ),
    );
  }
}
