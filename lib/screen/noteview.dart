import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/screen/add_note.dart';

class NoteView extends StatelessWidget {
  static const screenName = '/noteview';
  final Notes note;
  const NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotePad'),
        actions: [
          IconButton(
              onPressed: () {
                context.push(AddNoteScreen.screenRoute, extra: note);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(children: [
        Card(
          child: ListTile(
            leading: Text('${note.title}'),
            trailing: Text(DateFormat.yMd().format(note.date)),
          ),
        ),
        SizedBox(
          height: _deviceSize.height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
              height: _deviceSize.height * .8,
              child: Expanded(child: Text(note.msg))),
        ),
      ]),
    );
  }
}
