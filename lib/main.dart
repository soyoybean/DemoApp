import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'entries.dart';
import 'preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

const YOUTUBE_URL = "https://youtube.com";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // youtube api key
  // static String key = "";

  List<String> entryList = [];
  //static String entry = "";
  static var gender;
  static var mood;
  static bool isRecommend;

  // youtube api
  // YoutubeAPI ytApi = YoutubeAPI(key);
  // List<YT_API> ytResult = [];

  // callYoutubeAPI() async {
  //   String query = "wellness";
  //   ytResult = await ytApi.search(query);
  //   print(ytResult);
  //   // ytResult = await ytApi.nextPage();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // callYoutubeAPI();
    populateJournal();
  }

  void populateJournal() async{
    final journal = await preferencesService.getJournal();
    setState(() {
      entryList.add(journal.entry);
      gender = journal.gender;
      mood = journal.mood;
      isRecommend = journal.isRecommend;
    });
  }

  // picks a random number from 0 - 9 for selecting the YouTube video
  int pickRandomIndex() {
    return Random.secure().nextInt(10);
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
        //title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.deepPurple, Colors.purpleAccent]),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/happy.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Soyon Kim',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Entries"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Entries())).whenComplete(populateJournal);
              },
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: new ListView.builder(
          itemCount: entryList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Text(entryList[index]);
          },
        
        //  GestureDetector(
        //    onTap: () => (print("I'm clicked!!")),
        //    child: listItem(pickRandomIndex())
        //  )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          launchURL();
        },
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.red,
      ),

       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void launchURL() async =>
    await canLaunch(YOUTUBE_URL) ? await launch(YOUTUBE_URL) : throw 'Could not launch $YOUTUBE_URL';
  
  // Widget listItem(index) {
  //   return Card(
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 7.0),
  //       padding: EdgeInsets.all(12.0),
  //       child: Row(
  //         children: <Widget>[
  //           Image.network(
  //             ytResult[index].thumbnail['default']['url'],
  //           ),
  //           Padding(padding: EdgeInsets.only(right: 20.0)),
  //           Expanded(
  //               child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                 Text(
  //                   ytResult[index].title,
  //                   softWrap: true,
  //                   style: TextStyle(fontSize: 18.0),
  //                 ),
  //                 Padding(padding: EdgeInsets.only(bottom: 1.5)),
  //                 Text(
  //                   ytResult[index].channelTitle,
  //                   softWrap: true,
  //                 ),
  //                 Padding(padding: EdgeInsets.only(bottom: 3.0)),
  //                 Text(
  //                   ytResult[index].url,
  //                   softWrap: true,
  //                 ),
  //               ]))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}



// Create a class for a new screen to navigate to.
/*class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Screen')),
      body: Center(
        child: Text(
          'This is a new screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}*/
