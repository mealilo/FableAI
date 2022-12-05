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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const List<String> gpt3Models = <String>[
  "text-davinci-003",
  "text-curie-001",
  "text-babbage-001",
  "text-ada-001"
];

class _HomeState extends State<Home> {
  final myController = TextEditingController();
  late CompletionsResponse? response = null;
  @override
  void initState() {
    super.initState();
  }

  void _getData(str, model) async {
    response = (await CompletionsApi.getStory(str, model));
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  String dropdownValue = gpt3Models.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      response == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(response!.choices![0]["text"].toString())),
      const SizedBox(
        height: 10,
      ),
      DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: gpt3Models.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      const Text(
        'Input Your Story Below:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 4,
          controller: myController,
          decoration: InputDecoration(
            hintText: "Enter your story here",
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _getData(myController.text, dropdownValue);
              },
            ),
          ),
          onSubmitted: (String str) {
            _getData(str, dropdownValue);
          })
    ]));
  }
}
