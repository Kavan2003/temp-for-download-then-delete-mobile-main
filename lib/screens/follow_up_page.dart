import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/constants/imageConstants.dart';
import 'package:lenovo_app/screens/Making_note.dart';
import 'package:lenovo_app/screens/filterScreen.dart';
import 'package:lenovo_app/screens/searchScreen.dart';
import 'package:lenovo_app/screens/update_note.dart';
import 'package:lenovo_app/services/folloup_lead.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUpPage extends StatefulWidget {
  const FollowUpPage({Key? key, required Map<String, dynamic> data})
      : super(key: key);

  @override
  _FollowUpPageState createState() => _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  String editText = '';
  List<String> notes = [];
  List<dynamic> followUpLeads = [];
  bool _isFavorite = false;
  bool isnoteadded = false;

  List<dynamic> records = []; // Initialize records as an empty list

  @override
  void initState() {
    super.initState();
    fetchFollowUpLeadsData();
  }

  void fetchFollowUpLeadsData() async {
    try {
      final Map<String, dynamic> data = await fetchFollowUpLeads();
      setState(() {
        followUpLeads = data['records'] ?? [];
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
                  onTap: () {
                    Get.to(const FilterScreen());
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
                itemCount: followUpLeads.length,
                itemBuilder: (context, index) {
                  final record = followUpLeads[index];
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
                                          text: '${record['lead_status']}',
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
                                          text: record[
                                                      'next_interaction_scheduled_at'] !=
                                                  null
                                              ? "${DateTime.parse(record['next_interaction_scheduled_at']).day.toString().padLeft(2, '0')}-${DateTime.parse(record['next_interaction_scheduled_at']).month.toString().padLeft(2, '0')}-${DateTime.parse(record['next_interaction_scheduled_at']).year}"
                                              : "N/A",
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
                                            AppText(
                                              text:
                                                  "product_group: ${record['product_group']}",
                                              height: 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants.greyColor,
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
                                                      "${record['quantity_required']}",
                                                  height: 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.2),
                                                AppText(
                                                  text: "\$10000",
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
                              onTap: () {
                                var record = followUpLeads[
                                    index]; // Access the current record from fetchLeadList
                                var leadId = record[
                                    'lead_id']; // Assuming 'lead_id' is the key for leadId in your record
                                showEditTextDialog(
                                  context,
                                  leadId, // Pass the leadId
                                  notes, // Assuming 'notes' is a List<String> variable
                                  (String leadId, String note) {
                                    // Modify the callback function to accept leadId
                                    // Your logic to handle the added note for the specific lead
                                    // For example, you can print it with the leadId
                                    print('Note added for lead $leadId: $note');
                                    // Here you can update the state or perform any other actions as needed
                                  },
                                );
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
                              onTap: () {
                                //       showUpdateStatusDialog(context);
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
