import 'dart:ui';
import 'dart:js' as js;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:ngo/main.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

bool join = false;

class Ourwork extends StatefulWidget {
  @override
  _OurworkState createState() => _OurworkState();
}

class _OurworkState extends State<Ourwork> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 1200) {
        return Oursworklappy();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return InteractiveViewer(child: Ourworktab());
      } else {
        return InteractiveViewer(child: Ourworkphone());
      }
    });
  }
}

class Oursworklappy extends StatefulWidget {
  @override
  _OursworklappyState createState() => _OursworklappyState();
}

class _OursworklappyState extends State<Oursworklappy> {
  ScrollController _controllers;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    _controllers = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   images.forEach((imageUrl) {
    //     precacheImage(NetworkImage(imageUrl), context);
    //   });
    // });
    super.initState();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.8);
    });
  }

  GlobalKey _key = LabeledGlobalKey("button_icon");
  // GlobalKey _keymail = LabeledGlobalKey("mailus");
  OverlayEntry _overlayEntry;
  OverlayEntry _overlayEntrymail;
  OverlayEntry _overlayEntrysearchcon;
  Size buttonSize;
  Offset buttonPosition;
  bool isMenuOpen = false;
  bool isMenusearchOpen = false;
  bool isMenumailOpen = false;

  bool toggle = true;
  OverlayEntry _overlayEntrysearch() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width / 2,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter a search term'),
                    ),
                    trailing:
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.greenAccent,
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A FOOD BANK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A CLOTH BANK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("OUR WORK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("JOIN US TODAY"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("OUR CALENDAR"),
                    onTap: () {},
                  ),
                ),
              ],
            ), //code for the drop-down menu...,
          ),
        );
      },
    );
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenumail() {
    findButton();
    _overlayEntrymail = _overlayEntrymailus();
    Overlay.of(context).insert(_overlayEntrymail);
    isMenumailOpen = !isMenumailOpen;
  }

  void closeMenumail() {
    _overlayEntrymail.remove();
    isMenumailOpen = !isMenumailOpen;
  }

  void openMenusearch() async {
    findButton();
    _overlayEntrysearchcon = _overlayEntrysearch();
    Overlay.of(context).insert(_overlayEntrysearchcon);
    isMenusearchOpen = !isMenusearchOpen;
  }

  void closeMenusearch() {
    _overlayEntrysearchcon.remove();
    isMenusearchOpen = !isMenusearchOpen;
  }

  OverlayEntry _overlayEntrymailus() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width / 2,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email address'),
                    ),
                    trailing: join
                        ? FlatButton(
                            color: Colors.red[900],
                            onPressed: () {
                              if (isMenumailOpen) {
                                closeMenumail();
                              }
                            },
                            child: Text("JOIN"),
                          )
                        : IconButton(icon: Icon(Icons.mail), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  final List<String> images = [
    'assets/images/walkinaid.jpg',
    'assets/images/walkinaid2.jpg',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> images2 = [
    'assets/images/bannerimage4.jpg',
    'assets/images/elderly.jpg',
    'assets/images/donateimg.jpg',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: MediaQuery.of(context).size.height / 4,
            title: Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.width / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    margin: const EdgeInsets.only(top: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Builder(builder: (context) {
                        return Center(
                          child: Image.asset(
                            "assets/images/logo.jpg",
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 10,
                          ),
                        );
                      }),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    key: _key,
                                    color: Colors.green[300],
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      if (isMenuOpen) {
                                        closeMenu();
                                      }
                                      if (isMenumailOpen) {
                                        closeMenumail();
                                      }

                                      if (isMenusearchOpen) {
                                        closeMenusearch();
                                      } else {
                                        openMenusearch();
                                      }
                                    }),
                                Text(
                                  "Search",
                                  style: TextStyle(color: Colors.green[300]),
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    color: Colors.green[300],
                                    icon: Icon(Icons.add_location),
                                    onPressed: () {
                                      _controllers.position.moveTo(10000000000);
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    _controllers.position.moveTo(10000000000);
                                  },
                                  child: Text("Need Help",
                                      style:
                                          TextStyle(color: Colors.green[300])),
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    color: Colors.green[300],
                                    icon: Icon(Icons.mail),
                                    onPressed: () {
                                      setState(() {
                                        join = false;
                                      });
                                      if (isMenuOpen) {
                                        closeMenu();
                                      }
                                      if (isMenusearchOpen) {
                                        closeMenusearch();
                                      }

                                      if (isMenumailOpen) {
                                        closeMenumail();
                                      } else {
                                        openMenumail();
                                      }
                                    }),
                                Text("Sign Up",
                                    style: TextStyle(color: Colors.green[300]))
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 15,
                              child: FlatButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/donatetoUs');
                                  router.navigateTo(context, "/donate",
                                      transition: TransitionType.fadeIn);
                                },
                                child: Text(
                                  "DONATE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red[900],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "REGISTRATION NO:",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      "CAC IT/NO 118377",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 50,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width / 10,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(
                                        //     context, '/findlocation');
                                        router.navigateTo(context, "/findus",
                                            transition: TransitionType.fadeIn);
                                      },
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "FIND A",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "FOOD BANK",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(
                                        //     context, '/findlocation');
                                        router.navigateTo(context, "/findus",
                                            transition: TransitionType.fadeIn);
                                      },
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "FIND A",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "CLOTH BANK",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(
                                        //     context, '/ourwork');
                                        router.navigateTo(context, "/ourwork",
                                            transition: TransitionType.fadeIn);
                                      },
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "OUR",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "WORK",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        router.navigateTo(context, "/volunteer",
                                            transition: TransitionType.fadeIn);
                                      },
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "VOLUNTEER",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "TODAY",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        _controllers.position
                                            .moveTo(10000000000);
                                      },
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "CONTACT",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "US",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width: 1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: _controllers,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Image.asset("assets/images/ourworkbanner.jpg",
                          fit: BoxFit.fill),
                    ),
                    Positioned(
                        left: 60,
                        top: 30,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black26),
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "Working together to share love",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                children: [
                                  Text(
                                    "Provision of walking aids to the elderly and other vulnerable groups",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                      "We provide working aids for the elderly and also for people living with disability"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "see more >>>",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red[700]),
                                  ),
                                ],
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CarouselSlider.builder(
                                itemCount: images.length,
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: Center(
                                          child: Image.asset(images[index],
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3)));
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  padding: const EdgeInsets.only(left: 60, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CarouselSlider.builder(
                                itemCount: images2.length,
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: Center(
                                          child: Image.asset(images2[index],
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3)));
                                }),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                children: [
                                  Text(
                                    "facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                      "We ensure the elderly and vulnerable get access to affordable healthcare services"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "see more >>>",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red[700]),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Organizational Values",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Open communication",
                                            style: TextStyle(fontSize: 20)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Text(
                                              "NCGI is committed to sharing information in a respectful and friendly manner. The regular exchange of quality information – between board of trustees and affiliates , volunteers and our partners – provides the basis for informed quality decision-making in our day to day operations",
                                              style: TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Column(
                                children: [
                                  Text(
                                    "Strategic Objectives And Target",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            "To sensitize communities on the need to care for the elderly and other vulnerable groups",
                                            style: TextStyle(fontSize: 15),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                              "To advocate for the development and implementation of policies that will improve the generalwell-being and overall welfare of our beneficiaries",
                                              style: TextStyle(fontSize: 15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                              "To facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                              style: TextStyle(fontSize: 15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    // height: 40,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            "To fundraise (through proposal writing, campaigns, partnership and collaborative efforts with corporate bodies and small scale businesses to promote activities",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      // height: 40,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(String.fromCharCode(0x2022)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Text(
                                                "Our approach is to start operations locally, regionally and then nationally as we increase in reach, resources and financial capacity",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ])),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      // height: 40,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(String.fromCharCode(0x2022)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Text(
                                                "To support 1000 vulnerable people through: Empowerment,Provision of walking aids to the elderly and other vulnerable groups,Community kitchen for the needy,Food bank,Clothe bank,Day centre for the elderly",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ]))
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
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
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.height /
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
                                            "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
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
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Column(
                                      children: [
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
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Address: Plot A26 Sparkling Estate\nOpic BusStop\nIsheri Berger.Lagos State",
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Phone Contact: \n0023408145274419\n0023408136036102\n0023408069375979\n00353892450699\n+447459277208\n00353899434508",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
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
        Container(
          height: MediaQuery.of(context).size.height,
          child: FlutterWebScroller(
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
        ),
      ],
    );
  }
}

class Ourworktab extends StatefulWidget {
  @override
  _OurworktabState createState() => _OurworktabState();
}

class _OurworktabState extends State<Ourworktab> {
  ScrollController _controllers;
  final CarouselController _controller = CarouselController();
  GlobalKey _key = LabeledGlobalKey("tab");
  //GlobalKey _keymail = LabeledGlobalKey("mailus");
  OverlayEntry _overlayEntry;
  OverlayEntry _overlayEntrymail;
  OverlayEntry _overlayEntrysearchcon;
  Size buttonSize;
  Offset buttonPosition;
  bool isMenuOpen = false;
  bool isMenusearchOpen = false;
  bool isMenumailOpen = false;

  bool toggle = true;

  final List<String> images = [
    'assets/images/walkinaid.jpg',
    'assets/images/walkinaid2.jpg',
    // 'https://www.pacificneuroscienceinstitute.org/wp-content/uploads/Essential-Tremor-March-2017-banner-bw-680x350.jpg',
    // 'https://humanity-inclusion.org.uk/sn_uploads/uk/page/inclusion-1280x720_0.jpg?maxw=1110',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> images2 = [
    'assets/images/bannerimage4.jpg',
    'assets/images/elderly.jpg',
    'assets/images/donateimg.jpg',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  @override
  void initState() {
    _controllers = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  //https://www.feedingamerica.org/sites/default/files/styles/max_1300x1300/public/2020-08/Golden%20Harvest%201360X450.jpg?itok=oIoAZv7G

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.8);
    });
  }

  OverlayEntry _overlayEntrysearch() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width / 2,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter a search term'),
                    ),
                    trailing:
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.greenAccent,
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A FOOD BANK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A CLOTH BANK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("OUR WORK"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("JOIN US TODAY"),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("OUR CALENDAR"),
                    onTap: () {},
                  ),
                ),
              ],
            ), //code for the drop-down menu...,
          ),
        );
      },
    );
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenumail() {
    findButton();
    _overlayEntrymail = _overlayEntrymailus();
    Overlay.of(context).insert(_overlayEntrymail);
    isMenumailOpen = !isMenumailOpen;
  }

  void closeMenumail() {
    _overlayEntrymail.remove();
    isMenumailOpen = !isMenumailOpen;
  }

  void openMenusearch() async {
    findButton();
    _overlayEntrysearchcon = _overlayEntrysearch();
    Overlay.of(context).insert(_overlayEntrysearchcon);
    isMenusearchOpen = !isMenusearchOpen;
  }

  void closeMenusearch() {
    _overlayEntrysearchcon.remove();
    isMenusearchOpen = !isMenusearchOpen;
  }

  OverlayEntry _overlayEntrymailus() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width / 2,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email address'),
                    ),
                    trailing: join
                        ? FlatButton(
                            color: Colors.red[900],
                            onPressed: () {
                              if (isMenumailOpen) {
                                closeMenumail();
                              }
                            },
                            child: Text("JOIN"),
                          )
                        : IconButton(icon: Icon(Icons.mail), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: MediaQuery.of(context).size.height / 5,
            automaticallyImplyLeading: false,
            title: SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 0),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 10,
                      child: Builder(builder: (context) {
                        return Image.asset(
                          "assets/images/logo.jpg",
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 5,
                        );
                      }),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        key: _key,
                                        color: Colors.green[300],
                                        icon: Icon(
                                          Icons.search,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          if (isMenuOpen) {
                                            closeMenu();
                                          }
                                          if (isMenumailOpen) {
                                            closeMenumail();
                                          }

                                          if (isMenusearchOpen) {
                                            closeMenusearch();
                                          } else {
                                            openMenusearch();
                                          }
                                        }),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          color: Colors.green[300],
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        color: Colors.green[300],
                                        icon: Icon(
                                          Icons.add_location,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          _controllers.position
                                              .moveTo(10000000000);
                                        }),
                                    GestureDetector(
                                      onTap: () {
                                        _controllers.position
                                            .moveTo(10000000000);
                                      },
                                      child: Text("Need Help",
                                          style: TextStyle(
                                              color: Colors.green[300],
                                              fontSize: 12)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        color: Colors.green[300],
                                        icon: Icon(
                                          Icons.mail,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            join = false;
                                          });
                                          if (isMenuOpen) {
                                            closeMenu();
                                          }
                                          if (isMenusearchOpen) {
                                            closeMenusearch();
                                          }

                                          if (isMenumailOpen) {
                                            closeMenumail();
                                          } else {
                                            openMenumail();
                                          }
                                        }),
                                    Text("Sign Up",
                                        style: TextStyle(
                                            color: Colors.green[300],
                                            fontSize: 12))
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  child: FlatButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(
                                      //     context, '/donatetoUs');
                                      router.navigateTo(context, "/donate",
                                          transition: TransitionType.fadeIn);
                                    },
                                    child: Text(
                                      "DONATE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red[900],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Center(
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            child: Text(
                                              "REGISTRATION NO:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11),
                                            ),
                                          ),
                                          Text(
                                            "CAC IT/NO 118377",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width / 10,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: SingleChildScrollView(
                                        child: FlatButton(
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            //     context, '/findlocation');
                                            router.navigateTo(
                                                context, "/findus",
                                                transition:
                                                    TransitionType.fadeIn);
                                          },
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "FIND A",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "FOOD BANK",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: SingleChildScrollView(
                                        child: FlatButton(
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            //     context, '/findlocation');
                                            router.navigateTo(
                                                context, "/findus",
                                                transition:
                                                    TransitionType.fadeIn);
                                          },
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "FIND A",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "CLOTH BANK",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: SingleChildScrollView(
                                        child: FlatButton(
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            //     context, '/ourwork');
                                            router.navigateTo(
                                                context, "/ourwork",
                                                transition:
                                                    TransitionType.fadeIn);
                                          },
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "OUR",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "WORK",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: SingleChildScrollView(
                                        child: FlatButton(
                                          onPressed: () {
                                            router.navigateTo(
                                                context, "/volunteer",
                                                transition:
                                                    TransitionType.fadeIn);
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "VOLUNTEER",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "TODAY",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: SingleChildScrollView(
                                        child: FlatButton(
                                          onPressed: () {
                                            _controllers.position
                                                .moveTo(10000000000);
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "CONTACT",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "US",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: 1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
              controller: _controllers,
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Image.asset("assets/images/ourworkbanner.jpg",
                          fit: BoxFit.fill),
                    ),
                    Positioned(
                        left: 60,
                        top: 30,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black26),
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 2.5,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "Working together to share love",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: MediaQuery.of(context).size.height / 5,
                                child: Text(
                                  "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                children: [
                                  Text(
                                    "Provision of walking aids to the elderly and other vulnerable groups",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                      "We provide working aids for the elderly and also for people living with disability"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "see more >>>",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red[700]),
                                  ),
                                ],
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CarouselSlider.builder(
                                itemCount: images.length,
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: Center(
                                          child: Image.asset(images[index],
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3)));
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: const EdgeInsets.only(left: 60, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CarouselSlider.builder(
                                itemCount: images2.length,
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: Center(
                                          child: Image.asset(images2[index],
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3)));
                                }),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                children: [
                                  Text(
                                    "facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                      "We ensure the elderly and vulnerable get access to affordable healthcare services"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "see more >>>",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red[700]),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 1.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Organizational Values",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Open communication",
                                            style: TextStyle(fontSize: 20)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: Text(
                                              "NCGI is committed to sharing information in a respectful and friendly manner. The regular exchange of quality information – between board of trustees and affiliates , volunteers and our partners – provides the basis for informed quality decision-making in our day to day operations",
                                              style: TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 1.2,
                              child: Column(
                                children: [
                                  Text(
                                    "Strategic Objectives And Target",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            "To sensitize communities on the need to care for the elderly and other vulnerable groups",
                                            style: TextStyle(fontSize: 15),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                              "To advocate for the development and implementation of policies that will improve the generalwell-being and overall welfare of our beneficiaries",
                                              style: TextStyle(fontSize: 15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                              "To facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                              style: TextStyle(fontSize: 15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    // height: 40,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(String.fromCharCode(0x2022)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            "To fundraise (through proposal writing, campaigns, partnership and collaborative efforts with corporate bodies and small scale businesses to promote activities",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      // height: 40,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(String.fromCharCode(0x2022)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Text(
                                                "Our approach is to start operations locally, regionally and then nationally as we increase in reach, resources and financial capacity",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ])),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      // height: 40,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(String.fromCharCode(0x2022)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Text(
                                                "To support 1000 vulnerable people through: Empowerment,Provision of walking aids to the elderly and other vulnerable groups,Community kitchen for the needy,Food bank,Clothe bank,Day centre for the elderly",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ]))
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                js.context.callMethod("open", [
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
                                                js.context.callMethod("open", [
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
                                                js.context.callMethod("open", [
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
                                      MediaQuery.of(context).size.height / 3,
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
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
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                            FontWeight.bold),
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
              ])),
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

class Ourworkphone extends StatefulWidget {
  @override
  _OurworkphoneState createState() => _OurworkphoneState();
}

class _OurworkphoneState extends State<Ourworkphone> {
  final CarouselController _controller = CarouselController();
  ScrollController _controllers = ScrollController();
  final List<String> images = [
    'assets/images/walkinaid.jpg',
    'assets/images/walkinaid2.jpg',
    // 'https://www.pacificneuroscienceinstitute.org/wp-content/uploads/Essential-Tremor-March-2017-banner-bw-680x350.jpg',
    // 'https://humanity-inclusion.org.uk/sn_uploads/uk/page/inclusion-1280x720_0.jpg?maxw=1110',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> images2 = [
    'assets/images/bannerimage4.jpg',
    'assets/images/elderly.jpg',
    'assets/images/donateimg.jpg',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  GlobalKey _key = LabeledGlobalKey("button_icon");
  //GlobalKey _keymail = LabeledGlobalKey("mailus");
  OverlayEntry _overlayEntry;
  OverlayEntry _overlayEntrymail;
  OverlayEntry _overlayEntrysearchcon;
  Size buttonSize;
  Offset buttonPosition;
  bool isMenuOpen = false;
  bool isMenusearchOpen = false;
  bool isMenumailOpen = false;
  List<Icon> icons = [
    Icon(Icons.person),
    Icon(Icons.settings),
    Icon(Icons.credit_card),
  ];

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.greenAccent,
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A FOOD BANK"),
                    onTap: () {
                      if (isMenusearchOpen) {
                        closeMenusearch();
                      }
                      if (isMenumailOpen) {
                        closeMenumail();
                      }
                      if (isMenuOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }

                      // Navigator.pushNamed(context, '/findlocation');
                      router.navigateTo(context, "/findus",
                          transition: TransitionType.fadeIn);
                    },
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("FIND A CLOTH BANK"),
                    onTap: () {
                      if (isMenusearchOpen) {
                        closeMenusearch();
                      }
                      if (isMenumailOpen) {
                        closeMenumail();
                      }
                      if (isMenuOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }

                      // Navigator.pushNamed(context, '/findlocation');
                      router.navigateTo(context, "/findus",
                          transition: TransitionType.fadeIn);
                    },
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("OUR WORK"),
                    onTap: () {
                      if (isMenusearchOpen) {
                        closeMenusearch();
                      }
                      if (isMenumailOpen) {
                        closeMenumail();
                      }
                      if (isMenuOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }

                      // Navigator.pushNamed(context, '/ourwork');
                      router.navigateTo(context, "/ourwork",
                          transition: TransitionType.fadeIn);
                    },
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("VOLUNTEER TODAY"),
                    onTap: () {
                      if (isMenusearchOpen) {
                        closeMenusearch();
                      }
                      if (isMenumailOpen) {
                        closeMenumail();
                      }
                      if (isMenuOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }
                      router.navigateTo(context, "/volunteer",
                          transition: TransitionType.fadeIn);
                      //Navigator.pushNamed(context, '/ourwork');
                    },
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Text("CONTACT US"),
                    onTap: () {
                      if (isMenusearchOpen) {
                        closeMenusearch();
                      }
                      if (isMenumailOpen) {
                        closeMenumail();
                      }
                      if (isMenuOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }

                      _controllers.position.moveTo(10000000000);
                    },
                  ),
                ),
              ],
            ), //code for the drop-down menu...,
          ),
        );
      },
    );
  }

  OverlayEntry _overlayEntrysearch() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter a search term'),
                    ),
                    trailing:
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  OverlayEntry _overlayEntrymailus() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: MediaQuery.of(context).size.width,
          child: Material(
              color: Colors.greenAccent,
              child: Column(
                children: [
                  ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email address'),
                    ),
                    trailing: join
                        ? FlatButton(
                            color: Colors.red[900],
                            onPressed: () {
                              if (isMenumailOpen) {
                                closeMenumail();
                              }
                            },
                            child: Text("JOIN"),
                          )
                        : IconButton(icon: Icon(Icons.mail), onPressed: () {}),
                  ),
                ],
              )));
    });
  }

  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada = Matrix4.identity();
  double _scale = 1.0;
  double _previousscale = 1.0;

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenumail() {
    findButton();
    _overlayEntrymail = _overlayEntrymailus();
    Overlay.of(context).insert(_overlayEntrymail);
    isMenumailOpen = !isMenumailOpen;
  }

  void closeMenumail() {
    _overlayEntrymail.remove();
    isMenumailOpen = !isMenumailOpen;
  }

  void openMenusearch() async {
    findButton();
    _overlayEntrysearchcon = _overlayEntrysearch();
    Overlay.of(context).insert(_overlayEntrysearchcon);
    isMenusearchOpen = !isMenusearchOpen;
  }

  void closeMenusearch() {
    _overlayEntrysearchcon.remove();
    isMenusearchOpen = !isMenusearchOpen;
  }

  Widget overlay(BuildContext context) {
    return Container(
      height: icons.length * buttonSize.height,
      decoration: BoxDecoration(
        color: Color(0xFFF67C0B9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Theme(
        data: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            icons.length,
            (index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: buttonSize.width,
                  height: buttonSize.height,
                  child: icons[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.white,
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
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
                                        MediaQuery.of(context).size.height / 4,
                                    // fit: BoxFit.fill,
                                  ),
                                );
                              }),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      color: Colors.green[300],
                                      icon: Icon(Icons.add_location),
                                      onPressed: () {
                                        _controllers.position
                                            .moveTo(10000000000);
                                      }),
                                  GestureDetector(
                                    onTap: () {
                                      _controllers.position.moveTo(10000000000);
                                    },
                                    child: Text("Need Help",
                                        style: TextStyle(
                                            color: Colors.green[300])),
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 20,
                                child: FlatButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/donatetoUs');
                                    router.navigateTo(context, "/donate",
                                        transition: TransitionType.fadeIn);
                                  },
                                  child: Text(
                                    "DONATE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red[900],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _controllers,
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
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height,
                          child: Column(children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 25,
                              color: Colors.greenAccent,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Container(
                                            key: _key,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: IconButton(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                icon: Icon(Icons.menu),
                                                onPressed: () {
                                                  if (isMenusearchOpen) {
                                                    closeMenusearch();
                                                  }
                                                  if (isMenumailOpen) {
                                                    closeMenumail();
                                                  }
                                                  if (isMenuOpen) {
                                                    closeMenu();
                                                  } else {
                                                    openMenu();
                                                  }
                                                }),
                                          ),
                                          Text("Menu"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          // FlatButton(
                                          //     onPressed: () {
                                          //       setState(() {
                                          //         join = true;
                                          //       });
                                          //       if (isMenuOpen) {
                                          //         closeMenu();
                                          //       }
                                          //       if (isMenusearchOpen) {
                                          //         closeMenusearch();
                                          //       }

                                          //       if (isMenumailOpen) {
                                          //         closeMenumail();
                                          //       } else {
                                          //         openMenumail();
                                          //       }
                                          //     },
                                          //     child: Text("JOIN US")),
                                          IconButton(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              icon: Icon(Icons.search),
                                              onPressed: () {
                                                if (isMenuOpen) {
                                                  closeMenu();
                                                }
                                                if (isMenumailOpen) {
                                                  closeMenumail();
                                                }

                                                if (isMenusearchOpen) {
                                                  closeMenusearch();
                                                } else {
                                                  openMenusearch();
                                                }
                                              }),
                                          Container(
                                            child: IconButton(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                icon: Icon(Icons.mail),
                                                onPressed: () {
                                                  setState(() {
                                                    join = false;
                                                  });
                                                  if (isMenuOpen) {
                                                    closeMenu();
                                                  }
                                                  if (isMenusearchOpen) {
                                                    closeMenusearch();
                                                  }

                                                  if (isMenumailOpen) {
                                                    closeMenumail();
                                                  } else {
                                                    openMenumail();
                                                  }
                                                }),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: Image.asset(
                                          "assets/images/ourworkbanner.jpg",
                                          fit: BoxFit.fill),
                                    ),
                                    Positioned(
                                        left: 60,
                                        top: 30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black26),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Working together to share love",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              SizedBox(height: 5),
                                              SingleChildScrollView(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4,
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Provision of walking aids to the elderly and other vulnerable groups",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                      "We provide working aids for the elderly and also for people living with disability"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "see more >>>",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red[700]),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: CarouselSlider.builder(
                                                itemCount: images.length,
                                                carouselController: _controller,
                                                options: CarouselOptions(
                                                  autoPlay: true,
                                                  aspectRatio: 2.0,
                                                  enlargeCenterPage: true,
                                                  viewportFraction: 1.0,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                      child: Center(
                                                          child: Image.asset(
                                                              images[index],
                                                              fit: BoxFit.cover,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3)));
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  padding:
                                      const EdgeInsets.only(left: 60, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: CarouselSlider.builder(
                                                itemCount: images2.length,
                                                carouselController: _controller,
                                                options: CarouselOptions(
                                                  autoPlay: true,
                                                  aspectRatio: 2.0,
                                                  enlargeCenterPage: true,
                                                  viewportFraction: 1.0,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                      child: Center(
                                                          child: Image.asset(
                                                              images2[index],
                                                              fit: BoxFit.fill,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3)));
                                                }),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                      "We ensure the elderly and vulnerable get access to affordable healthcare services"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "see more >>>",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red[700]),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 1.3,
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Organizational Values",
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                            "Open communication",
                                                            style: TextStyle(
                                                                fontSize: 20)),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              1.5,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Text(
                                                                "NCGI is committed to sharing information in a respectful and friendly manner. The regular exchange of quality information – between board of trustees and affiliates , volunteers and our partners – provides the basis for informed quality decision-making in our day to day operations",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1.25,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Strategic Objectives And Target",
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            String.fromCharCode(
                                                                0x2022)),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                            "To sensitize communities on the need to care for the elderly and other vulnerable groups",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            String.fromCharCode(
                                                                0x2022)),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                              "To advocate for the development and implementation of policies that will improve the generalwell-being and overall welfare of our beneficiaries",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                    height: 50,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            String.fromCharCode(
                                                                0x2022)),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                              "To facilitate access to affordable healthcare services for the elderly and other vulnerable groups",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                    // height: 40,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            String.fromCharCode(
                                                                0x2022)),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                            "To fundraise (through proposal writing, campaigns, partnership and collaborative efforts with corporate bodies and small scale businesses to promote activities",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      // height: 40,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(String
                                                                .fromCharCode(
                                                                    0x2022)),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.5,
                                                              child: Text(
                                                                "Our approach is to start operations locally, regionally and then nationally as we increase in reach, resources and financial capacity",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            )
                                                          ])),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      // height: 40,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(String
                                                                .fromCharCode(
                                                                    0x2022)),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.5,
                                                              child: Text(
                                                                "To support 1000 vulnerable people through: Empowerment,Provision of walking aids to the elderly and other vulnerable groups,Community kitchen for the needy,Food bank,Clothe bank,Day centre for the elderly",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            )
                                                          ]))
                                                ],
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black87,
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "FIND OUT MORE",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                js.context
                                                                    .callMethod(
                                                                        "open",
                                                                        [
                                                                      "https://www.instagram.com/ncgi_19"
                                                                    ]);
                                                              },
                                                              child:
                                                                  Image.asset(
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
                                                                js.context
                                                                    .callMethod(
                                                                        "open",
                                                                        [
                                                                      " http://twitter.com/ncgi_19"
                                                                    ]);
                                                              },
                                                              child:
                                                                  Image.asset(
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
                                                                js.context
                                                                    .callMethod(
                                                                        "open",
                                                                        [
                                                                      "https://fb.me/NewchanceNCGI"
                                                                    ]);
                                                              },
                                                              child:
                                                                  Image.asset(
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
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "OUR COMMUNITY PARTNERS",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            5,
                                                        child: Text(
                                                          "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Image.asset(
                                                        "assets/images/partner.jpg",
                                                        alignment:
                                                            Alignment.center,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            10,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "CONTACT INFO",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Address: \nPlot A26 Sparkling Estate\nOpic BusStop\nIsheri Berger.Lagos State",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "Email: anewchanceinlife@gmail.com",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    "Phone Contact: \n0023408145274419\n0023408136036102\n0023408069375979\n00353892450699\n+447459277208\n00353899434508",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                            )
                          ]))))),
        ),
      ),
    );
  }
}
