import 'model/weather.dart';

List<Weather> todayWeather = [
  Weather(currentTemperature: 23, image: "assets/rainy_2d.png", time: "10:00"),
  Weather(
      currentTemperature: 21, image: "assets/thunder_2d.png", time: "11:00"),
  Weather(currentTemperature: 22, image: "assets/rainy_2d.png", time: "12:00"),
  Weather(currentTemperature: 19, image: "assets/snow_2d.png", time: "01:00")
];

Weather currentTemp = Weather(
    currentTemperature: 21,
    image: "assets/thunder.png",
    name: "Thunderstorm",
    day: "Monday, 17 May",
    wind: 13,
    humidity: 24,
    chanceRain: 87,
    location: "Minsk");

Weather tomorrowTemp = Weather(
  maxTemperature: 20,
  minTemperature: 17,
  image: "assets/sunny.png",
  name: "Sunny",
  wind: 9,
  humidity: 31,
  chanceRain: 20,
);

List<Weather> sevenDay = [
  Weather(
      maxTemperature: 20,
      minTemperature: 14,
      image: "assets/rainy_2d.png",
      day: "Mon",
      name: "Rainy"),
  Weather(
      maxTemperature: 22,
      minTemperature: 16,
      image: "assets/thunder_2d.png",
      day: "Tue",
      name: "Thunder"),
  Weather(
      maxTemperature: 19,
      minTemperature: 13,
      image: "assets/rainy_2d.png",
      day: "Wed",
      name: "Rainy"),
  Weather(
      maxTemperature: 18,
      minTemperature: 12,
      image: "assets/snow_2d.png",
      day: "Thu",
      name: "Snow"),
  Weather(
      maxTemperature: 23,
      minTemperature: 19,
      image: "assets/sunny_2d.png",
      day: "Fri",
      name: "Sunny"),
  Weather(
      maxTemperature: 25,
      minTemperature: 17,
      image: "assets/rainy_2d.png",
      day: "Sat",
      name: "Rainy"),
  Weather(
      maxTemperature: 21,
      minTemperature: 18,
      image: "assets/thunder_2d.png",
      day: "Sun",
      name: "Thunder")
];
