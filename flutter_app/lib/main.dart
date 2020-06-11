import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//https://script.google.com/macros/s/AKfycbyDfZxKNhhKaxApoK9sM9wDafEf0xu70z_0Pda5bZz-5Nr_iCzf/exec
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var _myroute = MyRouteSetting().route;
    //這個function將輸出內容
    //context將會有一些app的基本資訊
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
//      onGenerateRoute: (settings) {
//        print("~~~~~~~~~~~~~~~~~~~~~~");
//        print(settings.name);
//        if (settings.name == "/second") {
//          return PageRouteBuilder(
//            pageBuilder: (_, __, ___) => FirstScreen(),
//            transitionsBuilder: (_, anim, __, child) {
//              return SlideTransition( position: Tween<Offset>(
//                begin: const Offset(1, 0), //way fade in out
//                end: Offset.zero,
//              ).animate(anim) , child: child);
//            },
//          );
//        }
//        // unknown route
//        return MaterialPageRoute(builder: (context) => SecondScreen());
//      },
      routes: _myroute,
    );
    //最後輸出結果要return出去他才知道
    //MaterialApp是整個平化app的最外層
  }

}

class MyRouteSetting{
  var _route;
  MyRouteSetting(){
    _route = {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
      '/third': (context) => ThirdScreen(),
    };
  }

  //setter
  void set route(Map r) {
    _route = r;
  }

  //getter
  Map get route{
    return _route;
  }
//OR Map get route=>this._route;
}

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          InkWell(
            onTap: (){ print('MyDrawer Header Taped!');},
            child: SizedBox(
              height: 80,
              child:DrawerHeader(
                child: Center(
                  child: Text('Drawer Header'),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                //padding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          ListTile(
            title: Text('Item second 2'),
            onTap: () {
              // Update the state of the app
              // ...
              //Navigator.of(context).pushNamedAndRemoveUntil('/second',(Route<dynamic> route) => false);
              Navigator.pushNamedAndRemoveUntil(context, '/second', (route) => false);

              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item third 3'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushAndRemoveUntil(context, SlideRightRoute(page: ThirdScreen()) , (route) => false);
            },
          ),
        ],
      ),
    );
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
            //Navigator.pushNamed(context, '/second');
            //go to second
            Navigator.popAndPushNamed(context, '/second');
          },
        ),
      ),
      drawer: MyDrawer(),
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
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red[200],width: 1),
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0) //         <--- border radius here
              )
          ),
          child: RaisedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.

              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
              else{
                //Navigator.popAndPushNamed(context, '/third');
                //Navigator.push(context, SlideRightRoute(page: ThirdScreen()));
                Navigator.pushReplacement(context, SlideRightRoute(page: ThirdScreen()));
              }

            },
            child: Text('Go third!'),
            color: Colors.white,
          ),
          width: 200,
        ),
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.yellow,
    );
  }
}


class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ThirdScreen Screen"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red[200],width: 1),
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0) //         <--- border radius here
              )
          ),
          child: RaisedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              //back to /
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
              else{
                Navigator.popAndPushNamed(context, '/');
              }
            },
            child: Text('Go Home!'),
            color: Colors.white,
          ),
          width: 200,
        ),
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1 , 0), //way fade in out;(1,0) r->l ;(1,1) rd->lt;(1,-1) rt->ld;(0, 0) fadein;(0,-1) t->d;(0,1) d->t;(-1,1) ld->rt;(-1, 0) l->r;(-1, -1) lt->rd;use factor;
            end: Offset.zero,
          ).animate(animation),
          child: child,

        ),
  );
}