import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: json["coord"] == null
            ? Coord.fromJson({})
            : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null
            ? List<Weather>.from([])
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"] ?? "",
        main:json["main"] == null ? Main.fromJson({}): Main.fromJson(json["main"]),
        visibility: json["visibility"] ?? 0,
        wind: json["wind"] == null ? Wind.fromJson({}): Wind.fromJson(json["wind"]),
        clouds:json["clouds"] == null ? Clouds.fromJson({}): Clouds.fromJson(json["clouds"]),
        dt: json["dt"] ?? 0,
        sys: json["sys"] == null ? Sys.fromJson({}):Sys.fromJson(json["sys"]),
        timezone: json["timezone"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        cod: json["cod"] ?? 0,
      );
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"] ?? 0,
      );
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"] ?? 0.0,
        lat: json["lat"] ?? 0.0,
      );
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"] ?? 0.0,
        feelsLike: json["feels_like"].toDouble() ?? 0.0,
        tempMin: json["temp_min"].toDouble() ?? 0.0,
        tempMax: json["temp_max"].toDouble() ?? 0.0,
        pressure: json["pressure"] ?? 0,
        humidity: json["humidity"] ?? 0,
      );
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"] ?? 0,
        id: json["id"] ?? 0,
        country: json["country"] ?? "",
        sunrise: json["sunrise"] ?? 0,
        sunset: json["sunset"] ?? 0,
      );
}
class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? 0,
        main: json["main"] ?? "",
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
      );
}
class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble() ?? 0.0,
        deg: json["deg"] ?? 0,
      );
}
