import 'package:flutter/material.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'dart:js' as js;

class DonatetoUs extends StatefulWidget {
  @override
  _DonatetoUsState createState() => _DonatetoUsState();
}

class _DonatetoUsState extends State<DonatetoUs> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 1200) {
        return Donate();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return InteractiveViewer(child: Tabdonate());
      } else {
        return InteractiveViewer(child: Donatephone());
      }
    });
  }
}

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  ScrollController _controllers;
  bool monthly = false;
  bool paymenttype = false;
  var button;
  var other = "\u{20A6}" + ' Other';
  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.8);
    });
  }

  @override
  void initState() {
    _controllers = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: new AssetImage("assets/images/give.jpg"),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              controller: _controllers,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        margin: const EdgeInsets.only(left: 80, right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              margin: const EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Builder(builder: (context) {
                                  return Center(
                                    child: Image.asset(
                                      "assets/images/logo.jpg",
                                      alignment: Alignment.topCenter,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      // fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 4,
                              //alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(top: 90),
                              child: Text(
                                "HELP END HUNGER TODAY",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 100),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(50)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 30),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 2.5,
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text("Every Naira(" +
                                  "\u{20A6}" +
                                  ") you give can provide at least 10 meals to People in need through the NCGI network of food banks."),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Text("Donation Amount",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  Text("(required)",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = false;
                                        });
                                      },
                                      child: Text("One-Time")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = true;
                                        });
                                      },
                                      child: Text("Monthly"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Giving monthly will go a long way in achieve this purpose",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic)),
                            Column(
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "1"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = '1';
                                            });
                                          },
                                          child: Text("\u{20A6}" + "1,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "2"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "2";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "2,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "3"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "3";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "5,000")),
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "4"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "4";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "10,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "5"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "5";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "100,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "6"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "6";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "500,000")),
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        other = "other";
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixText: "\u{20A6}",
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.teal)),
                                        fillColor: Colors.white,
                                        hintText: other),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Payment Type",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = false;
                                        });
                                      },
                                      child: Text("Credit Card")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = true;
                                        });
                                      },
                                      child: Text("Paypal"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Billing Information",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            !paymenttype
                                ? Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("First Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "FirstName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Last Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  //prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "LastName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Address"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("City:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "City"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Email Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Email"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Credit Card Number:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Credit Card"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("CVV:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "CVV"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: FlatButton(
                                    color: Colors.red[900],
                                    onPressed: () {},
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "FIND OUT MORE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "connect with us today",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      js.context.callMethod(
                                                          "open", [
                                                        "https://www.instagram.com/ncgi_19"
                                                      ]);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/instagram.png",
                                                      height: 70,
                                                      width: 60,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      js.context.callMethod(
                                                          "open", [
                                                        " http://twitter.com/ncgi_19"
                                                      ]);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/twitter.jpg",
                                                      height: 70,
                                                      width: 60,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      js.context.callMethod(
                                                          "open", [
                                                        "https://fb.me/NewchanceNCGI"
                                                      ]);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/facebook.png",
                                                      height: 70,
                                                      width: 60,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Column(
                                          children: [
                                            Text(
                                              "OUR COMMUNITY PARTNERS",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              child: Text(
                                                "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Image.asset(
                                              "assets/images/partner.jpg",
                                              alignment: Alignment.centerLeft,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  9,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "CONTACT INFO",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Address: Plot A26 Sparkling Estate\nOpic BusStop\nIsheri Berger.Lagos State",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Email: anewchanceinlife@gmail.com",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Phone Contact: \n0023408145274419\n0023408136036102\n0023408069375979\n00353892450699\n+447459277208\n00353899434508",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                              Text(
                                "@NCGI 2020",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        FlutterWebScroller(
          //Pass a reference to the ScrollCallBack function into the scrollbar
          scrollCallBack,

          //Add optional values
          scrollBarBackgroundColor: Colors.white,
          scrollBarWidth: 40.0,

          dragHandleColor: Colors.grey,
          dragHandleBorderRadius: 2.0,
          dragHandleHeight: 80.0,
          dragHandleWidth: 15.0,
        ),
      ],
    );
  }
}

class Donatephone extends StatefulWidget {
  @override
  _DonatephoneState createState() => _DonatephoneState();
}

class _DonatephoneState extends State<Donatephone> {
  bool monthly = false;
  bool paymenttype = false;
  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada = Matrix4.identity();
  var button;
  var other = "\u{20A6}" + ' Other';
  double _scale = 1.0;
  double _previousscale = 1.0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
              if (_scale > 1 || _scale == 1) {
                _previousscale = _scale;
                setState(() {});
              }
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              if (_scale > 1 || _scale == 1) {
                _scale = _previousscale * details.scale;
                setState(() {});
              }
              if (details.scale < _scale) {
                _scale = 1.0;
                setState(() {});
              }
            },
            onScaleEnd: (ScaleEndDetails details) {
              if (_scale > 1 || _scale == 1) {
                _previousscale = 1.0;
                setState(() {});
              }
            },
            child: Transform(
              transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
              alignment: FractionalOffset.center,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        //margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              //margin: const EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Builder(builder: (context) {
                                  return Center(
                                    child: Image.asset(
                                      "assets/images/logo.jpg",

                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      // fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 4,
                              //alignment: Alignment.bottomCenter,
                              padding:
                                  const EdgeInsets.only(top: 90, right: 10),
                              child: Text(
                                "HELP END HUNGER TODAY",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 2),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(50)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 7),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 2.5,
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text("Every Naira(" +
                                  "\u{20A6}" +
                                  ") you give can provide at least 10 meals to People in need through the NCGI network of food banks."),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Text("Donation Amount",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  Text("(required)",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = false;
                                        });
                                      },
                                      child: Text("One-Time")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = true;
                                        });
                                      },
                                      child: Text("Monthly"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Giving monthly will go a long way in achieve this purpose",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic)),
                            Column(
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "1"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = '1';
                                            });
                                          },
                                          child: Text("\u{20A6}" + "1,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "2"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = "2";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "2,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "3"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = "3";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "5,000")),
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "4"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = "4";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "10,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "5"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = "5";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "100,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "6"
                                              ? Colors.grey[400]
                                              : Colors.red[900],
                                          onPressed: () {
                                            setState(() {
                                              button = "6";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "500,000")),
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        other = "other";
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixText: "\u{20A6}",
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.teal)),
                                        fillColor: Colors.white,
                                        hintText: other),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 1.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Payment Type",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = false;
                                        });
                                      },
                                      child: Text("Credit Card")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = true;
                                        });
                                      },
                                      child: Text("Paypal"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 1.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Billing Information",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            !paymenttype
                                ? Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("First Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "FirstName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Last Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  //prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "LastName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Address"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("City:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "City"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Email Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Email"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Credit Card Number:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Credit Card"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("CVV:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "CVV"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: FlatButton(
                                    color: Colors.red[900],
                                    onPressed: () {},
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Text(
                                            "FIND OUT MORE",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "connect with us today",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      "https://www.instagram.com/ncgi_19"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/instagram.png",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      " http://twitter.com/ncgi_19"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/twitter.jpg",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      "https://fb.me/NewchanceNCGI"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/facebook.png",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "OUR COMMUNITY PARTNERS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Text(
                                              "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Image.asset(
                                            "assets/images/partner.jpg",
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Text(
                                            "CONTACT INFO",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Address: \nPlot A26 Sparkling Estate\nOpic BusStop\nIsheri Berger.Lagos State",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Email: anewchanceinlife@gmail.com",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Phone Contact: \n0023408145274419\n0023408136036102\n0023408069375979\n00353892450699\n+447459277208\n00353899434508",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Text(
                                "@NCGI 2020",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tabdonate extends StatefulWidget {
  @override
  _TabdonateState createState() => _TabdonateState();
}

class _TabdonateState extends State<Tabdonate> {
  bool monthly = false;
  bool paymenttype = false;
  var button;
  ScrollController _controllers;
  var other = "\u{20A6}" + ' Other';
  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.8);
    });
  }

  void initState() {
    _controllers = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: new AssetImage("assets/images/give.jpg"),
            fit: BoxFit.fill,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              controller: _controllers,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              margin: const EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Builder(builder: (context) {
                                  return Center(
                                    child: Image.asset(
                                      "assets/images/logo.jpg",
                                      alignment: Alignment.topCenter,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      // fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 4,
                              //alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(top: 90),
                              child: Text(
                                "HELP END HUNGER TODAY",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 30),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(50)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 30),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height * 2.5,
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text("Every Naira(" +
                                  "\u{20A6}" +
                                  ") you give can provide at least 10 meals to People in need through the NCGI network of food banks."),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Text("Donation Amount",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  Text("(required)",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = false;
                                        });
                                      },
                                      child: Text("One-Time")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: monthly
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          monthly = true;
                                        });
                                      },
                                      child: Text("Monthly"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Giving monthly will go a long way in achieve this purpose",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic)),
                            Column(
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "1"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = '1';
                                            });
                                          },
                                          child: Text("\u{20A6}" + "1,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "2"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "2";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "2,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "3"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "3";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "5,000")),
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          color: button != "4"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "4";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "10,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "5"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "5";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "100,000")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FlatButton(
                                          color: button != "6"
                                              ? Colors.grey[400]
                                              : Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              button = "6";
                                            });
                                          },
                                          child: Text("\u{20A6}" + "500,000")),
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        other = "other";
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixText: "\u{20A6}",
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.teal)),
                                        fillColor: Colors.white,
                                        hintText: other),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Payment Type",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FlatButton(
                                      color: !paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = false;
                                        });
                                      },
                                      child: Text("Credit Card")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                      color: paymenttype
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          paymenttype = true;
                                        });
                                      },
                                      child: Text("Paypal"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Billing Information",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text("(required)",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            !paymenttype
                                ? Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("First Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "FirstName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Last Name:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  //prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "LastName"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Address"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("City:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "City"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Email Address:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Email"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Credit Card Number:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "Credit Card"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("CVV:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  // prefixText: "\u{20A6}",
                                                  border:
                                                      new OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .teal)),
                                                  fillColor: Colors.white,
                                                  hintText: "CVV"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: FlatButton(
                                    color: Colors.red[900],
                                    onPressed: () {},
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Text(
                                            "FIND OUT MORE",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "connect with us today",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      "https://www.instagram.com/ncgi_19"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/instagram.png",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      " http://twitter.com/ncgi_19"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/twitter.jpg",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    js.context.callMethod(
                                                        "open", [
                                                      "https://fb.me/NewchanceNCGI"
                                                    ]);
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/facebook.png",
                                                    height: 30,
                                                    width: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: Column(
                                        children: [
                                          Text(
                                            "OUR COMMUNITY PARTNERS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            child: Text(
                                              "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Image.asset(
                                            "assets/images/partner.jpg",
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      margin: const EdgeInsets.only(
                                          left: 50, right: 50),
                                      child: Column(
                                        children: [
                                          Text(
                                            "CONTACT INFO",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Address: \nPlot A26 Sparkling Estate\nOpic BusStop\nIsheri Berger.Lagos State",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Email: anewchanceinlife@gmail.com",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Phone Contact: \n0023408145274419\n0023408136036102\n0023408069375979\n00353892450699\n+447459277208\n00353899434508",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Text(
                                "@NCGI 2020",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          child: FlutterWebScroller(
            //Pass a reference to the ScrollCallBack function into the scrollbar
            scrollCallBack,

            //Add optional values
            scrollBarBackgroundColor: Colors.white,
            scrollBarWidth: 30.0,

            dragHandleColor: Colors.grey,
            dragHandleBorderRadius: 2.0,
            dragHandleHeight: 80.0,
            dragHandleWidth: 15.0,
          ),
        ),
      ],
    );
  }
}
