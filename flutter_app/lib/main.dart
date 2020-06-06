import 'package:flutter/material.dart';

void main() {
  var r =Route().route;

  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes:r,
  ));
}

class Route {
  var _route ;

  Route(){
    print("Config init");
    _route = {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
      '/third': (context) => ThirdScreen(),
    };
  }
  //setters
  void set route(Map routeSetting){
    _route = routeSetting;
  }
  //getters
  //Map get route=>this._route;
  Map get route{
    return _route;
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            //Navigator.pop(context);
            Navigator.pushNamed(context, '/third');
          },
          child: Text('Go third!'),
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RawMaterialButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pushNamedAndRemoveUntil(context, '/' , (route) => false);
          },
          child: Text('Go Home!'),
          fillColor: Colors.amber,
        ),
      ),
    );
  }
}