import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:ngo/donate.dart';
import 'package:ngo/find.dart';
import 'package:ngo/home.dart';
import 'package:ngo/ourwork.dart';
import 'package:ngo/volunteer.dart';

final router = Router();
var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Home();
});
var donatesHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DonatetoUs();
});
var ourworkHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Ourwork();
});
var findHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Findlocation();
});
var volunteerHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Volunteer();
});
void defineRoutes(Router router) {
  router.define('/', handler: homeHandler);
  router.define("/donate", handler: donatesHandler);
  router.define("/ourwork", handler: ourworkHandler);
  router.define("/findus", handler: findHandler);
  router.define("/volunteer", handler: volunteerHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
}

void main() {
  GoogleMap.init('AIzaSyD9JSxLpMD_AqpHMDpbWcZ8171_OZpQ2Cs');
  WidgetsFlutterBinding.ensureInitialized();
  defineRoutes(router);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      // routes: {
      //   '/': (context) => Home(),
      //   '/phonehome': (context) => Phonehome(),
      //   '/homedesktop': (context) => Homedesktop(),
      //   '/Tabhome': (context) => Tabdesktop(),
      //   '/ourwork': (context) => Ourwork(),
      //   '/donatetoUs': (context) => DonatetoUs(),
      //   '/desktopdonate': (context) => Donate(),
      //   '/tabdonate': (context) => Tabdonate(),
      //   '/findlocation': (context) => Findlocation(),
      // },
      onGenerateRoute: router.generator,
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/phonehome':
      //       return MaterialPageRoute(
      //           builder: (_) => Phonehome(), settings: settings);
      //       break;
      //     case '/homedesktop':
      //       return MaterialPageRoute(
      //           builder: (_) => Homedesktop(), settings: settings);
      //       break;
      //     case '/ourwork':
      //       return MaterialPageRoute(
      //           builder: (_) => Ourwork(), settings: settings);
      //       break;
      //     case '/Tabhome':
      //       return MaterialPageRoute(
      //           builder: (_) => Tabdesktop(), settings: settings);
      //       break;
      //     case '/donatetoUs':
      //       return MaterialPageRoute(
      //           builder: (_) => DonatetoUs(), settings: settings);
      //       break;
      //     case '/desktopdonate':
      //       return MaterialPageRoute(
      //           builder: (_) => Donate(), settings: settings);
      //       break;
      //     case '/findlocation':
      //       return MaterialPageRoute(
      //           builder: (_) => Findlocation(), settings: settings);
      //       break;
      //     case '/tabdonate':
      //       return MaterialPageRoute(
      //           builder: (_) => Tabdonate(), settings: settings);
      //       break;
      //     default:
      //       return MaterialPageRoute(
      //           builder: (_) => Home(), settings: settings);
      //       break;
      //   }
      // },
      title: 'NCGI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class Homeselect extends StatefulWidget {
  @override
  _HomeselectState createState() => _HomeselectState();
}

class _HomeselectState extends State<Homeselect> {
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 1200) {
        return MyApp();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return InteractiveViewer(child: MyApp());
      } else {
        return InteractiveViewer(child: MyAppphone());
      }
    });
  }
}

class MyAppphone extends StatelessWidget {
  // This widget is the root of your application.
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/Home',
      routes: {
        '/Home': (context) => Home(),
        '/phonehome': (context) => Phonehome(),
        '/homedesktop': (context) => Homedesktop(),
        '/Tabhome': (context) => Tabdesktop(),
        '/ourwork': (context) => Ourwork(),
        '/donatetoUs': (context) => DonatetoUs(),
        '/desktopdonate': (context) => Donate(),
        '/tabdonate': (context) => Tabdonate(),
        '/findlocation': (context) => Findlocation(),
      },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/phonehome':
      //       return MaterialPageRoute(
      //           builder: (_) => Phonehome(), settings: settings);
      //       break;
      //     case '/homedesktop':
      //       return MaterialPageRoute(
      //           builder: (_) => Homedesktop(), settings: settings);
      //       break;
      //     case '/ourwork':
      //       return MaterialPageRoute(
      //           builder: (_) => Ourwork(), settings: settings);
      //       break;
      //     case '/Tabhome':
      //       return MaterialPageRoute(
      //           builder: (_) => Tabdesktop(), settings: settings);
      //       break;
      //     case '/donatetoUs':
      //       return MaterialPageRoute(
      //           builder: (_) => DonatetoUs(), settings: settings);
      //       break;
      //     case '/desktopdonate':
      //       return MaterialPageRoute(
      //           builder: (_) => Donate(), settings: settings);
      //       break;
      //     case '/findlocation':
      //       return MaterialPageRoute(
      //           builder: (_) => Findlocation(), settings: settings);
      //       break;
      //     case '/tabdonate':
      //       return MaterialPageRoute(
      //           builder: (_) => Tabdonate(), settings: settings);
      //       break;
      //     default:
      //       return MaterialPageRoute(
      //           builder: (_) => Home(), settings: settings);
      //       break;
      //   }
      // },
      title: 'NCGI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
