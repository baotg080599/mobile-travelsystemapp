import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:room_finder_flutter/models/nearby_response.dart';

class NearbyPlacesComponent extends StatefulWidget {
  final double latitude;
  final double longitude;
  const NearbyPlacesComponent(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<NearbyPlacesComponent> createState() => _NearbyPlacesComponentState();
}

class _NearbyPlacesComponentState extends State<NearbyPlacesComponent> {
  String apiKey = 'AIzaSyCqLJDrUf7Nk3PG5EJ22LqiZMY01EN4tDs';
  String radius = '30';
  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  @override
  void initState() {
    super.initState();
    getNearbyPlaces();
  }

  void getNearbyPlaces() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            widget.latitude.toString() +
            ',' +
            widget.longitude.toString() +
            '&radius=' +
            radius +
            '&key=' +
            apiKey);

    var response = await http.post(url);
    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
    setState(() {});
    print('Tọa độ: ${widget.latitude}, ${widget.longitude}');
    print('Status:  ${response.statusCode}');
    print('Response body: ${response.body}');
    print('So luong dia diem: ${nearbyPlacesResponse.results}');
  }

  Widget NearbyPlaceWidget(Results results) {
    return (Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text('Name: ' + results.name!),
        Text('Location: ' +
            results.geometry!.location!.lat.toString() +
            ' , ' +
            results.geometry!.location!.lng.toString()),
        Text(results.openingHours != null ? 'Open' : 'Closed')
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: nearbyPlacesResponse.results?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          // return NearbyPlaceWidget(nearbyPlacesResponse.results![index]);
          return (Text('Có data'));
        },
      ),
    );
    // Column(
    //   children: [
    //     if (nearbyPlacesResponse.results != null)
    //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
    //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
    //   ],
    // );
  }
}
