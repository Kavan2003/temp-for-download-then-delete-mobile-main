import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lenovo_app/services/lead_substatus_update.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

List<String> leadStatusOptions = [
  'Update Status',
];

List<String> reasonOptions = [
  'Reason',
];
List<int> leadStatusIds = <int>[
  0,
];
List<int> reasonIds = <int>[
  0,
];

class StatusDialogResult {
  final String? selectedLeadStatus;
  final String? selectedReason;

  StatusDialogResult({this.selectedLeadStatus, this.selectedReason});
}

Future<StatusDialogResult?> showUpdateStatusDialog(
  BuildContext context,
  String itemid,
) async {
  String? selectedLeadStatus = leadStatusOptions[0];
  String? selectedReason = reasonOptions[0];

  // Clear options to prevent data accumulation
  leadStatusOptions.clear();
  leadStatusOptions = ['Update Status'];
  leadStatusIds.clear();
  leadStatusIds = [0];
  reasonOptions.clear();
  reasonOptions = ['Reason'];
  reasonIds.clear();

  // bool reasonEnabled = false;
  reasonIds = [0];

  // Fetch Lead Status data from the first API
  final leadStatusResponse = await http.get(
    Uri.parse('https://clms-lenovo1.hashconnect.in/api/ui/common/lead-status'),
    headers: {'Authorization': '${AppPersist.getString(AppStrings.token, "")}'},
  );

  if (leadStatusResponse.statusCode == 200) {
    final leadStatusData = jsonDecode(leadStatusResponse.body);
    if (leadStatusData['status'] == 'SUCCESS') {
      for (final record in leadStatusData['records']) {
        leadStatusOptions.add(record['name']);
        leadStatusIds.add(record['id']);
      }
    } else {
      // Handle API error
      log('Error fetching lead status data');
    }
  } else {
    // Handle general network error
    log('Failed to fetch lead status data (status code: ${leadStatusResponse.statusCode})');
  }

  // Fetch Reason data from the second API (assuming selectedLeadStatusId is available)
  int? selectedLeadStatusId;

  if (leadStatusOptions.isNotEmpty) {
    selectedLeadStatusId = leadStatusIds[0];
  }

  return showDialog<StatusDialogResult>(
    context: context,
    builder: (BuildContext context) {
      return _buildDialog(
        context,
        leadStatusOptions,
        reasonOptions,
        selectedLeadStatus,
        selectedReason,
        itemid,
      );
    },
  );
}

Widget _buildDialog(
  BuildContext context,
  List<String> leadStatusOptions,
  List<String> reasonOptions,
  String? selectedLeadStatus,
  String? selectedReason,
  String itemid,
) {
  bool reasonEnabled = true;

  var selectStatusId = 0; // Use a variable to hold the selected status ID

  return StatefulBuilder(
    builder: (context, setState) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Update',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text('Lead Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  )),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                value: selectedLeadStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedLeadStatus = newValue!;
                    reasonEnabled = newValue != 'Follow-up';
                    if (!reasonEnabled) {
                      selectedReason = reasonOptions[0];
                    }

                    // Find the index of the selected status
                    selectStatusId = leadStatusOptions.indexOf(newValue);
                    if (selectStatusId == -1) {
                      log('Error: Selected status not found in options list');
                      return; // Handle potential error
                    }
                  });

                  // Clear and fetch reason options based on the selected status
                  reasonOptions.clear();
                  reasonIds.clear();
                  fetchReasons(leadStatusIds[selectStatusId].toString(), () {
                    setState(() {});
                  });
                },
                items: leadStatusOptions
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: selectedLeadStatus == value
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 10),
              Text(
                'Reason',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 5),
              if (reasonOptions != null)
                Builder(builder: (context) {
                  if (reasonOptions.isEmpty) reasonOptions.add("");
                  return DropdownButtonFormField<String?>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    value: selectedReason,
                    enableFeedback:
                        reasonEnabled, // Disable reason dropdown if not applicable
                    onChanged: (newValue) =>
                        setState(() => selectedReason = newValue!),
                    items: reasonOptions
                        .map<DropdownMenuItem<String?>>(
                          (String value) => DropdownMenuItem<String?>(
                            value: value ?? "",
                            child: Text(
                              value ?? "",
                              style: TextStyle(
                                color: selectedReason == value
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      if ((selectedLeadStatus == 'Accepted' ||
                              selectedLeadStatus == 'Rejected') &&
                          selectedReason == 'Reason') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a reason.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      try {
                        await updateLeadSubstatus(
                            itemid,
                            selectStatusId.toString(),
                            reasonIds[reasonOptions.indexOf(selectedReason!)]
                                .toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Lead status updated successfully.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.of(context).pop(StatusDialogResult(
                          selectedLeadStatus: selectedLeadStatus,
                          selectedReason: selectedReason,
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to update lead status: $e'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void fetchReasons(String newValue, Function param1) async {
  log("message${newValue}");
  final reasonResponse = await http.get(
    Uri.parse(
      'https://clms-lenovo1.hashconnect.in/api/lead/common/lead-substatus?id=$newValue',
    ),
    headers: {'Authorization': '${AppPersist.getString(AppStrings.token, "")}'},
  );

  if (reasonResponse.statusCode == 200) {
    final reasonData = jsonDecode(reasonResponse.body);
    if (reasonData['status'] == 'SUCCESS') {
      reasonOptions.clear();
      reasonIds.clear();
      for (final record in reasonData['records']) {
        reasonOptions.add(record['code']);
        reasonIds.add(record['id']);
      }
      param1();
    } else {
      // Handle API error
      log('Error fetching reason data: ${reasonData['message']}');
    }
  } else {
    // Handle general network error
    log('Failed to fetch reason data (status code: ${reasonResponse.statusCode})');
  }
}
