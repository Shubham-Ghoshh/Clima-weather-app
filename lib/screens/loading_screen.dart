import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "b673a0339b89b1740154de47c3843589";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    NetworkHelper myNetwork = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=${myLocation.latitude}&lon=${myLocation.longitude}&appid=$apiKey");
    var weatherData = await myNetwork.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitWanderingCubes(
        color: Colors.black38,
        size: 150.0,
      ),
    );
  }
}
