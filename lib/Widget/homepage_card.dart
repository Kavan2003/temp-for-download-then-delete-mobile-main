import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/screens/home_page.dart';
import 'package:lenovo_app/services/folloup_lead.dart';
import 'package:lenovo_app/services/mobile_dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class HCard extends StatefulWidget {
  const HCard({Key? key, required Map<String, dynamic> data}) : super(key: key);

  @override
  _HCardState createState() => _HCardState();
}

class _HCardState extends State<HCard> {
  Map<String, dynamic>? dashboardData;
  List<dynamic> followUpLeads = [];

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
    fetchFollowUpLeadsData();
  }

  void fetchDashboardData() async {
    try {
      Map<String, dynamic> data = await fetchMobileDashboardData();
      setState(() {
        dashboardData = data;
      });
    } catch (error) {
      print('Error fetching dashboard data: $error');
    }
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

  String formatDate(String apiDateString) {
    DateTime dateTime = DateTime.parse(apiDateString);
    return DateFormat('dd/MMM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 23, 0, 22),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffdbe3ed),
                  offset: Offset(3, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(17, 0, 21, 0),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 44, 6),
                            child: Text(
                              '${dashboardData?["records"]?[0]?["total_budget"] ?? "Loading..."}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                height: 1.2175,
                                color: Color(0xff1e0013),
                              ),
                            ),
                          ),
                          Text(
                            'Available Opportunity',
                            style: TextStyle(
                              fontSize: Get.height * 0.018,
                              fontWeight: FontWeight.w700,
                              height: 1.2175,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(11.5, 6, 11.5, 5),
                        width: 106,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Color(0xffe1251b),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            ' ${dashboardData?["records"]?[0]?["open_leads"] ?? "Loading..."} New Leads',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              height: 1.2175,
                              letterSpacing: 0.5,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Text(
                            '${dashboardData?["records"]?[0]?["total_lead_count"] ?? "Loading..."}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.2175,
                              color: Color(0xff1e0013),
                            ),
                          ),
                        ),
                        Text(
                          '${dashboardData?["records"]?[0]?["total_lead_count_title"] ?? "Loading..."}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.2175,
                            color: Color(0xff4e444e),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Text(
                            '${dashboardData?["records"]?[0]?["accepted_leads"] ?? "Loading..."}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.2175,
                              color: Color(0xff1e0013),
                            ),
                          ),
                        ),
                        Text(
                          'Actioned Leads',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.2175,
                            color: Color(0xff4e444e),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Text(
                            '${dashboardData?["records"]?[0]?["acceptance"] ?? "Loading..."}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.2175,
                              color: Color(0xff1e0013),
                            ),
                          ),
                        ),
                        Text(
                          'Action Rate',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.2175,
                            color: Color(0xff4e444e),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(12, 0, 20, 12),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 129, 0),
                child: Text(
                  'Follow up Leads',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.2175,
                    color: Color(0xff1e0013),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    globalPageController.setPage(1);
                  });
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2175,
                    color: Color(0xffe1251b),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Card(
            elevation: 10,
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                // Added SingleChildScrollView here
                child: Column(
                  children:
                      List.generate(followUpLeads.length.clamp(0, 5), (index) {
                    final lead = followUpLeads[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                width: double.infinity,
                                height: 54,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${formatDate(lead["lead_generation_date"])}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff1e0013),
                                          ),
                                        ),
                                        Text(
                                          '${lead["company"]}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1e0013),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 19,
                                      backgroundColor: Color(0xff294E95),
                                      child: IconButton(
                                        onPressed: () => _makePhoneCall(
                                            lead["mobile_phone_number"]),
                                        icon: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        String phoneNumber =
                                            lead["mobile_phone_number"];
                                        final callUri = Uri.parse(
                                            "tel:$phoneNumber"); // Convert string to Uri

                                        if (await canLaunchUrl(callUri)) {
                                          await launchUrl(callUri);
                                        } else {
                                          print('Could not launch $callUri');
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svg/person.svg",
                                        width: 26,
                                        height: 26,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${lead["lead_name"]}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1e0013),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final phoneUri = Uri.parse('tel:$phoneNumber'); // Convert string to Uri
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch phone dialer for $phoneNumber');
    }
  }
}
