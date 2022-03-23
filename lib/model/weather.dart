import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Weather {
  final int? maxTemperature;
  final int? minTemperature;
  final int? currentTemperature;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidity;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;

  Weather(
      {this.maxTemperature,
      this.minTemperature,
      this.name,
      this.day,
      this.wind,
      this.humidity,
      this.chanceRain,
      this.image,
      this.currentTemperature,
      this.time,
      this.location});
}

String apiKey = '06564f04d07ba244c2dbe775dfa5d3b4';
Future<List> fetchData(String lat, String log, String city) async {
  Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$log&units=metric&appid=$apiKey');
  final response = await http.get(url);
  final date = DateTime.now();
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    //current Temp
    final current = responseData['current'];
    Weather currentWeather = Weather(
      currentTemperature: current['temp']?.round() ?? 0,
      name: current['weather'][0]['main'],
      day: DateFormat('EEEE dd MMMM').format(date),
      wind: current['wind_speed']?.round() ?? 0,
      humidity: current['humidity']?.round() ?? 0,
      chanceRain: current['uvi']?.round() ?? 0,
      location: city,
      image: findIcon(current['weather'][0]['main'].toString(), true),
    );

    //today Temp
    final today = responseData['hourly'];
    List<Weather> todayWeather = [];
    final hour = date.hour;

    for (int i = hour + 1; i <= hour + 4; i++) {
      final hourWeather = Weather(
        currentTemperature: today[i]['temp']?.round() ?? 0,
        image: findIcon(today[i]['weather'][0]['main'].toString(), false),
        time: Duration(hours: i).toString().split(':')[0] + ':00',
      );
      todayWeather.add(hourWeather);
    }

    // tomorrow
    final tomorrow = responseData['daily'][0];
    final tomorrowWeather = Weather(
      maxTemperature: tomorrow['temp']['max']?.round() ?? 0,
      minTemperature: tomorrow['temp']['min']?.round() ?? 0,
      image: findIcon(tomorrow['weather'][0]['main'].toString(), true),
      name: tomorrow['weather'][0]['main'],
      wind: tomorrow['wind_speed']?.round() ?? 0,
      humidity: tomorrow['humidity']?.round() ?? 0,
      chanceRain: tomorrow['uvi']?.round() ?? 0,
    );

    //Seven Days

    final sevenDays = responseData['daily'];
    List<Weather> sevenDaysWeather = [];

    for (int i = 1; i <= 7; i++) {
      final day = DateFormat('EEEE')
          .format(DateTime(date.year, date.month, date.day + i))
          .substring(0, 3);
      final dayWeather = Weather(
        maxTemperature: sevenDays[i]['temp']['max']?.round() ?? 0,
        minTemperature: sevenDays[i]['temp']['min']?.round() ?? 0,
        image: findIcon(sevenDays[i]['weather'][0]['main'].toString(), false),
        day: day,
        name: sevenDays[i]['weather'][0]['main'].toString(),
      );
      sevenDaysWeather.add(dayWeather);
    }
    return [currentWeather, tomorrowWeather, todayWeather, sevenDaysWeather];
  }
  return [null, null, null, null];
}

//find Icon
String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case 'Clouds':
        return 'assets/sunny.png';
      case 'Rain':
        return 'assets/rainy.png';
      case 'Drizzle':
        return 'assets/rainy.png';
      case 'Thunderstorm':
        return 'assets/thunder.png';
      case 'Snow':
        return 'assets/snow.png';
      default:
        return 'assets/sunny.png';
    }
  } else {
    switch (name) {
      case 'Clouds':
        return 'assets/sunny_2d.png';
      case 'Rain':
        return 'assets/rainy_2d.png';
      case 'Drizzle':
        return 'assets/rainy_2d.png';
      case 'Thunderstorm':
        return 'assets/thunder_2d.png';
      case 'Snow':
        return 'assets/snow_2d.png';
      default:
        return 'assets/sunny_2d.png';
    }
  }
}
