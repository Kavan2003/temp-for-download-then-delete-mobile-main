import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/services/accept_lead_filter.dart';
import 'package:lenovo_app/services/product_api.dart';
import 'package:lenovo_app/services/purchase_frame.dart';
import 'package:lenovo_app/services/source.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<ChipsModel> chipData = [];
  List<ChipsModel> productData = [];
  List<ChipsModel> timeData = [];

  @override
  void initState() {
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _dateFormat = DateFormat('dd/MM/yyyy'); // Specify date format
    _fetchProduct();
    _fetchPurchaseTimeFrame();
    _fetchSource();
    super.initState();
  }

  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late DateFormat _dateFormat; // DateFormat for formatting dates
  List<String> idproduct = [];
  List<String> idsource = [];
  List<String> i = [];
  bool iscleardata = false;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text =
            _dateFormat.format(picked); // Format and set selected date
      });
    }
  }

  Future<void> _fetchSource() async {
    try {
      await fetchSource().then((value) => {
            setState(() {
              log("bycf f fctfcvgh");

              var response = json.decode(value);
              log("bycf f fctfcvgh");

              log(value);
              log("""response${response}""");

              for (var r in response['records']) {
                chipData
                    .add(ChipsModel(title: r['name'], isSelected: false.obs));
              }
            })
          });
    } catch (e) {
      print('Error fetching source: $e');
    }
  }

  Future<void> _fetchPurchaseTimeFrame() async {
    try {
      await fetchPurchaseTimeFrame().then((value) => {
            setState(() {
              var response = json.decode(value);
              if (response['status'] == "SUCCESS") {
                // log("""response${response}""");
                timeData.clear();
                for (var r in response['records']) {
                  timeData
                      .add(ChipsModel(title: r['name'], isSelected: false.obs));
                }
                //  timeData.addAll(response['records'].map((a) => a['name']).toList());
              }
            })
          });
    } catch (e) {
      print('Error fetching purchase time frame: $e');
    }
  }

  Future<void> _fetchProduct() async {
    try {
      log("messagmsfe");
      await fetchProduct().then((value) => {
            setState(() {
              log("messagmsfwddqe");
              log("message${value}");
              var response = json.decode(value);
              log("""response${response}""");
              productData.clear();
              if (response['status'] == "SUCCESS")
                for (var r in response['records']) {
                  productData
                      .add(ChipsModel(title: r['name'], isSelected: false.obs));
                }
              // productData = response['records']
              //     .map((item) => item['name'])
              //     .toList()
              //     .cast<String>();
            })
          });
    } catch (e) {
      print('Error fetching product time frame: $e');
    }
  }

  List<String> getSelectedItems(List<ChipsModel> data) {
    return data
        .where((item) => item.isSelected!.value)
        .map((item) => item.title!)
        .toList();
  }

  RangeValues _values = RangeValues(0.2, 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            right: Get.height * 0.03,
            left: Get.height * 0.03,
            top: Get.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      var jsonData = "";
                      if (iscleardata != true) {
                        var selectedData = {
                          'selectedSource': getSelectedItems(chipData),
                          'selectedProducts': getSelectedItems(productData),
                          'selectedTimeFrames': getSelectedItems(timeData),
                          'startDate': _startDateController.text,
                          'endDate': _endDateController.text,
                        };
                        jsonData = json.encode(selectedData);
                      } else {
                        jsonData = "Nothing";
                      }
                      Navigator.pop(context, jsonData);

                      // Get.back();
                    },
                    child: Icon(Icons.arrow_back)),
                AppText(
                    text: "Filter", height: 0.022, fontWeight: FontWeight.w500),
                GestureDetector(
                  onTap: () {
                    for (var chip in productData) {
                      chip.isSelected!.value = false;
                    }
                    for (var chip in timeData) {
                      chip.isSelected!.value = false;
                    }
                    _endDateController.clear();
                    _startDateController.clear();
                    iscleardata = true;
                    // _fetchProduct();
                    // _fetchPurchaseTimeFrame();
                    // _fetchSource();
                  },
                  child: AppText(
                      text: "Clear all",
                      color: Colors.red,
                      height: 0.02,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // shadow color
                      spreadRadius: 2, // spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: AppText(
                          text: "Source",
                          height: 0.022,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 8.0, // spacing between chips
                        runSpacing: 8.0, // spacing between lines of chips
                        children: chipData.map((ChipsModel chipName) {
                          return Obx(() => GestureDetector(
                                onTap: () {
                                  for (var chip in chipData) {
                                    chip.isSelected!.value = false;
                                  }
                                  chipName.isSelected!.value = true;
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: (chipName.isSelected!.value)
                                        ? ColorConstants.darkBlueColor
                                        : ColorConstants.lightGreyColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: AppText(
                                    text: chipName.title!,
                                    height: 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: (chipName.isSelected!.value)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: AppText(
                          text: "Products",
                          height: 0.022,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 8.0, // spacing between chips
                        runSpacing: 8.0, // spacing between lines of chips
                        children: productData.map((ChipsModel chipName) {
                          return Obx(() => GestureDetector(
                                onTap: () {
                                  chipName.isSelected!.value =
                                      !chipName.isSelected!.value;
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: (chipName.isSelected!.value)
                                        ? ColorConstants.darkBlueColor
                                        : ColorConstants.lightGreyColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: AppText(
                                    text: chipName.title!,
                                    height: 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: (chipName.isSelected!.value)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ));
                          //   Chip(
                          //
                          //   label: Text(chipName),
                          //
                          // );
                        }).toList(),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: AppText(
                          text: "Timeframe",
                          height: 0.022,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 8.0, // spacing between chips
                        runSpacing: 8.0, // spacing between lines of chips
                        children: timeData.map((ChipsModel chipName) {
                          return Obx(() => GestureDetector(
                                onTap: () {
                                  chipName.isSelected!.value =
                                      !chipName.isSelected!.value;
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: (chipName.isSelected!.value)
                                        ? ColorConstants.darkBlueColor
                                        : ColorConstants.lightGreyColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: AppText(
                                    text: chipName.title!,
                                    height: 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: (chipName.isSelected!.value)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: AppText(
                          text: "Date range",
                          height: 0.022,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Get.width * 0.35,
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.lightGreyColor,
                            ),
                            // Set container color to grey
                            child: TextField(
                              readOnly: true,
                              controller: _startDateController,
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                labelStyle: TextStyle(color: Colors.grey),
                                // Set label text color to white
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors
                                          .grey), // Set icon color to white
                                  onPressed: () => _selectDate(
                                      context, _startDateController),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Container(
                            width: Get.width * 0.35,
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.lightGreyColor,
                            ), // Set container color to grey
                            child: TextField(
                              readOnly: true,
                              controller: _endDateController,
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                labelStyle: TextStyle(
                                    color: Colors
                                        .grey), // Set label text color to black
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors
                                          .grey), // Set icon color to white
                                  onPressed: () =>
                                      _selectDate(context, _endDateController),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: AppText(
                          text: "Budget",
                          height: 0.022,
                          fontWeight: FontWeight.w500),
                    ),
                    RangeSlider(
                      values: _values,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          _values = newValues;
                        });
                      },
                      min: 0.0,
                      max: 1.0,
                      activeColor: ColorConstants
                          .darkBlueColor, // Set active track color
                      inactiveColor: ColorConstants
                          .lightGreyColor, // Set inactive track color
                      // thumbColor: Colors.white, // Set thumb color
                      divisions: 8,
                      labels: RangeLabels(
                        _values.start.toString(),
                        _values.end.toString(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                              text: "0",
                              height: 0.016,
                              fontWeight: FontWeight.w500),
                          AppText(
                              text: "\$200,000",
                              height: 0.016,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChipsModel {
  String? title;
  RxBool? isSelected = false.obs;
  ChipsModel({this.title, this.isSelected});
}
