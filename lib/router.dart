
import 'package:anitask/Bloc/HomeScreenBloc/bloc/home_bloc.dart';
import 'package:anitask/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRoutes {

  static const String homeScreen = "LoginScreen";


}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {

    case AppRoutes.homeScreen:
      return _buildHomeScreen(settings);
  }

  return _buildHomeScreen(settings);
}


Route<dynamic> _buildHomeScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) => PageBuilder.buildHomeScreen(settings));
}



class PageBuilder {


  static Widget buildHomeScreen(RouteSettings settings) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(GetUserlDetailsEvent()),
      child: const HomeScreen(),
    );
  }



}