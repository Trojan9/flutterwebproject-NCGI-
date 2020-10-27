import 'dart:ui';
import 'dart:js' as js;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:ngo/main.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

bool filtered = true;

class Volunteer extends StatefulWidget {
  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 1200) {
        return Volunteerdesktop();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return InteractiveViewer(child: Volunteertab());
      } else {
        return InteractiveViewer(child: Volunteerphone());
      }
    });
  }
}

class Volunteerdesktop extends StatefulWidget {
  @override
  _VolunteerdesktopState createState() => _VolunteerdesktopState();
}

class _VolunteerdesktopState extends State<Volunteerdesktop> {
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

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              controller: _controllers,
              child: Column(
                children: [
                  Container(
                      color: Colors.black,
                      padding: const EdgeInsets.only(left: 200, right: 200),
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3.8,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            margin: const EdgeInsets.only(left: 80, right: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  margin: const EdgeInsets.only(top: 0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Builder(builder: (context) {
                                      return Center(
                                        child: Image.asset(
                                          "assets/images/logo.jpg",
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          // fit: BoxFit.fill,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  //alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Text(
                                    "VOLUNTEER TODAY",
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
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.1,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "\tOur social responsibility is only possible due to our dedicated volunteers coming out voluntarily to assist .That’s why NCGI  provides community service and volunteer opportunities for anyone looking for ways to assist the impoverished and the old throughout the world.",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "You can join our NCGI Support Volunteer team or join our development efforts and social commitments team.\n",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "NCGI Support Volunteer\n",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\tNCGI Support Volunteer is an individual passionate about developmental issues and are willing to go the extra mile to bring relief to individuals, families or group within their community.\n\n\tIndividuals within a community who chooses to register with NCGI  as Support Volunteer to liaise with our charity organization to support programs and projects within the local areas or other locations that may be assigned by NCGI.\n",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "NCGI Support Volunteer operating within the guidelines and operational policy of NGCI may\n",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\t\u2022 Organize and coordinate local activities and event in support of formally assigned and approved \n\tprogram for NCGI\n\t\u2022 Organize fund raising events and source support for local programs approved by NCGI\n\t\u2022 Write and review articles on projects implemented within local community\n\t\u2022 Recommend individuals or group for project funding through NCGI program\n\t\u2022 Promote NCGI activities and programs through social media and other communication channels\n\t\u2022 Provide other services that may be requested by NCGI in the execution of its goals and objects",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "APPLY TO BECOME A NCGI SUPPORT VOLUNTEER",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Image.asset("assets/images/volunteer1.jpg",
                                fit: BoxFit.fill),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 10)),
                              child: Center(
                                  child: Text("VOLUNTEER WITH NCGI",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 35))),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    color: Colors.white,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          // prefixText: "\u{20A6}",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          fillColor: Colors.black,
                                          hintText: "First Name*"),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    color: Colors.white,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          // prefixText: "\u{20A6}",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          fillColor: Colors.black,
                                          hintText: " Last Name*"),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          // prefixText: "\u{20A6}",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          fillColor: Colors.black,
                                          hintText: " Pronouns*"),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          // prefixText: "\u{20A6}",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          fillColor: Colors.black,
                                          hintText: " Postal Code*"),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.white,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              // prefixText: "\u{20A6}",
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.white)),
                                              fillColor: Colors.black,
                                              hintText: "Email*"),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CountryPickerDropdown(
                                              initialValue: 'NG',
                                              itemBuilder: _buildDropdownItem,
                                              itemFilter: filtered
                                                  ? (c) => [
                                                        'NG',
                                                        'DE',
                                                        'GB',
                                                        'CN',
                                                        'US',
                                                        'UM',
                                                        'ES',
                                                        'IT',
                                                        'AF',
                                                        'AL',
                                                        'DZ',
                                                        'AS',
                                                        'AD',
                                                        'AO',
                                                        'AQ',
                                                        'AG',
                                                        'AR',
                                                        'AM',
                                                        'AW',
                                                        'AU',
                                                        'AT',
                                                        'AZ',
                                                        'BS',
                                                        'BH',
                                                        'BD',
                                                        'BB',
                                                        'BY',
                                                        'BE',
                                                        'BZ',
                                                        'BJ',
                                                        'BM',
                                                        'BT',
                                                        'BO',
                                                        'BA',
                                                        'BW',
                                                        'BV',
                                                        'BR',
                                                        'IO',
                                                        'BN',
                                                        'BG',
                                                        'BF',
                                                        'BI',
                                                        'KH',
                                                        'CM',
                                                        'CA',
                                                        'CV',
                                                        'KY',
                                                        'CF',
                                                        'TD',
                                                        'CL',
                                                        'CN',
                                                        'CX',
                                                        'CC',
                                                        'CO',
                                                        'KM',
                                                        'CG',
                                                        'CD',
                                                        'CK',
                                                        'CR',
                                                        'CI',
                                                        'HR',
                                                        'CU',
                                                        'CY',
                                                        'CZ',
                                                        'DK',
                                                        'DJ',
                                                        'DM',
                                                        'DO',
                                                        'EC',
                                                        'EG',
                                                        'SV',
                                                        'GQ',
                                                        'ER',
                                                        'EE',
                                                        'ET',
                                                        'FK',
                                                        'FO',
                                                        'FJ',
                                                        'FI',
                                                        'FR',
                                                        'GF',
                                                        'PF',
                                                        'TF',
                                                        'GA',
                                                        'GM',
                                                        'GE',
                                                        'DE',
                                                        'GH',
                                                        'GI',
                                                        'GR',
                                                        'GL',
                                                        'GD',
                                                        'GP',
                                                        'GU',
                                                        'GT',
                                                        'GN',
                                                        'GW',
                                                        'GY',
                                                        'HT',
                                                        'HM',
                                                        'HN',
                                                        'HK',
                                                        'HU',
                                                        'IS',
                                                        'IN',
                                                        'ID',
                                                        'IR',
                                                        'IQ',
                                                        "IE",
                                                        'IL',
                                                        'IT',
                                                        'JM',
                                                        'JP',
                                                        'JO',
                                                        'KZ',
                                                        'KE',
                                                        'KI',
                                                        'KP',
                                                        'KR',
                                                        'KW',
                                                        'KG',
                                                        'LA',
                                                        'LV',
                                                        'LB',
                                                        'LS',
                                                        'LR',
                                                        'LY',
                                                        'LI',
                                                        'LT',
                                                        'LU',
                                                        "MO",
                                                        'MK',
                                                        'MG',
                                                        'MW',
                                                        'MY',
                                                        'MV',
                                                        'ML',
                                                        'MT',
                                                        'MH',
                                                        'MQ',
                                                        'MR',
                                                        'MU',
                                                        'YT',
                                                        'MX',
                                                        'FM',
                                                        'MD',
                                                        'MN',
                                                        'MS',
                                                        'MA',
                                                        'MZ',
                                                        'MM',
                                                        'NA',
                                                        'NR',
                                                        'NP',
                                                        'NL',
                                                        'AN',
                                                        'NC',
                                                        'NZ',
                                                        'NI',
                                                        'NE',
                                                        'NG',
                                                        'NU',
                                                        'NF',
                                                        'MP',
                                                        'NO',
                                                        'OM',
                                                        'PK',
                                                        'PW',
                                                        'PS',
                                                        'PA',
                                                        'PG',
                                                        'PY',
                                                        'PE',
                                                        'PH',
                                                        'PN',
                                                        'PL',
                                                        'PR',
                                                        'QA',
                                                        'RE',
                                                        'RO',
                                                        'RU',
                                                        'RW',
                                                        'SH',
                                                        'KN',
                                                        'LC',
                                                        'PM',
                                                        'VC',
                                                        'WS',
                                                        'SM',
                                                        'ST',
                                                        'SA',
                                                        'SN',
                                                        'CS',
                                                        'SC',
                                                        'SL',
                                                        'SG',
                                                        'SK',
                                                        'SI',
                                                        'SB',
                                                        'SO',
                                                        'ZA',
                                                        'GS',
                                                        'ES',
                                                        'LK',
                                                        'SD',
                                                        'SR',
                                                        'SJ',
                                                        'SZ',
                                                        'SE',
                                                        'CH',
                                                        'SY',
                                                        'TW',
                                                        'TJ',
                                                        'TZ',
                                                        'TH',
                                                        'TL',
                                                        'TG',
                                                        'TK',
                                                        'TO',
                                                        'TT',
                                                        'TN',
                                                        'TR',
                                                        'TM',
                                                        'TC',
                                                        'TV',
                                                        'UG',
                                                        'UA',
                                                        'AE',
                                                        'GB',
                                                        'US',
                                                        'UM',
                                                        'UY',
                                                        'UZ',
                                                        'VU',
                                                        'VE',
                                                        'VN',
                                                        'VG',
                                                        'VI',
                                                        'WF',
                                                        'EH',
                                                        'YE',
                                                        "ZM",
                                                        "ZW"
                                                      ].contains(c.isoCode)
                                                  : null,
                                              priorityList: [
                                                CountryPickerUtils
                                                    .getCountryByIsoCode('GB'),
                                                CountryPickerUtils
                                                    .getCountryByIsoCode('CN'),
                                              ],
                                              sortComparator:
                                                  (Country a, Country b) => a
                                                      .isoCode
                                                      .compareTo(b.isoCode),
                                              onValuePicked: (Country country) {
                                                print("${country.name}");
                                                //perform a function here onpick of a new value
                                              },
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.5,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    // prefixText: "\u{20A6}",

                                                    fillColor: Colors.black,
                                                    hintText: " PhoneNo*"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Colors.red,
                                  child: Text("SUBMIT"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ])),
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
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
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
                                      width: MediaQuery.of(context).size.width /
                                          20,
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
            )),
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

class Volunteertab extends StatefulWidget {
  @override
  _VolunteertabState createState() => _VolunteertabState();
}

class _VolunteertabState extends State<Volunteertab> {
  ScrollController _controllers;
  bool monthly = false;
  bool paymenttype = false;
  var button;
  var other = "\u{20A6}" + ' Other';
  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controllers.position.moveTo(dragUpdate.globalPosition.dy * 3);
    });
  }

  @override
  void initState() {
    _controllers = ScrollController();
    super.initState();
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                controller: _controllers,
                child: Column(
                  children: [
                    Container(
                        color: Colors.black,
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Column(children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 3.8,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    margin: const EdgeInsets.only(top: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Builder(builder: (context) {
                                        return Center(
                                          child: Image.asset(
                                            "assets/images/logo.jpg",
                                            alignment: Alignment.topCenter,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            // fit: BoxFit.fill,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    //alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.only(top: 90),
                                    child: Text(
                                      "VOLUNTEER TODAY",
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
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1.4,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\tOur social responsibility is only possible due to our dedicated volunteers coming out voluntarily to assist .That’s why NCGI  provides community service and volunteer opportunities for anyone looking for ways to assist the impoverished and the old throughout the world.",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "You can join our NCGI Support Volunteer team or join our development efforts and social commitments team.\n",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "NCGI Support Volunteer\n",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\tNCGI Support Volunteer is an individual passionate about developmental issues and are willing to go the extra mile to bring relief to individuals, families or group within their community.\n\n\tIndividuals within a community who chooses to register with NCGI  as Support Volunteer to liaise with our charity organization to support programs and projects within the local areas or other locations that may be assigned by NCGI.\n",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "NCGI Support Volunteer operating within the guidelines and operational policy of NGCI may\n",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\t\u2022 Organize and coordinate local activities and event in support of formally assigned and approved \n\tprogram for NCGI\n\t\u2022 Organize fund raising events and source support for local programs approved by NCGI\n\t\u2022 Write and review articles on projects implemented within local community\n\t\u2022 Recommend individuals or group for project funding through NCGI program\n\t\u2022 Promote NCGI activities and programs through social media and other communication channels\n\t\u2022 Provide other services that may be requested by NCGI in the execution of its goals and objects",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "APPLY TO BECOME A NCGI SUPPORT VOLUNTEER",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Image.asset("assets/images/volunteer1.jpg",
                                  fit: BoxFit.fill),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.height / 2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 10)),
                                child: Center(
                                    child: Text("VOLUNTEER WITH NCGI",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35))),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            // prefixText: "\u{20A6}",
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            fillColor: Colors.black,
                                            hintText: "First Name*"),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            // prefixText: "\u{20A6}",
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            fillColor: Colors.black,
                                            hintText: " Last Name*"),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            // prefixText: "\u{20A6}",
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            fillColor: Colors.black,
                                            hintText: " Pronouns*"),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            // prefixText: "\u{20A6}",
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            fillColor: Colors.black,
                                            hintText: " Postal Code*"),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          color: Colors.white,
                                          child: TextField(
                                            decoration: InputDecoration(
                                                // prefixText: "\u{20A6}",
                                                border: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.white)),
                                                fillColor: Colors.black,
                                                hintText: "Email*"),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CountryPickerDropdown(
                                                initialValue: 'NG',
                                                itemBuilder: _buildDropdownItem,
                                                itemFilter: filtered
                                                    ? (c) => [
                                                          'NG',
                                                          'DE',
                                                          'GB',
                                                          'CN',
                                                          'US',
                                                          'UM',
                                                          'ES',
                                                          'IT',
                                                          'AF',
                                                          'AL',
                                                          'DZ',
                                                          'AS',
                                                          'AD',
                                                          'AO',
                                                          'AQ',
                                                          'AG',
                                                          'AR',
                                                          'AM',
                                                          'AW',
                                                          'AU',
                                                          'AT',
                                                          'AZ',
                                                          'BS',
                                                          'BH',
                                                          'BD',
                                                          'BB',
                                                          'BY',
                                                          'BE',
                                                          'BZ',
                                                          'BJ',
                                                          'BM',
                                                          'BT',
                                                          'BO',
                                                          'BA',
                                                          'BW',
                                                          'BV',
                                                          'BR',
                                                          'IO',
                                                          'BN',
                                                          'BG',
                                                          'BF',
                                                          'BI',
                                                          'KH',
                                                          'CM',
                                                          'CA',
                                                          'CV',
                                                          'KY',
                                                          'CF',
                                                          'TD',
                                                          'CL',
                                                          'CN',
                                                          'CX',
                                                          'CC',
                                                          'CO',
                                                          'KM',
                                                          'CG',
                                                          'CD',
                                                          'CK',
                                                          'CR',
                                                          'CI',
                                                          'HR',
                                                          'CU',
                                                          'CY',
                                                          'CZ',
                                                          'DK',
                                                          'DJ',
                                                          'DM',
                                                          'DO',
                                                          'EC',
                                                          'EG',
                                                          'SV',
                                                          'GQ',
                                                          'ER',
                                                          'EE',
                                                          'ET',
                                                          'FK',
                                                          'FO',
                                                          'FJ',
                                                          'FI',
                                                          'FR',
                                                          'GF',
                                                          'PF',
                                                          'TF',
                                                          'GA',
                                                          'GM',
                                                          'GE',
                                                          'DE',
                                                          'GH',
                                                          'GI',
                                                          'GR',
                                                          'GL',
                                                          'GD',
                                                          'GP',
                                                          'GU',
                                                          'GT',
                                                          'GN',
                                                          'GW',
                                                          'GY',
                                                          'HT',
                                                          'HM',
                                                          'HN',
                                                          'HK',
                                                          'HU',
                                                          'IS',
                                                          'IN',
                                                          'ID',
                                                          'IR',
                                                          'IQ',
                                                          "IE",
                                                          'IL',
                                                          'IT',
                                                          'JM',
                                                          'JP',
                                                          'JO',
                                                          'KZ',
                                                          'KE',
                                                          'KI',
                                                          'KP',
                                                          'KR',
                                                          'KW',
                                                          'KG',
                                                          'LA',
                                                          'LV',
                                                          'LB',
                                                          'LS',
                                                          'LR',
                                                          'LY',
                                                          'LI',
                                                          'LT',
                                                          'LU',
                                                          "MO",
                                                          'MK',
                                                          'MG',
                                                          'MW',
                                                          'MY',
                                                          'MV',
                                                          'ML',
                                                          'MT',
                                                          'MH',
                                                          'MQ',
                                                          'MR',
                                                          'MU',
                                                          'YT',
                                                          'MX',
                                                          'FM',
                                                          'MD',
                                                          'MN',
                                                          'MS',
                                                          'MA',
                                                          'MZ',
                                                          'MM',
                                                          'NA',
                                                          'NR',
                                                          'NP',
                                                          'NL',
                                                          'AN',
                                                          'NC',
                                                          'NZ',
                                                          'NI',
                                                          'NE',
                                                          'NG',
                                                          'NU',
                                                          'NF',
                                                          'MP',
                                                          'NO',
                                                          'OM',
                                                          'PK',
                                                          'PW',
                                                          'PS',
                                                          'PA',
                                                          'PG',
                                                          'PY',
                                                          'PE',
                                                          'PH',
                                                          'PN',
                                                          'PL',
                                                          'PR',
                                                          'QA',
                                                          'RE',
                                                          'RO',
                                                          'RU',
                                                          'RW',
                                                          'SH',
                                                          'KN',
                                                          'LC',
                                                          'PM',
                                                          'VC',
                                                          'WS',
                                                          'SM',
                                                          'ST',
                                                          'SA',
                                                          'SN',
                                                          'CS',
                                                          'SC',
                                                          'SL',
                                                          'SG',
                                                          'SK',
                                                          'SI',
                                                          'SB',
                                                          'SO',
                                                          'ZA',
                                                          'GS',
                                                          'ES',
                                                          'LK',
                                                          'SD',
                                                          'SR',
                                                          'SJ',
                                                          'SZ',
                                                          'SE',
                                                          'CH',
                                                          'SY',
                                                          'TW',
                                                          'TJ',
                                                          'TZ',
                                                          'TH',
                                                          'TL',
                                                          'TG',
                                                          'TK',
                                                          'TO',
                                                          'TT',
                                                          'TN',
                                                          'TR',
                                                          'TM',
                                                          'TC',
                                                          'TV',
                                                          'UG',
                                                          'UA',
                                                          'AE',
                                                          'GB',
                                                          'US',
                                                          'UM',
                                                          'UY',
                                                          'UZ',
                                                          'VU',
                                                          'VE',
                                                          'VN',
                                                          'VG',
                                                          'VI',
                                                          'WF',
                                                          'EH',
                                                          'YE',
                                                          "ZM",
                                                          "ZW"
                                                        ].contains(c.isoCode)
                                                    : null,
                                                priorityList: [
                                                  CountryPickerUtils
                                                      .getCountryByIsoCode(
                                                          'GB'),
                                                  CountryPickerUtils
                                                      .getCountryByIsoCode(
                                                          'CN'),
                                                ],
                                                sortComparator:
                                                    (Country a, Country b) => a
                                                        .isoCode
                                                        .compareTo(b.isoCode),
                                                onValuePicked:
                                                    (Country country) {
                                                  print("${country.name}");
                                                  //perform a function here onpick of a new value
                                                },
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      // prefixText: "\u{20A6}",

                                                      fillColor: Colors.black,
                                                      hintText: " PhoneNo*"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    child: Text("SUBMIT"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ])),
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
                ))),
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

class Volunteerphone extends StatefulWidget {
  @override
  _VolunteerphoneState createState() => _VolunteerphoneState();
}

class _VolunteerphoneState extends State<Volunteerphone> {
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

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada = Matrix4.identity();
  double _scale = 1.0;
  double _previousscale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            // ignore: missing_required_param
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
            child: Column(
              children: [
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.8,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          margin: const EdgeInsets.only(left: 10, right: 10),
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
                                            MediaQuery.of(context).size.width /
                                                4,
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
                                  "VOLUNTEER TODAY",
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
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2.2,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "\tOur social responsibility is only possible due to our dedicated volunteers coming out voluntarily to assist .That’s why NCGI  provides community service and volunteer opportunities for anyone looking for ways to assist the impoverished and the old throughout the world.",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "You can join our NCGI Support Volunteer team or join our development efforts and social commitments team.\n",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "NCGI Support Volunteer\n",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\tNCGI Support Volunteer is an individual passionate about developmental issues and are willing to go the extra mile to bring relief to individuals, families or group within their community.\n\n\tIndividuals within a community who chooses to register with NCGI  as Support Volunteer to liaise with our charity organization to support programs and projects within the local areas or other locations that may be assigned by NCGI.\n",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "NCGI Support Volunteer operating within the guidelines and operational policy of NGCI may\n",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\t\u2022 Organize and coordinate local activities and event in support of formally assigned and approved \n\tprogram for NCGI\n\t\u2022 Organize fund raising events and source support for local programs approved by NCGI\n\t\u2022 Write and review articles on projects implemented within local community\n\t\u2022 Recommend individuals or group for project funding through NCGI program\n\t\u2022 Promote NCGI activities and programs through social media and other communication channels\n\t\u2022 Provide other services that may be requested by NCGI in the execution of its goals and objects",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "APPLY TO BECOME A NCGI SUPPORT VOLUNTEER",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Image.asset("assets/images/volunteer1.jpg",
                              fit: BoxFit.fill),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 10)),
                            child: Center(
                                child: Text("VOLUNTEER WITH NCGI",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35))),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: TextField(
                                decoration: InputDecoration(
                                    // prefixText: "\u{20A6}",
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                    fillColor: Colors.black,
                                    hintText: "First Name*"),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: TextField(
                                decoration: InputDecoration(
                                    // prefixText: "\u{20A6}",
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                    fillColor: Colors.black,
                                    hintText: " Last Name*"),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        // prefixText: "\u{20A6}",
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white)),
                                        fillColor: Colors.black,
                                        hintText: " Pronouns*"),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        // prefixText: "\u{20A6}",
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white)),
                                        fillColor: Colors.black,
                                        hintText: " Postal Code*"),
                                  ),
                                )
                              ],
                            ),
                            Column(children: [
                              SizedBox(height: 10),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            // prefixText: "\u{20A6}",
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            fillColor: Colors.black,
                                            hintText: "Email*"),
                                      ),
                                    ),
                                  ]),
                            ]),
                            Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CountryPickerDropdown(
                                        initialValue: 'NG',
                                        itemBuilder: _buildDropdownItem,
                                        itemFilter: filtered
                                            ? (c) => [
                                                  'NG',
                                                  'DE',
                                                  'GB',
                                                  'CN',
                                                  'US',
                                                  'UM',
                                                  'ES',
                                                  'IT',
                                                  'AF',
                                                  'AL',
                                                  'DZ',
                                                  'AS',
                                                  'AD',
                                                  'AO',
                                                  'AQ',
                                                  'AG',
                                                  'AR',
                                                  'AM',
                                                  'AW',
                                                  'AU',
                                                  'AT',
                                                  'AZ',
                                                  'BS',
                                                  'BH',
                                                  'BD',
                                                  'BB',
                                                  'BY',
                                                  'BE',
                                                  'BZ',
                                                  'BJ',
                                                  'BM',
                                                  'BT',
                                                  'BO',
                                                  'BA',
                                                  'BW',
                                                  'BV',
                                                  'BR',
                                                  'IO',
                                                  'BN',
                                                  'BG',
                                                  'BF',
                                                  'BI',
                                                  'KH',
                                                  'CM',
                                                  'CA',
                                                  'CV',
                                                  'KY',
                                                  'CF',
                                                  'TD',
                                                  'CL',
                                                  'CN',
                                                  'CX',
                                                  'CC',
                                                  'CO',
                                                  'KM',
                                                  'CG',
                                                  'CD',
                                                  'CK',
                                                  'CR',
                                                  'CI',
                                                  'HR',
                                                  'CU',
                                                  'CY',
                                                  'CZ',
                                                  'DK',
                                                  'DJ',
                                                  'DM',
                                                  'DO',
                                                  'EC',
                                                  'EG',
                                                  'SV',
                                                  'GQ',
                                                  'ER',
                                                  'EE',
                                                  'ET',
                                                  'FK',
                                                  'FO',
                                                  'FJ',
                                                  'FI',
                                                  'FR',
                                                  'GF',
                                                  'PF',
                                                  'TF',
                                                  'GA',
                                                  'GM',
                                                  'GE',
                                                  'DE',
                                                  'GH',
                                                  'GI',
                                                  'GR',
                                                  'GL',
                                                  'GD',
                                                  'GP',
                                                  'GU',
                                                  'GT',
                                                  'GN',
                                                  'GW',
                                                  'GY',
                                                  'HT',
                                                  'HM',
                                                  'HN',
                                                  'HK',
                                                  'HU',
                                                  'IS',
                                                  'IN',
                                                  'ID',
                                                  'IR',
                                                  'IQ',
                                                  "IE",
                                                  'IL',
                                                  'IT',
                                                  'JM',
                                                  'JP',
                                                  'JO',
                                                  'KZ',
                                                  'KE',
                                                  'KI',
                                                  'KP',
                                                  'KR',
                                                  'KW',
                                                  'KG',
                                                  'LA',
                                                  'LV',
                                                  'LB',
                                                  'LS',
                                                  'LR',
                                                  'LY',
                                                  'LI',
                                                  'LT',
                                                  'LU',
                                                  "MO",
                                                  'MK',
                                                  'MG',
                                                  'MW',
                                                  'MY',
                                                  'MV',
                                                  'ML',
                                                  'MT',
                                                  'MH',
                                                  'MQ',
                                                  'MR',
                                                  'MU',
                                                  'YT',
                                                  'MX',
                                                  'FM',
                                                  'MD',
                                                  'MN',
                                                  'MS',
                                                  'MA',
                                                  'MZ',
                                                  'MM',
                                                  'NA',
                                                  'NR',
                                                  'NP',
                                                  'NL',
                                                  'AN',
                                                  'NC',
                                                  'NZ',
                                                  'NI',
                                                  'NE',
                                                  'NG',
                                                  'NU',
                                                  'NF',
                                                  'MP',
                                                  'NO',
                                                  'OM',
                                                  'PK',
                                                  'PW',
                                                  'PS',
                                                  'PA',
                                                  'PG',
                                                  'PY',
                                                  'PE',
                                                  'PH',
                                                  'PN',
                                                  'PL',
                                                  'PR',
                                                  'QA',
                                                  'RE',
                                                  'RO',
                                                  'RU',
                                                  'RW',
                                                  'SH',
                                                  'KN',
                                                  'LC',
                                                  'PM',
                                                  'VC',
                                                  'WS',
                                                  'SM',
                                                  'ST',
                                                  'SA',
                                                  'SN',
                                                  'CS',
                                                  'SC',
                                                  'SL',
                                                  'SG',
                                                  'SK',
                                                  'SI',
                                                  'SB',
                                                  'SO',
                                                  'ZA',
                                                  'GS',
                                                  'ES',
                                                  'LK',
                                                  'SD',
                                                  'SR',
                                                  'SJ',
                                                  'SZ',
                                                  'SE',
                                                  'CH',
                                                  'SY',
                                                  'TW',
                                                  'TJ',
                                                  'TZ',
                                                  'TH',
                                                  'TL',
                                                  'TG',
                                                  'TK',
                                                  'TO',
                                                  'TT',
                                                  'TN',
                                                  'TR',
                                                  'TM',
                                                  'TC',
                                                  'TV',
                                                  'UG',
                                                  'UA',
                                                  'AE',
                                                  'GB',
                                                  'US',
                                                  'UM',
                                                  'UY',
                                                  'UZ',
                                                  'VU',
                                                  'VE',
                                                  'VN',
                                                  'VG',
                                                  'VI',
                                                  'WF',
                                                  'EH',
                                                  'YE',
                                                  "ZM",
                                                  "ZW"
                                                ].contains(c.isoCode)
                                            : null,
                                        priorityList: [
                                          CountryPickerUtils
                                              .getCountryByIsoCode('GB'),
                                          CountryPickerUtils
                                              .getCountryByIsoCode('CN'),
                                        ],
                                        sortComparator:
                                            (Country a, Country b) =>
                                                a.isoCode.compareTo(b.isoCode),
                                        onValuePicked: (Country country) {
                                          print("${country.name}");
                                          //perform a function here onpick of a new value
                                        },
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              // prefixText: "\u{20A6}",

                                              fillColor: Colors.black,
                                              hintText: " PhoneNo*"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: RaisedButton(
                                onPressed: () {},
                                color: Colors.red,
                                child: Text("SUBMIT"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ])),
                SizedBox(
                  height: 20,
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
                                              width: 5,
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
                                              width: 5,
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
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
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
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
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
            ),
          ),
        )));
  }
}
