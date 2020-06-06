import 'package:flutter/material.dart';

void main() {
  var r =AppRoute().route;

  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes:r,
  ));
}

class AppRoute {
  var _route ;

  AppRoute(){
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

  bool checkKey(String k){
    return _route.containsKey(k);
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              padding: EdgeInsets.all(1),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      )
      ,
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
            if(Navigator.canPop(context)){
              //check if name exist
              if(AppRoute().checkKey('/third'))
              {
                Navigator.popAndPushNamed(context, '/third');
              }
              else{
                Navigator.popAndPushNamed(context, '/');
              }
            }
            //Navigator.pushNamed(context, '/third');
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
            //now add check
            if(AppRoute().checkKey('/')){
              Navigator.pushNamedAndRemoveUntil(context, '/' , (route) => false);
            }
          },
          child: Text('Go Home!'),
          fillColor: Colors.amber,
        ),
      ),
    );
  }
}