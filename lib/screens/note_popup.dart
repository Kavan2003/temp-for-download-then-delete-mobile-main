import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting

void showNotesPopup(BuildContext context, List<String> notes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('All Notes'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display all notes here
            // Assuming you have a list called 'notes' that contains all the notes
            ListView.builder(
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]),
                  // Add functionality for delete or modify notes here
                  // onPressed: () {
                  //   // Implement functionality for delete or edit notes
                  // },
                );
              },
            ),
          ],
        ),
        actions: [
          // Add close button to close the popup
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
