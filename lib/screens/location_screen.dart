// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'city_screen.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  IconData weatherIcon = FontAwesomeIcons.question;
  String weatherMessage = "Unable to get weather info.";
  String weatherDescription = "Unknown.";
  int imageNumber = 3;
  int weatherId = 0;

  int imageSelector(int condition) {
    if (condition < 300) {
      return 4;
    } else if (condition < 450) {
      return 3;
    } else if (condition < 600) {
      return 10;
    } else if (condition < 650) {
      return 9;
    } else if (condition < 700) {
      return 8;
    } else if (condition < 800) {
      return 7;
    } else if (condition == 800) {
      return 1;
    } else if (condition <= 804) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";
    NetworkHelper myNetwork = NetworkHelper(url);
    return await myNetwork.getData();
  }

  void updateUI(var weatherData) {
    setState(() {
      if (weatherData == null) {
        return;
      }
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt() - 273;
      weatherId = weatherData["weather"][0]["id"];
      WeatherModel weather = WeatherModel();
      weatherIcon = weather.getWeatherIcon(weatherId);
      String cityName = weatherData["name"];
      weatherMessage = weather.getMessage(temperature) + " in " + cityName;
      weatherDescription = weatherData["weather"][0]["main"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/clima$imageNumber.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await widget.locationWeather;
                      updateUI(weatherData);
                      setState(() {
                        imageNumber = imageSelector(weatherId);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 25.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var cityWeatherData = await getCityWeather(typedName);
                        updateUI(cityWeatherData);
                        setState(() {
                          imageNumber = imageSelector(weatherId);
                        });
                      }
                    },
                    child: const Icon(
                      Icons.widgets,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 60),
                  child: Text(
                    weatherDescription,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Spartan MB',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 0, 200),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    FaIcon(
                      weatherIcon,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 65, 25, 20),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
