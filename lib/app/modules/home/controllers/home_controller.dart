import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';

import '../model/forecast.dart';
import '../widget/notifications.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<ForecastData> weeklyForecast = [
    ForecastData(
      day: 'Today',
      highTemp: '14°',
      lowTemp: '8°',
      rainChance: '0%',
      windSpeed: '3 MPH',
      status: WeatherStatus.ideal,
    ),
    ForecastData(
      day: 'Mon',
      highTemp: '16°',
      lowTemp: '10°',
      rainChance: '5%',
      windSpeed: '4 MPH',
      status: WeatherStatus.ideal,
    ),
    ForecastData(
      day: 'Tue',
      highTemp: '22°',
      lowTemp: '18°',
      rainChance: '90%',
      windSpeed: '22 MPH',
      status: WeatherStatus.danger,
    ),
    ForecastData(
      day: 'Wed',
      highTemp: '10°',
      lowTemp: '4°',
      rainChance: '45%',
      windSpeed: '12 MPH',
      status: WeatherStatus.alert,
    ),
    ForecastData(
      day: 'Thu',
      highTemp: '12°',
      lowTemp: '6°',
      rainChance: '15%',
      windSpeed: '8 MPH',
      status: WeatherStatus.alert,
    ),
    ForecastData(
      day: 'Fri',
      highTemp: '19°',
      lowTemp: '12°',
      rainChance: '0%',
      windSpeed: '5 MPH',
      status: WeatherStatus.ideal,
    ),
    ForecastData(
      day: 'Sat',
      highTemp: '25°',
      lowTemp: '19°',
      rainChance: '10%',
      windSpeed: '2 MPH',
      status: WeatherStatus.ideal,
    ),
  ];

  final List<Notifications> notifications = [
    Notifications(
      title: 'Weather Alert',
      message: 'Storm forecasted for Wednesday. We\'ve optimized your schedule.',
    ),
    Notifications(
      title: 'Schedule Update',
      message: 'Heatwave expected Friday. High-intensity workouts moved to morning.',
    ),
    Notifications(
      title: 'Clear Skies',
      message: 'Perfect conditions for your Long Ride on Saturday!',
      icon: Icons.wb_sunny,
    ),
  ];

}
