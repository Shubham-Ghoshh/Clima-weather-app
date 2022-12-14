import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherModel {
  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FontAwesomeIcons.cloudBolt;
    } else if (condition < 400) {
      return FontAwesomeIcons.cloudRain;
    } else if (condition < 600) {
      return FontAwesomeIcons.umbrella;
    } else if (condition < 700) {
      return FontAwesomeIcons.snowman;
    } else if (condition < 800) {
      return FontAwesomeIcons.wind;
    } else if (condition == 800) {
      return FontAwesomeIcons.sun;
    } else if (condition <= 804) {
      return FontAwesomeIcons.cloud;
    } else {
      return FontAwesomeIcons.ghost;
    }
  }

  String getMessage(int temp) {
    if (temp > 40) {
      return '๐ is shining too bright';
    } else if (temp > 30) {
      return 'Bring your ๐';
    } else if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp > 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
