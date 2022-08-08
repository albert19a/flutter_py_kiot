import 'package:flutter/material.dart';
import 'package:chaquopy/chaquopy.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter py KIOT',
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
      ),
      home: const MyHomePage(title: 'Flutter py KIOT Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String pyCommand  = '';

  String horriblePythonCodeFormatter() {
    // DRSE Hackathon credentials
    String importKIOTClient = "from kiot.client.vimar_kiot_client import VimarKiotClient";
    String importKIOTEndpoints = "from kiot.endpoints.kiot_authentication import KiotAuthentication, KiotAuthenticationType";
    String tok = "AUTH_TOKEN = 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJuR0lIV085Z1VoMVVJeWs4eHA2ZE5sNGUtTnRuZVBBdnRKRnhKaUtRRGFZIn0.eyJleHAiOjE2NjU5MzIyOTcsImlhdCI6MTY1OTQ1MjI5NywiYXV0aF90aW1lIjoxNjU5NDQ5ODYyLCJqdGkiOiI5ZmNkMmIzYS02NTQxLTRiY2UtOGRiZC1kOWI3MTYwMGIxYzYiLCJpc3MiOiJodHRwczovL3ByZXByb2QzLnZpbWFyLmNsb3VkL2F1dGgvcmVhbG1zL3ZpbWFydXNlciIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI0NDhjNWY1OC00Y2UzLTRmMjItOTE4Yy1iNGRiNjQ5ZDg0NGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJoYWNrYXRob25fY2xpZW50X2Jhc2ljIiwic2Vzc2lvbl9zdGF0ZSI6ImJmNjJmOWYwLWNhNDUtNGNmNC1iYWViLWQ1NGQxNjBlMGNhYyIsImFjciI6IjAiLCJhbGxvd2VkLW9yaWdpbnMiOlsiaHR0cHM6Ly9wcmVwcm9kMy52aW1hci5jbG91ZC8iLCJodHRwOi8vaG9zbWFydGFpMS5wcmVwcm9kMy52aW1hci5jbG91ZC5pbnRlcm5hbDo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6ImtueF9jb25zdW1wdGlvbl9jb250cm9sIGtueF9zaHV0dGVyX2NvbnRyb2wga254X3NjZW5lX3BlcnNvbmFsaXplIGtueF9sb2FkX2NvbnRyb2wga254X2FjY2Vzc19jb250cm9sIHdyaXRlIGtueF9zZW5zb3JfY29udHJvbCBrbnhfZW5lcmd5X3BlcnNvbmFsaXplIGtueF9jbGltYXRlX2NvbnRyb2wgbWFuYWdlIGtueF9zY2VuZV9jb250cm9sIG9mZmxpbmVfYWNjZXNzIGtueF9hY3R1YXRvcl9jb250cm9sIGtueF9saWdodF9jb250cm9sIGtueF9jbGltYXRlX3BlcnNvbmFsaXplIHJlYWQifQ.OtRKRqHdoVgGtPqwESHIaYQ5jtyyxtSx9GfT1Qw_1gtKJdddEd9ymqyhS1WGgtH2fQEgRvLVCcBvzr2H6YM9UEejItwKDKFGdrljojZYAcGJR6n7rJ-6NCNDGnKUlGrlwzfFZ_6UEVydntTLFMkMuuz2RcGyPMMHM63pYS8iAt2kHnij2bHCgDs55aFoMxHvxgvcHYD73ymT2d-BAm9JAnTPmeCg6YJioyb6uhZEGsmAOoHOzSMrG4NawvMChKPA8rP6vPKKQPqoYjzGk04I-B3SpokhlS1W2TCaoulYV3741n2f3VBpBOjyuytptHJ6y8SSZOX49LymFPqmhB17GQ'";
    String pl = "KNX_PLANT_ID = 'c5759b62-2d20-43b4-93f2-fa7e7475711a'";
    String url = "KNX_URL = 'https://knx-preprod3.vimar.cloud/api/v2'";
    String hndl = "auth_handler = KiotAuthentication(KiotAuthenticationType.BEARER, auth_bearer_token=AUTH_TOKEN)";
    String client = "myClient = VimarKiotClient(auth_handler, KNX_URL, KNX_PLANT_ID)";
    String getsw = "result, lightswitches = myClient.get_available_lightswitches()"; //  # List of VimarSsLightSwitch
    String loopVar = "text = ''";
    String forLoop = "for light in lightswitches:";
    String getNextLight = r"    text = text + '\nLight ' + light.title + ' is ' + light.onoff"; // Get a SFE_State_OnOff
    String myCmd = "$importKIOTClient\n$importKIOTEndpoints\n$tok\n$pl\n$url\n$hndl\n$client\n$getsw\n$loopVar\n$forLoop\n$getNextLight\n";
    return myCmd;
  }
  
  String sampleHorriblePythonCodeFormatter() {
    String sPl = "id = 'c5759b62-2d20-43b4-93f2-fa7e7475711a'";
    String sTxt = "text = 'KNX_PLANT_ID = ' + id";
    String sPrint = "print(text)";
    String myCmd = "$sPl\n$sTxt\n$sPrint\n";
    return myCmd;
  }
  
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    runPythonCode();
  }

  Future runPythonCode() async {
    /*
      Build ERROR: non compila, chiesto aiuto, risponde davidyuk:
      I had the same problem, as a workaround fixed it by changing
        -val code: String = call.arguments()
        +val code: String = call.arguments() ?: ""
      in ChaquopyPlugin.kt
      qui: C:\Portable\flutter\.pub-cache\hosted\pub.dartlang.org\chaquopy-0.0.16\android\src\main\kotlin\com\chaquopy\chaquopy
      devo capire come fixarlo definitivamente
    */
    // to run PythonCode, just use executeCode function, which will return map with following format
    // {
    // "textOutputOrError" : output of the code / error generated while running the code
    // }
    // import sys\nprint(sys.version)
    var textOutputOrError = await Chaquopy.executeCode("print('Hello from Mr. Python!')"); //_controller.text);
    var textOutputOrError1 = await Chaquopy.executeCode("import sys\nprint(sys.version)"); //_controller.text);
    var textOutputOrError2 = await Chaquopy.executeCode(sampleHorriblePythonCodeFormatter()); //_controller.text);
    var textOutputOrError3 = await Chaquopy.executeCode(horriblePythonCodeFormatter()); //_controller.text);

    setState(() {
      debugPrint(textOutputOrError['textOutputOrError'] ?? 'No error');
      debugPrint(textOutputOrError1['textOutputOrError'] ?? 'No error');
      debugPrint(textOutputOrError2['textOutputOrError'] ?? 'No error');
      debugPrint(textOutputOrError3['textOutputOrError'] ?? 'No error');
    });
 }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
