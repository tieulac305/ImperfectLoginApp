import 'package:flutter/material.dart';
import 'routes/home_page.dart';

class RouteGenerator {
  // liệt kê
  static const String homePage = "/";
  static const String welcomePage = "/welcome";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        throw const RouteException("Route not found");
    }
  }
}

class RouteException implements Exception{
  final String message;
  const RouteException(this.message);
}