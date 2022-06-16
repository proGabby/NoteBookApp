import 'package:flutter/material.dart';
import 'package:noteapp/helpers/db.dart';
import 'package:uuid/uuid.dart';

import '../model/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<Notes> _noteItem = [];

  List<Notes> get notes {
    return [..._noteItem];
  }

  Future<void> addNotes(String title, String msg) async {
    final noteId = Uuid().v1();
    final newNote =
        Notes(id: noteId, title: title, msg: msg, date: DateTime.now());
    await DBHelper.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'msg': newNote.msg,
      'date': newNote.date.toIso8601String()
    });
    _noteItem.add(newNote);
    notifyListeners();
  }

  Future<void> fetchAndSetNotes() async {
    final dataList = await DBHelper.getData('user_notes');

    _noteItem = dataList
        .map(
          (item) => Notes(
            id: item['id'],
            title: item['title'],
            msg: item['msg'],
            date: DateTime.parse(item['date']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> removeNote(String id) async {
    try {
      await DBHelper.deleteData('user_notes', id);
      _noteItem.removeWhere((note) => note.id == id);
      notifyListeners();
    } catch (e) {}
  }

  // Future<void> updateNote(String id) async {
  //   try {
  //     await DBHelper.updateNote('user_notes', data, id);
  //     _noteItem.removeWhere((note) => note.id == id);
  //     notifyListeners();
  //   } catch (e) {}
  // }
}
