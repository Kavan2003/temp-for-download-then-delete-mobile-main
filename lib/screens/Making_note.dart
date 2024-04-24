import 'package:flutter/material.dart';
import 'package:lenovo_app/services/add_notes_services.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

showEditTextDialog(
  BuildContext context,
  String leadId,
  Function(String, List<String>) onNoteAdded,
  Null Function(String leadId, String note) param3,
) async {
  String editText = ''; // User input for the note

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
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
                        backgroundImage: NetworkImage(
                          AppPersist.getString(AppStrings.userimage, ""),
                        ),
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
                            hintText: 'Add note here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () async {
                          if (editText.isNotEmpty) {
                            int parsedLeadId = int.tryParse(leadId) ?? 0;
                            await addNote(parsedLeadId, editText);
                            // After adding a note, fetch the updated list of notes
                            List<String> updatedNotes =
                                await fetchNotes(parsedLeadId);
                            onNoteAdded(leadId, updatedNotes);
                            Navigator.of(context).pop();
                          }
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
