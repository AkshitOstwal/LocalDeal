// import 'package:map_view/map_view.dart';
// import 'package:flutter/material.dart';

// class LocationInput extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   Uri _staticMapUri ; 
//   @override
//   void initState() {
//     super.initState();
//   }

//   void getStaticMap() {
//     final StaticMapProvider staticMapviewProvider =
//         StaticMapProvider('aAIzaSyDTDdtXLuAoEZHfG3RZ91sfspQUoEuqGsY');
//     final Uri staticMapUri = staticMapviewProvider.getStaticUriWithMarkers(
//         [Marker('position', 'Position', 41.40338, 2.17403)],
//         center: Location(41.40338, 2.17403),
//         width: 500,
//         height: 300,
//         maptype: StaticMapViewType.roadmap);
//         setState(() {
//          _staticMapUri = staticMapUri; 
//         });
//   }

//   void updateLocation() {}

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       TextFormField(),
//       SizedBox(
//         height: 10,
//       ),
//       Image.network(_staticMapUri.toString())
//     ]);
//   }
// }
