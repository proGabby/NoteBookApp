import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  static const screenRoute = '/addNote';
  final Notes? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  // final _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _description = TextEditingController();
  var _dateOfNote = DateFormat.yMd().format(DateTime.now());

  @override
  void dispose() {
    _description.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.note?.id != null) {
      _titleController.text = widget.note!.title;
      _description.text = widget.note!.msg;
      _dateOfNote = DateFormat.yMd().format(widget.note!.date);
    }
    super.initState();
  }

  void onSaved() async {
    if (_description.text.isEmpty || _titleController.text.isEmpty) {
      return;
    }

    try {
      final avalList = Provider.of<NoteProvider>(context, listen: false).notes;
      final isFound = avalList.any((item) => item.id == widget.note?.id);

      if (!isFound) {
        await Provider.of<NoteProvider>(context, listen: false)
            .addNotes(_titleController.text, _description.text);
      } else {
        final updatedNote = Notes(
            id: widget.note!.id,
            title: _titleController.text,
            msg: _description.text,
            date: widget.note!.date);
        await Provider.of<NoteProvider>(context, listen: false)
            .updateNote(updatedNote);
      }
      context.go('/');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Notes"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: onSaved, icon: const Icon(Icons.save)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              children: [
                Card(
                  elevation: 5,
                  child: SizedBox(
                    width: mediaQuerySize.width * 0.6,
                    child: buildTitle(),
                  ),
                ),
                const Spacer(),
                Card(
                    elevation: 5,
                    child: Text(
                      _dateOfNote,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: mediaQuerySize.height * 0.02),
            SizedBox(
                height: mediaQuerySize.height * 0.7,
                child: TextFormField(
                  expands: true,
                  decoration: const InputDecoration(
                      labelText: 'Enter your note here', hintText: 'Notes'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _description,
                )),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Tittle',
        hintText: 'Enter title of note here',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
