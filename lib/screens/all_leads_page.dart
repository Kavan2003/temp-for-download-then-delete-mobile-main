import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/constants/imageConstants.dart';
import 'package:lenovo_app/screens/Making_note.dart';
import 'package:lenovo_app/screens/filterScreen.dart';
import 'package:lenovo_app/screens/searchScreen.dart';
import 'package:lenovo_app/screens/update_note.dart';
import 'package:lenovo_app/services/accept_lead_filter.dart';
import 'package:lenovo_app/services/all_leadlist.dart';
import 'package:url_launcher/url_launcher.dart';

class AllLeadsPage extends StatefulWidget {
  const AllLeadsPage({Key? key, required Map<String, dynamic> data})
      : super(key: key);

  @override
  _AllLeadsPageState createState() => _AllLeadsPageState();
}

class _AllLeadsPageState extends State<AllLeadsPage> {
  bool isnoteadded = false;
  String editText = '';
  List<String> notes = [];
  List<dynamic> fetchLeadList = [];
  bool _isFavorite = false;
  String leadId = '';
  List<dynamic> records = []; // Initialize records as an empty list
  bool iswithfilter = false;
  // List<String> selectedData =[];
  List<String> selectedProducts = [];
  List<String> selectedTimeFrames = [];
  List<String> selectedsources = [];

  String startDate = '', endDate = '';
  List<dynamic> filteredList = [];
  void filter() {
    filteredList = fetchLeadList.where((record) {
      bool matchesProduct = selectedProducts.isEmpty
          ? true
          : selectedProducts
              .any((product) => record['product_group'].contains(product));
      bool matchesTimeFrame = selectedTimeFrames.isEmpty
          ? true
          : selectedTimeFrames.contains(record['purchase_time_frame']);
      bool matchesSource = selectedsources.isEmpty
          ? true
          : selectedsources.contains(record['source']);
      return matchesProduct && matchesTimeFrame && matchesSource;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchLeadData(); // Call the fetchLeadData function
  }

  Future<void> _fetchLeadData() async {
    fetchLeadList = [];
    try {
      final List<dynamic> data =
          await fetchLeadData(); // Call fetchLeadData and await the result
      setState(() {
        fetchLeadList = data;
      });
    } catch (error) {
      print('Error fetching follow-up leads data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Container(
            // autogroup6hxk2p5 (K3w54XWVdwHR1dXWXn6HXK)
            margin: const EdgeInsets.fromLTRB(1, 3, 0, 50),
            width: double.infinity,
            height: 46,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const SearchScreen());
                    },
                    child: Container(
                      // search9do (15:7723)
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      // padding:  EdgeInsets.fromLTRB(16, 15, 10, 16),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: double.infinity,
                      width: Get.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xffeaeef5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search here',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.2175,
                              color: Color(0xff1e0013),
                            ),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    log("result is here for pop up");
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FilterScreen()),
                    ).then((value) {
                      print(value);
                      // decode json recived from filter screen
                      if (value != "Nothing") {
                        log(" was hit from nothing not");
                        Map<String, dynamic> selectedData = json.decode(value);
                        selectedsources =
                            (selectedData['selectedSource'] as List)
                                .cast<String>();
                        selectedProducts =
                            (selectedData['selectedProducts'] as List)
                                .cast<String>();
                        selectedTimeFrames =
                            (selectedData['selectedTimeFrames'] as List)
                                .cast<String>();
                        startDate = selectedData['startDate'].toString();
                        endDate = selectedData['endDate'].toString();
                        setState(() {
                          iswithfilter = true;
                          filter();
                        });
                      } else {
                        log(" was hit from nothing yes");
                        setState(() {
                          iswithfilter = false;
                        });
                      }
                    });
                    log("messagehere is for pop up");

// Now 'result' holds the data returned from the second screen.
                  },
                  child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.filter_alt)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.55,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: iswithfilter
                    ? filteredList.length ?? 5
                    : fetchLeadList.length,
                itemBuilder: (context, index) {
                  final record =
                      iswithfilter ? filteredList[index] : fetchLeadList[index];
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 5, left: 5),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 249, 249, 249),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(
                              0, 3), // Offset in x and y directions
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.darkBlueColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.only(
                                        top: Get.height * 0.01,
                                        bottom: Get.height * 0.01),
                                    width: Get.width * 0.2,
                                    child: Center(
                                      child: AppText(
                                          text: '${record['STATUS']}',
                                          height: 0.018,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Toggle the _isFavorite variable
                                        _isFavorite = !_isFavorite;
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: _isFavorite
                                          ? Colors.red
                                          : Colors
                                              .grey, // Change color based on _isFavorite variable
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              AppText(
                                  text: '${record['company']}',
                                  height: 0.03,
                                  fontWeight: FontWeight.w700),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var record in records)
                                      Row(
                                        children: [
                                          AppText(
                                            text: "${record['lead_id']}",
                                            height: 0.016,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.greyColor,
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Container(
                                            width: 1,
                                            height: Get.height * 0.02,
                                            color: ColorConstants.greyColor,
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          AppText(
                                            text: "${record['lead_id']}",
                                            height: 0.016,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.greyColor,
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Container(
                                            width: 1,
                                            height: Get.height * 0.02,
                                            color: ColorConstants.greyColor,
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          AppText(
                                            text: "${record['sub_status']}",
                                            height: 0.016,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.greyColor,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          text:
                                              "${DateTime.parse(record['lead_generation_date']).day.toString().padLeft(2, '0')}-${DateTime.parse(record['lead_generation_date']).month.toString().padLeft(2, '0')}-${DateTime.parse(record['lead_generation_date']).year}",
                                          height: 0.019,
                                          fontWeight: FontWeight.w600),
                                      AppText(
                                          text: "Date",
                                          height: 0.019,
                                          color: ColorConstants.greyColor,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          text: "${record['lead_id']}",
                                          height: 0.019,
                                          fontWeight: FontWeight.w600),
                                      AppText(
                                          text: "HC Lead ID",
                                          height: 0.019,
                                          color: ColorConstants.greyColor,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.3,
                                          child: AppText(
                                              text: "${record['source']}",
                                              height: 0.019,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        AppText(
                                            text: "Source Name",
                                            height: 0.019,
                                            color: ColorConstants.greyColor,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.greyBackColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                        text: "Lead Details",
                                        height: 0.018,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.6,
                                          child: AppText(
                                              text: "${record['source']}",
                                              height: 0.02,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                String linkedInUrl =
                                                    "link_here"; // Replace "link_here" with the actual LinkedIn profile link
                                                if (await canLaunch(
                                                    Uri.parse(linkedInUrl)
                                                        .toString())) {
                                                  await launch(
                                                      Uri.parse(linkedInUrl)
                                                          .toString());
                                                } else {
                                                  print(
                                                      'Could not launch $linkedInUrl');
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                ImageConstants.linkDinSvg,
                                                width:
                                                    30, // Adjust the width as needed
                                                height:
                                                    30, // Adjust the height as needed
                                                // Add any additional properties for the SVG image as needed
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.02),
                                            GestureDetector(
                                              onTap: () async {
                                                String crossUrl =
                                                    "link_here"; // Replace "link_here" with the actual cross link
                                                if (await canLaunchUrl(
                                                    Uri.parse(crossUrl))) {
                                                  await launchUrl(
                                                      Uri.parse(crossUrl));
                                                } else {
                                                  print(
                                                      'Could not launch $crossUrl');
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                ImageConstants.crossSvg,
                                                width:
                                                    30, // Adjust the width as needed
                                                height:
                                                    30, // Adjust the height as needed
                                                // Add any additional properties for the SVG image as needed
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    AppText(
                                      text: "${record['company']}",
                                      height: 0.019,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.greyColor,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Divider(
                                      color: Colors
                                          .grey, // Choose your desired color for the divider
                                      thickness:
                                          1.0, // Adjust the thickness as needed
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.7,
                                              child: AppText(
                                                text:
                                                    "product_group: ${record['product_group']}",
                                                height: 0.018,
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants.greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AppText(
                                                  text:
                                                      "${record['units_required']}",
                                                  height: 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.2),
                                                AppText(
                                                  text: "\$${record['budget']}",
                                                  height: 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.1),
                                                AppText(
                                                  text:
                                                      "${record['purchase_time_frame']}",
                                                  height: 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              text: "Units",
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: Get.width * 0.15),
                                            AppText(
                                              text: "Budget",
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: Get.width * 0),
                                            AppText(
                                              text: "Timeframe",
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: Get.width * 0.000),
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    // Numbered notes
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Inside the GestureDetector where you call showEditTextDialog
// Inside the GestureDetector where you call showEditTextDialog
                            GestureDetector(
                              onTap: () async {
                                var record = fetchLeadList[
                                    index]; // Access the current record from fetchLeadList
                                var leadId = record[
                                    'lead_id']; // Assuming 'lead_id' is the key for leadId in your record
                                await showEditTextDialog(
                                  context,
                                  leadId.toString(), // Pass the leadId
                                  notes, // Assuming 'notes' is a List<String> variable
                                  (String leadId, String note) {
                                    print('Note added for lead $leadId: $note');
                                  },
                                ).then((value) => {
                                      setState(() {
                                        isnoteadded = true;
                                        notes.add(value);
                                      })
                                    });
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.note_add_outlined),
                                  AppText(
                                    text: "Add Note",
                                    height: 0.018,
                                    color: ColorConstants.greyColor,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),

                            Container(
                              height: Get.height * 0.08,
                              width: 1,
                              color: ColorConstants.greyColor,
                            ),
                            GestureDetector(
                              onTap: () async {
                                log("messageid = ${record['lead_id']}");
                                final update = await showUpdateStatusDialog(
                                    context, record['lead_id'].toString());
                                if (update != null) {
                                  log("_fetchLeadData");
                                  await _fetchLeadData();
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.edit),
                                  AppText(
                                    text: "Update",
                                    height: 0.018,
                                    color: ColorConstants.greyColor,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height * 0.08,
                              width: 1,
                              color: ColorConstants.greyColor,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    String whatsappNumber = record[
                                        'mobile_phone_number']; // Get WhatsApp number from the record
                                    String whatsappUrl =
                                        "https://wa.me/$whatsappNumber"; // WhatsApp URL with the number
                                    if (await canLaunchUrl(
                                        Uri.parse(whatsappUrl))) {
                                      await launchUrl(Uri.parse(whatsappUrl));
                                    } else {
                                      print('Could not launch $whatsappUrl');
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.whatshot, // WhatsApp icon
                                        size: 24, // Adjust the size as needed
                                      ),
                                      AppText(
                                        text: "Whatsapp",
                                        height: 0.018,
                                        color: ColorConstants.greyColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: Get.height * 0.08,
                              width: 1,
                              color: ColorConstants.greyColor,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    String phoneNumber = record[
                                        'mobile_phone_number']; // Replace with the desired phone number
                                    String callUrl = "tel:$phoneNumber";

                                    if (await canLaunchUrl(
                                        Uri.parse(callUrl))) {
                                      await launchUrl(Uri.parse(callUrl));
                                    } else {
                                      print('Could not launch $callUrl');
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.call),
                                      AppText(
                                        text: "Call",
                                        height: 0.018,
                                        color: ColorConstants.greyColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (isnoteadded)
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Customer Notes",
                                    height: 0.018,
                                    fontWeight: FontWeight.w500),
                                SizedBox(height: Get.height * 0.01),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: notes.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        // margin: const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: DateFormat('d MMMM y')
                                                  .format(DateTime.now()),
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            AppText(
                                              text: notes[index],
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
