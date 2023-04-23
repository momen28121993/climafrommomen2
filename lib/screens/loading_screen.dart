
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climafrommomen/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
late var weatherdata ;

  @override
  void initState() {
    super.initState();
    getlocationdata();

  }
   getlocationdata() async{
      weatherdata = await WeatherModel().getlocationweather();
      if(!context.mounted) return ;
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LocationScreen(locationWeather: weatherdata,);}));
  }




  @override
  Widget build(BuildContext context) {

  return const Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,)
        )
      );


  }
}


