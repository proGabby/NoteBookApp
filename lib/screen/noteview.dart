import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:noteapp/model/note_model.dart';

class NoteView extends StatelessWidget {
  static const screenName = '/noteview';
  final Notes note;
  const NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotePad'),
      ),
      body: ListView(children: [
        Card(
          child: ListTile(
            leading: Text('${note.title}'),
            trailing: Text(DateFormat.yMd().format(note.date)),
          ),
        ),
        Expanded(child: Text(note.msg)),
      ]),
    );
  }
}
