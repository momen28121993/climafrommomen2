import 'package:flutter/material.dart';
import 'package:climafrommomen/utilities/constants.dart';
import 'package:climafrommomen/services/weather.dart';
import 'package:climafrommomen/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {

  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();

}


class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather =WeatherModel();

  late double temperature;
  late int temp;
  late String weatherIcon ;
  late String cityname ;
  late int condition;
  late String message;

  @override
  void initState() {

    super.initState();
  update(widget.locationWeather);



  }
  void update (dynamic locationWeather){
    setState((){
     temperature =  locationWeather['main']['temp'];
  condition = locationWeather['weather'][0]['id'];
 cityname =locationWeather['name'];

  temp = temperature.toInt();
  weatherIcon = weather.getWeatherIcon(condition);
  message = weather.getMessage(temp);

  });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async{

                          var nearweather = await weather.getlocationweather();
                           update(nearweather);

                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        var typedname = await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();


                        }
                        )
                        );
                        if (typedname != null){
                         var cityweather = await weather.getCityWeather(typedname);
                          update(cityweather);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temp',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    '$message in $cityname',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
