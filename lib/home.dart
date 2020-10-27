import 'dart:ui';
import 'dart:js' as js;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:ngo/main.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

bool join = false;

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 1200) {
        return Homedesktop();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return InteractiveViewer(child: Tabdesktop());
      } else {
        return InteractiveViewer(child: Phonehome());
      }
    });
  }
}

class Phonehome extends StatefulWidget {
  @override
  _PhonehomeState createState() => _PhonehomeState();
}

class _PhonehomeState extends State<Phonehome> {
  final CarouselController _controller = CarouselController();
  ScrollController _controllers = ScrollController();

  final List<String> images = [
    'assets/images/banners3.jpg',
    'assets/images/bannerimage2.jpg',
    'assets/images/bannerimage3.jpg',
    'assets/images/bannerimage4.jpg',
    'assets/images/banners1.jpg',
    'assets/images/banners2.jpg',

    // 'https://www.pacificneuroscienceinstitute.org/wp-content/uploads/Essential-Tremor-March-2017-banner-bw-680x350.jpg',
    // 'https://humanity-inclusion.org.uk/sn_uploads/uk/page/inclusion-1280x720_0.jpg?maxw=1110',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> imagesmission = [
    'assets/images/mission1.png',
    'assets/images/policy1.png',
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
  VideoPlayerController _controllervid;
  VideoPlayerController _controllerweb;
  VideoPlayerController _controllerweb2;
  FlickManager flickManager;

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
                      router.navigateTo(context, "/findus",
                          transition: TransitionType.fadeIn);
                      // Navigator.pushNamed(context, '/findlocation');
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
                      router.navigateTo(context, "/findus",
                          transition: TransitionType.fadeIn);
                      //Navigator.pushNamed(context, '/findlocation');
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
                      router.navigateTo(context, "/ourwork",
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
  void initState() {
    _controllerweb2 = VideoPlayerController.asset(
      "assets/images/testimony.mp4",
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controllerweb2.addListener(() {
      setState(() {});
    });
    _controllerweb2.setLooping(true);
    _controllerweb2.initialize();
    _controllers = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    _controllerweb = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset("assets/images/testimony.mp4"),
    );
    _controllervid = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controllerweb2.dispose();
    super.dispose();
    _controllervid.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: false,
          //   backgroundColor: Colors.white,
          //   toolbarHeight: MediaQuery.of(context).size.height / 3,
          //   title: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child: Column(
          //       children: [
          //         Container(
          //           child: FittedBox(
          //             child: Row(
          //               children: [
          //                 Text(
          //                   "hey",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                                          MediaQuery.of(context).size.height /
                                              4,
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
                                        _controllers.position
                                            .moveTo(10000000000);
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
                                      router.navigateTo(context, "/donate",
                                          transition: TransitionType.fadeIn);
                                      //Navigator.pushNamed(context, '/donatetoUs');
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
          // GestureDetector(
          //   onDoubleTap: () {
          //     setState(() {
          //       matrix = zerada;
          //     });
          //   },
          //   child: MatrixGestureDetector(
          //     shouldRotate: false,
          //     onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          //       setState(() {
          //         matrix = m;
          //       });
          //     },
          //     child: Transform(
          //       transform: matrix,
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
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 25,
                          color: Colors.greenAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      MediaQuery.of(context).size.height / 25,
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
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
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
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              // ListView(shrinkWrap: true, children: [
                              //   Container(
                              //     margin: const EdgeInsets.only(top: 0),
                              //     child: Image.asset(
                              //       "assets/firstone.png",
                              //       width: MediaQuery.of(context).size.width * 1.5,
                              //       height: MediaQuery.of(context).size.width / 2,
                              //     ),
                              //   ),
                              // ]),
                              // CarouselSlider(
                              //   items: imageSliders,
                              //   options:
                              //       CarouselOptions(enlargeCenterPage: true, height: 200),
                              //   carouselController: _controller,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: RaisedButton(
                              //         onPressed: () => _controller.previousPage(),
                              //         child: Text('←'),
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: RaisedButton(
                              //         onPressed: () => _controller.nextPage(),
                              //         child: Text('→'),
                              //       ),
                              //     ),
                              //     ...Iterable<int>.generate(imgList.length).map(
                              //       (int pageIndex) => Flexible(
                              //         child: RaisedButton(
                              //           onPressed: () =>
                              //               _controller.animateToPage(pageIndex),
                              //           child: Text("$pageIndex"),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // )
                              //
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Stack(
                                          children: [
                                            CarouselSlider.builder(
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
                                                              fit: BoxFit.fill,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width)));
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.green[800],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 1, right: 1),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: FittedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "FIND YOUR LOCAL FOOD BANK",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    width: 200,
                                                    height: 40,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Enter a search term'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  FlatButton(
                                                      color: Colors.amberAccent,
                                                      onPressed: () {},
                                                      child: Text("LOCATE"))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                height: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.black26,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        width: 1,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: FittedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "FIND YOUR LOCAL CLOTH BANK",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    width: 200,
                                                    height: 40,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText:
                                                              'Enter a search term'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  FlatButton(
                                                      color: Colors.amberAccent,
                                                      onPressed: () {},
                                                      child: Text("LOCATE"))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                height: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 10, right: 5),
                                  child: CarouselSlider.builder(
                                      itemCount: imagesmission.length,
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
                                                    imagesmission[index],
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width)));
                                      }),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.3,
                                      child: AspectRatio(
                                        aspectRatio:
                                            _controllerweb2.value.aspectRatio,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            VideoPlayer(_controllerweb2),
                                            ClosedCaption(
                                                text: _controllerweb2
                                                    .value.caption.text),
                                            _PlayPauseOverlay(
                                                controller: _controllerweb2),
                                            VideoProgressIndicator(
                                                _controllerweb2,
                                                allowScrubbing: true),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "WORKING TOGETHER TO HELP THE VULNERABLE",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Text(
                                            "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/wheels1.jpg"),
                                  fit: BoxFit.cover,
                                )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, bottom: 30),
                                      child: Center(
                                          child: Text(
                                        "HELP SAVE LIVES TODAY",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            color: Colors.white,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/giveday.jpg",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            15,
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6.2,
                                                    child: FittedBox(
                                                      child: Text(
                                                        "GIVE TODAY",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green[200],
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  "assets/images/givemont.png",
                                                  colorBlendMode:
                                                      BlendMode.color,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "GIVE MONTHLY",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[200],
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            color: Colors.white,
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  "assets/images/fundraise.png",
                                                  colorBlendMode:
                                                      BlendMode.color,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "FUND RAISE",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[200],
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            color: Colors.white,
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  "assets/images/volunteer.png",
                                                  colorBlendMode:
                                                      BlendMode.color,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "VOLUNTEER",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[200],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
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
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  height:
                                      MediaQuery.of(context).size.height / 1.07,
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
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width:
                                                          MediaQuery.of(context)
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
                                                              FontWeight.bold),
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
                                                              js.context
                                                                  .callMethod(
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
                                                              js.context
                                                                  .callMethod(
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
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      color: Colors.white,
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Text(
                                                        "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
                                                        style: TextStyle(
                                                            color: Colors.white,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              10,
                                                      width:
                                                          MediaQuery.of(context)
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
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "CONTACT INFO",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width:
                                                          MediaQuery.of(context)
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class Homedesktop extends StatefulWidget {
  @override
  _HomedesktopState createState() => _HomedesktopState();
}

class _HomedesktopState extends State<Homedesktop> {
  ScrollController _controllers;
  final CarouselController _controller = CarouselController();
  GlobalKey _key = LabeledGlobalKey("me say");
  //GlobalKey _keymail = LabeledGlobalKey("mailus");

  final List<String> images = [
    'assets/images/banners3.jpg',
    'assets/images/bannerimage2.jpg',
    'assets/images/bannerimage3.jpg',
    'assets/images/bannerimage4.jpg',
    'assets/images/banners1.jpg',
    'assets/images/banners2.jpg',
    // 'https://www.pacificneuroscienceinstitute.org/wp-content/uploads/Essential-Tremor-March-2017-banner-bw-680x350.jpg',
    // 'https://humanity-inclusion.org.uk/sn_uploads/uk/page/inclusion-1280x720_0.jpg?maxw=1110',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> imagesmission = [
    'assets/images/mission1.png',
    'assets/images/policy1.png',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  VideoPlayerController _controllervid;
  VideoPlayerController _controllerweb;
  VideoPlayerController _controllerweb2;
  FlickManager flickManager;
  @override
  void initState() {
    _controllerweb2 = VideoPlayerController.asset(
      "assets/images/testimony.mp4",
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controllerweb2.addListener(() {
      setState(() {});
    });
    _controllerweb2.setLooping(true);
    _controllerweb2.initialize();
    _controllers = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    _controllerweb = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset("assets/images/testimony.mp4"),
    );
    _controllervid = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

// FlickVideoPlayer(
//                       flickManager: flickManager
//                   ),
  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  void dispose() {
    _controllerweb2.dispose();
    super.dispose();
    _controllervid.dispose();
    flickManager.dispose();
  }

  //https://www.feedingamerica.org/sites/default/files/styles/max_1300x1300/public/2020-08/Golden%20Harvest%201360X450.jpg?itok=oIoAZv7G

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.9);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          elevation: 0,
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
                                    style: TextStyle(color: Colors.green[300])),
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
                                //Navigator.pushNamed(context, '/donatetoUs');
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  color: Colors.black26,
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                  width: 1,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 10,
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
                                  width: MediaQuery.of(context).size.width / 10,
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
                                  width: MediaQuery.of(context).size.width / 10,
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
                                      MediaQuery.of(context).size.width / 9.5,
                                  child: FlatButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   join = true;
                                      // });
                                      // if (isMenuOpen) {
                                      //   closeMenu();
                                      // }
                                      // if (isMenusearchOpen) {
                                      //   closeMenusearch();
                                      // }

                                      // if (isMenumailOpen) {
                                      //   closeMenumail();
                                      // } else {
                                      //   openMenumail();
                                      // }
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
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: FlatButton(
                                    onPressed: () {
                                      _controllers.position.moveTo(10000000000);
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
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // ListView(shrinkWrap: true, children: [
                //   Container(
                //     margin: const EdgeInsets.only(top: 0),
                //     child: Image.asset(
                //       "assets/firstone.png",
                //       width: MediaQuery.of(context).size.width * 1.5,
                //       height: MediaQuery.of(context).size.width / 2,
                //     ),
                //   ),
                // ]),
                // CarouselSlider(
                //   items: imageSliders,
                //   options:
                //       CarouselOptions(enlargeCenterPage: true, height: 200),
                //   carouselController: _controller,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Flexible(
                //       child: RaisedButton(
                //         onPressed: () => _controller.previousPage(),
                //         child: Text('←'),
                //       ),
                //     ),
                //     Flexible(
                //       child: RaisedButton(
                //         onPressed: () => _controller.nextPage(),
                //         child: Text('→'),
                //       ),
                //     ),
                //     ...Iterable<int>.generate(imgList.length).map(
                //       (int pageIndex) => Flexible(
                //         child: RaisedButton(
                //           onPressed: () =>
                //               _controller.animateToPage(pageIndex),
                //           child: Text("$pageIndex"),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
                //
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            CarouselSlider.builder(
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
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width)));
                                }),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 250),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(40),
                                          topRight: Radius.circular(40)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(40),
                                              topRight: Radius.circular(40)),
                                          color: Colors.white,
                                        ),
                                        width: 30,
                                        child: Center(
                                          child: IconButton(
                                              icon: Icon(Icons.arrow_left),
                                              onPressed: () {
                                                _controller.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.linear);
                                              }),
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(40),
                                          topLeft: Radius.circular(40)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(40),
                                              topLeft: Radius.circular(40)),
                                          color: Colors.white,
                                        ),
                                        width: 40,
                                        child: Center(
                                          child: IconButton(
                                              icon: Icon(Icons.arrow_right),
                                              onPressed: () {
                                                _controller.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.linear);
                                              }),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: MediaQuery.of(context).size.width / 7,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green[800],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: FittedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "FIND YOUR LOCAL FOOD BANK",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 200,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.white,
                                            hintText: 'Enter a search term'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FlatButton(
                                        color: Colors.amberAccent,
                                        onPressed: () {},
                                        child: Text("LOCATE"))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: MediaQuery.of(context).size.width / 7,
                          width: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "FIND YOUR LOCAL CLOTH BANK",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 200,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.white,
                                            hintText: 'Enter a search term'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FlatButton(
                                        color: Colors.amberAccent,
                                        onPressed: () {},
                                        child: Text("LOCATE"))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                  child: CarouselSlider.builder(
                      itemCount: imagesmission.length,
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
                                child: Image.asset(imagesmission[index],
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width)));
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2.3,
                        child: AspectRatio(
                          aspectRatio: _controllerweb2.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              VideoPlayer(_controllerweb2),
                              ClosedCaption(
                                  text: _controllerweb2.value.caption.text),
                              _PlayPauseOverlay(controller: _controllerweb2),
                              VideoProgressIndicator(_controllerweb2,
                                  allowScrubbing: true),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 3,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "WORKING TOGETHER TO HELP THE VULNERABLE",
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/wheels1.jpg"),
                    fit: BoxFit.fill,
                  )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 30),
                        child: Center(
                            child: Text(
                          "HELP SAVE LIVES TODAY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width / 6,
                              color: Colors.white,
                              child: Container(
                                height: MediaQuery.of(context).size.width / 6.5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/images/giveday.jpg",
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              40,
                                      width: MediaQuery.of(context).size.width /
                                          6.2,
                                      child: FittedBox(
                                        child: Text(
                                          "GIVE TODAY",
                                          style: TextStyle(
                                              color: Colors.green[200],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: FittedBox(
                                          child: Text(
                                            "Make a secure donation to the community",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: Center(
                                          child: Text(
                                            "Donate Now>>>",
                                            style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width / 6,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/givemont.png",
                                    colorBlendMode: BlendMode.color,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 40,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FittedBox(
                                      child: Text(
                                        "GIVE MONTHLY",
                                        style: TextStyle(
                                            color: Colors.green[200],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: FittedBox(
                                        child: Text(
                                          "Donate food,clothes or funds every month",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Center(
                                        child: Text(
                                          "Donate monthly>>>",
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width / 6,
                              color: Colors.white,
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/fundraise.png",
                                    colorBlendMode: BlendMode.color,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 40,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    child: FittedBox(
                                      child: Text(
                                        "FUND RAISE",
                                        style: TextStyle(
                                            color: Colors.green[200],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              40,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: FittedBox(
                                        child: Text(
                                          "Create a personal fundraising campaign",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Center(
                                        child: Text(
                                          "Learn more>>>",
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width / 6,
                              color: Colors.white,
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/volunteer.png",
                                    colorBlendMode: BlendMode.color,
                                    height:
                                        MediaQuery.of(context).size.width / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                  ),
                                  Text(
                                    "VOLUNTEER",
                                    style: TextStyle(
                                        color: Colors.green[200],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: FittedBox(
                                          child: Text(
                                            "Give your time and serve your community",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      //margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              40,
                                      width: MediaQuery.of(context).size.width /
                                          10,

                                      child: Center(
                                        child: Text(
                                          "Pledge to volunteer>>>",
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                            "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need .",
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
                                    height:
                                        MediaQuery.of(context).size.width / 4,
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
    ]);
  }
}

class Tabdesktop extends StatefulWidget {
  @override
  _TabdesktopState createState() => _TabdesktopState();
}

class _TabdesktopState extends State<Tabdesktop> {
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
  VideoPlayerController _controllervid;
  VideoPlayerController _controllerweb;
  VideoPlayerController _controllerweb2;
  FlickManager flickManager;

  final List<String> images = [
    'assets/images/banners3.jpg',
    'assets/images/bannerimage2.jpg',
    'assets/images/bannerimage3.jpg',
    'assets/images/bannerimage4.jpg',
    'assets/images/banners1.jpg',
    'assets/images/banners2.jpg',
    // 'https://www.pacificneuroscienceinstitute.org/wp-content/uploads/Essential-Tremor-March-2017-banner-bw-680x350.jpg',
    // 'https://humanity-inclusion.org.uk/sn_uploads/uk/page/inclusion-1280x720_0.jpg?maxw=1110',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  final List<String> imagesmission = [
    'assets/images/mission1.png',
    'assets/images/policy1.png',
    // 'https://image.shutterstock.com/image-photo/young-carer-giving-helping-hands-600w-546225832.jpg',
    // 'https://www.crisisaid.org.uk/wp-content/uploads/2020/03/Orphan-Fund-uganda-300x214.png',
    // 'https://www.compassion.com/Images/poverty-around-the-world_138895_1280x553.jpg',
    // 'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    // 'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  @override
  void initState() {
    _controllerweb2 = VideoPlayerController.asset(
      "assets/images/testimony.mp4",
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controllerweb2.addListener(() {
      setState(() {});
    });
    _controllerweb2.setLooping(true);
    _controllerweb2.initialize();
    _controllers = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    _controllerweb = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset("assets/images/testimony.mp4"),
    );
    _controllervid = VideoPlayerController.asset("assets/images/testimony.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  void dispose() {
    _controllerweb2.dispose();
    super.dispose();
    _controllervid.dispose();
    flickManager.dispose();
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
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 2.9);
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
    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Stack(children: [
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
            child: InteractiveViewer(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // ListView(shrinkWrap: true, children: [
                    //   Container(
                    //     margin: const EdgeInsets.only(top: 0),
                    //     child: Image.asset(
                    //       "assets/firstone.png",
                    //       width: MediaQuery.of(context).size.width * 1.5,
                    //       height: MediaQuery.of(context).size.width / 2,
                    //     ),
                    //   ),
                    // ]),
                    // CarouselSlider(
                    //   items: imageSliders,
                    //   options:
                    //       CarouselOptions(enlargeCenterPage: true, height: 200),
                    //   carouselController: _controller,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: RaisedButton(
                    //         onPressed: () => _controller.previousPage(),
                    //         child: Text('←'),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: RaisedButton(
                    //         onPressed: () => _controller.nextPage(),
                    //         child: Text('→'),
                    //       ),
                    //     ),
                    //     ...Iterable<int>.generate(imgList.length).map(
                    //       (int pageIndex) => Flexible(
                    //         child: RaisedButton(
                    //           onPressed: () =>
                    //               _controller.animateToPage(pageIndex),
                    //           child: Text("$pageIndex"),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                    //
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                CarouselSlider.builder(
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
                                                  fit: BoxFit.fill,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width)));
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green[800],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 1, right: 1),
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "FIND YOUR LOCAL FOOD BANK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: 200,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                fillColor: Colors.white,
                                                hintText:
                                                    'Enter a search term'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FlatButton(
                                            color: Colors.amberAccent,
                                            onPressed: () {},
                                            child: Text("LOCATE"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black26,
                              height: MediaQuery.of(context).size.width / 7,
                              width: 1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "FIND YOUR LOCAL CLOTH BANK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: 200,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                fillColor: Colors.white,
                                                hintText:
                                                    'Enter a search term'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FlatButton(
                                            color: Colors.amberAccent,
                                            onPressed: () {},
                                            child: Text("LOCATE"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        padding:
                            const EdgeInsets.only(left: 5, top: 10, right: 5),
                        child: CarouselSlider.builder(
                            itemCount: imagesmission.length,
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
                                      child: Image.asset(imagesmission[index],
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width)));
                            }),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10, top: 10),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height / 3,
                    //   color: Colors.grey[200],
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: MediaQuery.of(context).size.width / 2.5,
                    //         height: MediaQuery.of(context).size.height / 3,
                    //         ch
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.grey[200],
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2.3,
                            child: AspectRatio(
                              aspectRatio: _controllerweb2.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  VideoPlayer(_controllerweb2),
                                  ClosedCaption(
                                      text: _controllerweb2.value.caption.text),
                                  _PlayPauseOverlay(
                                      controller: _controllerweb2),
                                  VideoProgressIndicator(_controllerweb2,
                                      allowScrubbing: true),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 2.5,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "WORKING TOGETHER TO HELP THE VULNERABLE",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "The NCGI Network is a poverty-relief organization.Found in 2019 as a partnership between Nigeria and the world,focusing solely on the elderly,widows and more vulnerable groups",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/wheels1.jpg"),
                        fit: BoxFit.cover,
                      )),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 30),
                            child: Center(
                                child: Text(
                              "HELP SAVE LIVES TODAY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  color: Colors.white,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/giveday.jpg",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6.2,
                                          child: FittedBox(
                                            child: Text(
                                              "GIVE TODAY",
                                              style: TextStyle(
                                                  color: Colors.green[200],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/givemont.png",
                                        colorBlendMode: BlendMode.color,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        child: FittedBox(
                                          child: Text(
                                            "GIVE MONTHLY",
                                            style: TextStyle(
                                                color: Colors.green[200],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 6.3,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/fundraise.png",
                                        colorBlendMode: BlendMode.color,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        child: FittedBox(
                                          child: Text(
                                            "RAISE FUNDS",
                                            style: TextStyle(
                                                color: Colors.green[200],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/volunteer.png",
                                        colorBlendMode: BlendMode.color,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        child: FittedBox(
                                          child: Text(
                                            "VOLUNTEER",
                                            style: TextStyle(
                                                color: Colors.green[200],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
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
                                                        "open", [""]);
                                                  },
                                                  child: GestureDetector(
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
                                              "NCGI works in collaboration with African communities, the private sector and donors, bringing together the resources to achieve a productive society and a common goal. We place communities at the center of our development activities because we believe that Africans can appropriately exploit their resources, care and protect neglected elderly people, people living with disabilities and widows and widowers in need.",
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
      ]),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/Butterfly-209.mp4');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
}
