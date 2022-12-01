import 'package:fableai/completions_api.dart';
import 'package:fableai/completions_response.dart';
import 'package:flutter/material.dart';
// file deprecated
//import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FableAI',
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
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            centerTitle: true,
            title: const Text('FableAI'),
          ),
          // Calls the MyTextInput
          body: Home()),
    );
  }
}

// Text input widget (this calls my textinput state)
class MyTextInput extends StatefulWidget {
  const MyTextInput({super.key});
  @override
  MyTextInputState createState() => MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          TextField(
              decoration: InputDecoration(hintText: "Enter your story here"),
              //onChanged is called whenever we add or delete something on Text Field

              onSubmitted: (String str) {
                setState(() {
                  result = str;
                });
              }),
          //displaying input text
          Text(result)
        ])));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<CompletionsResponse>? response = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    response = (await CompletionsApi.getStory()) as List<CompletionsResponse>?;
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter API Call'),
      ),
      body: response == null || response!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: response!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(response![index].id.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
