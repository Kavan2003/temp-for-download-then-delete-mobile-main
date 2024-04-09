import 'package:flutter/material.dart';
import 'package:lenovo_app/services/add_notes_services.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

showEditTextDialog(BuildContext context, String leadId, List<String> notes,
    Function(String, String) onNoteAdded) async {
  String editText = ''; // Define editText within the function
  String note = '';
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        // Replace with user profile photo
                        backgroundImage: NetworkImage(
                            AppPersist.getString(AppStrings.userimage, "")),
                        // AssetImage('assets/user-image.png'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              editText = value;
                            });
                          },
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Add note here', // Placeholder text
                            border: InputBorder.none, // Remove border
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () async {
                          if (editText.isNotEmpty) {
                            await addNote(int.tryParse(leadId) ?? 0, editText);
                            onNoteAdded(leadId, editText);
                            setState(() {
                              note = editText;
                              editText = '';
                            });
                          }
                          Navigator.of(context).pop('$note');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
