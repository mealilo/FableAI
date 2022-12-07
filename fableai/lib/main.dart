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
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 195, 195, 195),
            foregroundColor: Colors.black,
            centerTitle: true,
            title: const Text(
              'FableAI',
              style: TextStyle(fontSize: 40),
            ),
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
    setState(() {});
    response = (await CompletionsApi.getStory(str, model));
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  String dropdownValue = gpt3Models.first;
  String? submissionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundPainter(),
      child: Column(children: [
        Row(children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                'Choose your AI model:',
                textAlign: TextAlign.right,
              ),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Color.fromARGB(255, 72, 95, 105)),
            underline: Container(
              height: 2,
              color: Colors.blueGrey,
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
        ]),
        const Text(
          'Input Your Story Below:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: ((MediaQuery.of(context).size.width) * 0.1)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            minLines: 1,
            controller: myController,
            decoration: InputDecoration(
              hintText: "Enter your story here",
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  submissionText = myController.text;
                  _getData(submissionText, dropdownValue);
                },
              ),
            ),
          ),
        ),
        submissionText == null
            ? const SizedBox(
                height: 0,
              )
            : response == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal:
                              ((MediaQuery.of(context).size.width) * 0.1)),
                      child: Text(
                        response!.choices![0]["text"].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
      ]),
    ));
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color.fromARGB(255, 255, 255, 255);
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.2);
    // paint a curve to the middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);
    // paint a curve to the bottom of screen
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    // draw remaining
    ovalPath.lineTo(0, height);
    // close line
    ovalPath.close();

    paint.color = Colors.grey.shade300;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
