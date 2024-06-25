import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final int? max;
  final int? min;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidtiy;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;
  Weather({this.max, this.min, this.current, this.name, this.day, this.wind, this.humidtiy, this.chanceRain, this.image, this.time, this.location});
}

String apId = '78d153b81299a5d35bc4bfb05c6c7022';

Future<List?> fetchData(String lat, String lon, String city) async {
  var url = 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&&units=metric&appid=$apId';
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var current = res['current'];
    Weather currentTemp = Weather(
        current: current['temp'].round(),
        name: current['weather'][0]['main'],
        day: DateFormat('EEEE dd MMMM').format(date),
        wind: current['wind_speed'].round(),
        humidtiy: current['humidtiy'].round(),
        chanceRain: current['uvi'].round(),
        location: city,
        image: findIcon(current['weather'][0]['main'].toString()));

    //today weather
    List<Weather> todayweather = [];
    int hour = int.parse(DateFormat('hh').format(date));
    for (var i = 0; i < 4; i++) {
      var temp = res['hourly'];
      Weather hourly = Weather(current: temp[i]['temp'].round(), image: findIcon(temp[i]['weather'][0]['main'].toString()), time: '${Duration(hours: hour + i + 1).toString().split(':')[0]}:00');
      todayweather.add(hourly);
    }
    //Tomorrow weather
    var daily = res['daily'][0];
    Weather tomorrowTemp = Weather(
      max: daily['temp']['max'].round(),
      min: daily['temp']['min'].round(),
      image: findIcon(daily['weather'][0]['main'].toString()),
      name: daily['weather'][0]['main'],
      wind: daily['wind_speed'].round(),
      humidtiy: daily['humidtiy'].round(),
      chanceRain: daily['uvi'].round(),
    );

    List<Weather> sevenDays = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat('EEEE').format(DateTime(date.year, date.month, date.day + i + 1)).substring(0, 3);
      var temp = res['daily'][i];
      Weather hourly = Weather(max: temp['temp']['max'].round(), min: temp['temp']['min'].round(), image: findIcon(temp['weather'][0]['main'].toString()), name: temp['weather'][0]['main'], day: day);
      sevenDays.add(hourly);
    }
    return [currentTemp, todayweather, tomorrowTemp, sevenDays];
  }
}

String? findIcon(String name) {
  switch (name) {
    case "Clouds":
      return 'assets/sunny.png';
      break;
    case "Rain":
      return 'assets/rainy.png';
      break;
    case "Drizzle":
      return 'assets/rainy.png';
      break;
    case "Thunderstorm":
      return 'assets/thunder.png';
      break;
    case "Snow":
      return 'assets/snow.png';
      break;
    default:
      return 'assets/sunny.png';
      break;
  }
}

class CityModel {
  final String? name;
  final String? lat;
  final String? lon;
  CityModel({this.name, this.lat, this.lon});
}

var citJson;
Future<CityModel?> fetchCity(String city) async {
  if (citJson == null) {
    String link = 'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json';
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
    }
  }
  for (var i = 0; i < citJson.length; i++) {
    if (citJson[i]['name'].toString().toLowerCase() == city.toLowerCase()) {
      return CityModel(
        name: citJson[i]['name'].toString(),
        lat: citJson[i]['latitude'].toString(),
        lon: citJson[i]['longitude'].toString(),
      );
    }
  }
  return null;
}
