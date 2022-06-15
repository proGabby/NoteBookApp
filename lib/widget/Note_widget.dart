import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/screen/noteview.dart';

import '../model/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Notes noteItem;
  const NoteWidget({Key? key, required this.noteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(noteItem.title),
        subtitle: Text("${noteItem.date}"),
        onTap: () {
          context.go(NoteView.screenName, extra: noteItem);
        },
      ),
    );
  }
}
