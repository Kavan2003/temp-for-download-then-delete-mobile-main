import 'package:flutter/material.dart';

class LeadCard extends StatelessWidget {
  const LeadCard({Key? key}) : super(key: key);
  final double fem = 1;
  final double ffem = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // leadpanelsnewleadPRf (110:7645)
        margin: EdgeInsets.fromLTRB(0 * fem, 30 * fem, 0 * fem, 16 * fem),
        width: 350 * fem,
        height: 390 * fem,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(11 * fem),
          boxShadow: [
            BoxShadow(
              color: Color(0xffdbe3ed),
              offset: Offset(3 * fem, 3 * fem),
              blurRadius: 5 * fem,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              // autogroupfzdo2jX (K3wAmnADCv1HfXuYzifZdo)
              left: 0 * fem,
              top: 0 * fem,
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(14 * fem, 16 * fem, 0 * fem, 10 * fem),
                width: 343 * fem,
                height: 115 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupk7zmicM (K3w9sJfeRpRDsSP1Pvk7zm)
                      width: 350,
                      height: 16 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame52184rCm (I110:7645;110:6413;9:617)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 222 * fem, 0 * fem),
                            width: 58 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff294e95),
                              borderRadius: BorderRadius.circular(100 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'New Lead',
                                style: TextStyle(
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2 * ffem / fem,
                                  color: Color(0xffeaeef5),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Icon(
                                  Icons.call,
                                  size: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    Container(
                      // hashconnectintegratedservicepv (I110:7645;1:751)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 33 * fem, 0 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 277 * fem,
                      ),
                      child: Text(
                        'Hash Connect Integrated Service Pvt Ltd.',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff1e0013),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    Container(
                      // maincomponentfZX (I110:7645;14:7002)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 29 * fem, 0 * fem),
                      height: 14 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            // mdmid123456o9w (I110:7645;14:7002;14:6986)
                            'MDM ID: 123456',
                            style: TextStyle(
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2175 * ffem / fem,
                              color: Color(0xff4e444e),
                            ),
                          ),
                          SizedBox(
                            width: 8 * fem,
                          ),
                          Container(
                            // group427319472KPB (I110:7645;14:7002;14:6987)
                            padding: EdgeInsets.fromLTRB(
                                8 * fem, 1 * fem, 0 * fem, 0 * fem),
                            height: double.infinity,
                            child: Text(
                              'Opportunity ID : 12345678',
                              style: TextStyle(
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff4e444e),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8 * fem,
                          ),
                          Container(
                            // group427319473op9 (I110:7645;14:7002;14:6990)
                            padding: EdgeInsets.fromLTRB(
                                8 * fem, 1 * fem, 0 * fem, 0 * fem),
                            height: double.infinity,
                            child: Text(
                              'Notes: 3',
                              style: TextStyle(
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff294e95),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // line367igD (I110:7645;1:779)
              left: 0 * fem,
              top: 115 * fem,
              child: Align(
                child: SizedBox(
                  width: 346 * fem,
                  height: 0.3 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffaba8b1),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // autogroupvqzpe45 (K3wAKxZuEfHfjYsQp3VqZP)
              left: -1 * fem,
              top: 349 * fem,
              child: Align(
                child: SizedBox(
                    width: 344 * fem,
                    height: 0.5 * fem,
                    child: Icon(Icons.linked_camera)),
              ),
            ),
            Positioned(
              // autogroupaxa9LxV (K3wB7gki2b3SUCq2dmAxA9)
              left: 0 * fem,
              top: 115.3000000119 * fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    14 * fem, 10.7 * fem, 14 * fem, 12 * fem),
                width: 343 * fem,
                height: 233.7 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupqcwrFJm (K3wA4oLVb9KRkQq2o1qCWR)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 9 * fem, 12 * fem),
                      height: 35 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // labelinputNeH (I110:7645;13:2022)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 47 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // ueD (I110:7645;13:2022;13:1632)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                  child: Text(
                                    '3 May 2023',
                                    style: TextStyle(
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ),
                                Text(
                                  // leadidRsT (I110:7645;13:2022;13:1786)
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xff4e444e),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // labelinputB5w (I110:7645;13:2179)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 38 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // uXj (I110:7645;13:2179;13:1632)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                  child: Text(
                                    '12345678',
                                    style: TextStyle(
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ),
                                Text(
                                  // leadid2sF (I110:7645;13:2179;13:1786)
                                  'HC Lead ID',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xff4e444e),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // labelinputBVF (I110:7645;13:2261)
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // jWm (I110:7645;13:2261;13:1632)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                  child: Text(
                                    'Tele Doon',
                                    style: TextStyle(
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ),
                                Text(
                                  // leadid43F (I110:7645;13:2261;13:1786)
                                  'Source Name',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xff4e444e),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group427319492bos (I110:7645;110:2416)
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 12 * fem, 0 * fem, 13 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // leaddetailsJiH (I110:7645;110:2420)
                            margin: EdgeInsets.fromLTRB(
                                12 * fem, 0 * fem, 0 * fem, 5 * fem),
                            child: Text(
                              'Lead Details',
                              style: TextStyle(
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff1e0013),
                              ),
                            ),
                          ),
                          Container(
                            // autogroupcj7xdEm (K3wBXktw3CqiwX1pS1cJ7X)
                            margin: EdgeInsets.fromLTRB(
                                12 * fem, 0 * fem, 12 * fem, 1 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  // vinodkumarMAm (I110:7645;110:2418)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 152 * fem, 3 * fem),
                                  child: Text(
                                    'Vinod Kumar',
                                    style: TextStyle(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2175 * ffem / fem,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ),
                                Container(
                                    // group427319467rNR (I110:7645;110:2425)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    width: 16 * fem,
                                    height: 16 * fem,
                                    child: Icon(Icons.call)),
                                Container(
                                    // twitterkih (I110:7645;110:2422)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                    width: 16 * fem,
                                    height: 16 * fem,
                                    child: Icon(Icons.call)),
                              ],
                            ),
                          ),
                          Container(
                            // vicepresidenttechnologybangalo (I110:7645;110:2419)
                            margin: EdgeInsets.fromLTRB(
                                12 * fem, 0 * fem, 0 * fem, 10 * fem),
                            child: Text(
                              'Vice President, Technology, Bangalore.',
                              style: TextStyle(
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w300,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff4e444e),
                              ),
                            ),
                          ),
                          Container(
                            // line370BZ7 (I110:7645;110:2421)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 6.7 * fem),
                            width: 313 * fem,
                            height: 0.3 * fem,
                            decoration: BoxDecoration(
                              color: Color(0xffaba8b1),
                            ),
                          ),
                          Container(
                            // group427319491iJ9 (I110:7645;110:2431)
                            margin: EdgeInsets.fromLTRB(
                                12 * fem, 0 * fem, 0 * fem, 12 * fem),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // productsRyF (I110:7645;110:2432)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                  child: Text(
                                    'Products: ',
                                    style: TextStyle(
                                      fontSize: 10 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2175 * ffem / fem,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ),
                                Container(
                                    // laptopMM7 (I110:7645;110:2433)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Icon(Icons.call)),
                                Container(
                                    // tablet52D (I110:7645;110:2434)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Icon(Icons.call)),
                                Container(
                                    // smartdevicesaUm (I110:7645;110:2435)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Icon(Icons.call)),
                                Container(
                                    // workstationh3b (I110:7645;110:2436)
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Icon(Icons.call)),
                              ],
                            ),
                          ),
                          Container(
                            // autogrouphoa5ptu (K3wBgRKAYvpieTKkSbhoa5)
                            margin: EdgeInsets.fromLTRB(
                                12 * fem, 0 * fem, 29 * fem, 0 * fem),
                            width: double.infinity,
                            height: 35 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // labelinputkXf (I110:7645;110:2428)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 72 * fem, 0 * fem),
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // gw7 (I110:7645;110:2428;13:1632)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                        child: Text(
                                          '100',
                                          style: TextStyle(
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3333333333 * ffem / fem,
                                            color: Color(0xff1e0013),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // leadid1yP (I110:7645;110:2428;13:1786)
                                        'Units',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xff4e444e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // labelinputZzu (I110:7645;110:2429)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 47 * fem, 0 * fem),
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // Wv9 (I110:7645;110:2429;13:1632)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                        child: Text(
                                          '\$200,000',
                                          style: TextStyle(
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3333333333 * ffem / fem,
                                            color: Color(0xff1e0013),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // leadidT4h (I110:7645;110:2429;13:1786)
                                        'Budget',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xff4e444e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // labelinputQVj (I110:7645;110:2430)
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // y33 (I110:7645;110:2430;13:1632)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                        child: Text(
                                          '0-1 month',
                                          style: TextStyle(
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3333333333 * ffem / fem,
                                            color: Color(0xff1e0013),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // leadidgTF (I110:7645;110:2430;13:1786)
                                        'Timeframe',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xff4e444e),
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
                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupzkgmCwP (K3wATsWPCFjX6mfuWjZkgM)
              left: 14 * fem,
              top: 362 * fem,
              child: Container(
                width: 304 * fem,
                height: 16 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // actionbutton1tpD (I110:7645;27:2267)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 33 * fem, 0 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              // addnoteQGm (I110:7645;27:2267;27:1683)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 3 * fem, 0 * fem),
                              width: 16 * fem,
                              height: 16 * fem,
                              child: Icon(Icons.note_add_outlined)),
                          Text(
                            // addnoteKed (I110:7645;27:2267;27:1682)
                            'Add Note',
                            style: TextStyle(
                              fontSize: 8 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2175 * ffem / fem,
                              color: Color(0xff4e444e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // actionbutton1ruT (I110:7645;27:2632)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 32 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          1.33 * fem, 1.33 * fem, 0 * fem, 1.33 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              // editmmX (I110:7645;27:2632;27:1683)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 4.33 * fem, 0 * fem),
                              width: 13.33 * fem,
                              height: 13.33 * fem,
                              child: Icon(Icons.edit)),
                          Container(
                            // addnoteVBj (I110:7645;27:2632;27:1682)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 8 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff4e444e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // actionbutton1oy7 (I110:7645;27:3294)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 37 * fem, 0 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              // whatsappMUq (I110:7645;27:3294;27:1683)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 3 * fem, 0 * fem),
                              width: 16 * fem,
                              height: 16 * fem,
                              child: Icon(Icons.call)),
                          Text(
                            // addnoteH7b (I110:7645;27:3294;27:1682)
                            'Whatsapp',
                            style: TextStyle(
                              fontSize: 8 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2175 * ffem / fem,
                              color: Color(0xff4e444e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // actionbutton12qs (I110:7645;27:3491)
                      padding: EdgeInsets.fromLTRB(
                          2 * fem, 2 * fem, 0 * fem, 2 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              // callMt9 (I110:7645;27:3491;27:1683)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5 * fem, 0 * fem),
                              width: 12 * fem,
                              height: 12 * fem,
                              child: Icon(Icons.call)),
                          Container(
                            // addnotefdw (I110:7645;27:3491;27:1682)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: Text(
                              'Call',
                              style: TextStyle(
                                fontSize: 8 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Color(0xff4e444e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
