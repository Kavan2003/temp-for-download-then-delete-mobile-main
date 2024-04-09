import 'package:flutter/material.dart';
import 'package:lenovo_app/services/lead_substatus_update.dart';

class StatusDialogResult {
  final String? selectedLeadStatus;
  final String? selectedReason;

  StatusDialogResult({this.selectedLeadStatus, this.selectedReason});
}

Future<StatusDialogResult?> showUpdateStatusDialog(BuildContext context) async {
  List<String> leadStatusOptions = [
    'Update Status',
    'Follow-up',
    'Accepted',
    'Rejected',
  ];

  List<String> reasonOptions = [
    'Reason',
    'Cannot Reach',
    'No Budget',
    'No Timeline',
    'Rejected',
    'Not My account',
    'Competitor / Reseller',
  ];

  String? selectedLeadStatus = leadStatusOptions[0];
  String? selectedReason = reasonOptions[0];
  bool reasonEnabled = true;

  return showDialog<StatusDialogResult>(
    context: context,
    builder: (BuildContext context) {
      return _buildDialog(context, leadStatusOptions, reasonOptions,
          selectedLeadStatus, selectedReason);
    },
  );
}

Widget _buildDialog(
    BuildContext context,
    List<String> leadStatusOptions,
    List<String> reasonOptions,
    String? selectedLeadStatus,
    String? selectedReason) {
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
              Text(
                'Lead Status',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
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
                    var reasonEnabled = newValue != 'Follow-up';
                    if (!reasonEnabled) selectedReason = reasonOptions[0];
                  });
                },
                items: leadStatusOptions.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: selectedLeadStatus == value
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
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
                value: selectedReason,
                onChanged: (newValue) {
                  setState(() {
                    selectedReason = newValue!;
                  });
                },
                items: reasonOptions.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: selectedReason == value
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
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
                      if (selectedLeadStatus == 'Accepted' ||
                          selectedLeadStatus == 'Rejected') {
                        if (selectedReason == 'Reason') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a reason.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        
                      }

                      try {
                        await updateLeadSubstatus();
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
