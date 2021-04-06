import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

// cost of coffee- $10
// cost for whipped cream topping- $2
// cost for chocolate topping- $2

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'order coffee',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool checkBoxValue = false;
  bool checkBoxValueb = false;
  int i = 0;
  int _total = 10;
  String top = "";
  String orderr;
  TextEditingController name = TextEditingController();
  bool viewVisible = false;

  void _showOrder() {
    setState(() {
      viewVisible = true;
    });
  }

  void changedata() {
    if (i >= 0) {
      setState(() {
        i += 1;
      });
    } else {
      i = 0;
    }
  }

  void changedatab() {
    if ((i - 1) >= 0) {
      setState(() {
        i = i - 1;
      });
    } else {
      i = 0;
    }
  }

  void _reset() {
    setState(() {
      i = 0;
      checkBoxValue = false;
      checkBoxValueb = false;
      viewVisible = false;
      top = "";
      _total = 10;
    });
  }

  void _topp() {
    if (checkBoxValue == true && checkBoxValueb == true) {
      setState(() {
        top = top + "+Whipped Cream \n+Chocolate \n";
      });
    } else if (checkBoxValue == true) {
      setState(() {
        top = top + "+Chocolate \n";
      });
    } else if (checkBoxValue == true && checkBoxValueb == true) {
      setState(() {
        top = top + "+Whipped Cream \n";
      });
    }

    if (checkBoxValue == true && checkBoxValueb == true) {
      setState(() {
        _total = _total + 4;
      });
    } else if (checkBoxValue == true) {
      setState(() {
        _total = _total + 2;
      });
    } else if (checkBoxValueb == true) {
      setState(() {
        _total = _total + 2;
      });
    }}

  void launcher() async {
    String orderr = "Name: \n" +
        name.text +
        "\n" +
        "Topping: +Whipping Cream " +
        "\n" +
        top +
        "Quantity:" +
        i.toString() +
        "\nTotal:" +
        "\$" +
        _total.toString() +
        " \nThank You";
    launch("mailto:devangi@gmail.com?subject=Hi&body=$orderr");
  }
// @override
  void dispose() {
    name.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("ORDER YOUR COFFEE"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    )),
                Text(
                  " TOPPINGS ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                          value: checkBoxValue,
                          onChanged: (bool value) {
                            print(value);
                            setState(() {
                              checkBoxValue = value;
                            });
                          }),
                      Text(
                        " chocolate ",
                        style:
                        TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(children: [
                    Checkbox(
                        value: checkBoxValueb,
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            checkBoxValueb = value;
                          });
                        }),
                    Text(
                      " Whipped Cream ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ]),
                ),
                Text(
                  " QUANTITY ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: changedatab,
                          icon: Icon(Icons.remove_circle_outlined),
                          iconSize: 50,
                        ),
                        Text("$i"),
                        IconButton(
                          onPressed: changedata,
                          icon: Icon(Icons.add_circle_outlined),
                          iconSize: 50,
                        ),
                      ]),
                ),
                Text(
                  'Order Summary',
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: viewVisible,
                    child: Container(
                        height: 230,
                        width: 200,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: Text("Name: \n" + name.text + "\n" + top +
                              "Quantity:" + i.toString() + "\nTotal:" +
                              "\$" + _total.toString() + " \nThank You",
                              style: TextStyle(
                                  color: Colors.brown, fontSize: 23)),
                        ))),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _topp();
                      _showOrder();
                    },
                    child: Text("order"),
                  ),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text("refresh"),
                          onPressed: () {
                            _reset();
                          },
                        ),
                        ElevatedButton(
                            child: Text("gmail", style: TextStyle(color: Colors.black),),
                            onPressed: () {
                              launcher();
                            }
                        ),
                      ]),
                )
              ],
            ),),
        ));
  }
}