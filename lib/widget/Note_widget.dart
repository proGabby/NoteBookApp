import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:noteapp/screen/noteview.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Notes noteItem;
  const NoteWidget({Key? key, required this.noteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get the themedata
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(noteItem.id),
      //color the the dismissed background
      background: Container(
          color: theme.errorColor,
          padding: const EdgeInsets.all(11),
          child: const Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerRight),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //showdialog when dismissed is confirm
        return showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: const Text('Removing Note'),
                content: const Text('Do you want to remove this note?'),
                actions: [
                  TextButton(
                      child: const Text("YES"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                  TextButton(
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      })
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<NoteProvider>(context, listen: false)
            .removeNote(noteItem.id!);
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(noteItem.title),
          subtitle: Text(DateFormat.yMd().format(noteItem.date)),
          onTap: () {
            context.push(NoteView.screenName, extra: noteItem);
          },
        ),
      ),
    );
  }
}
