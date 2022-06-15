import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  // final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _description = TextEditingController();
  final _dateOfNote = DateFormat.yMd().format(DateTime.now());

  @override
  void dispose() {
    _description.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void onSaved() async {
    if (_description.text.isEmpty || _titleController.text.isEmpty) {
      return;
    }

    try {
      await Provider.of<NoteProvider>(context, listen: false)
          .addNotes(_titleController.text, _description.text);
      context.pop();
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
