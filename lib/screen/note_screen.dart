import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:noteapp/widget/Note_widget.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);
  // Future? noteHolder;

  // @override
  // void initState() {
  //   noteHolder = futureBuilder();
  //   super.initState();
  // }

  // Future<void> futureBuilder() {
  //   return Provider.of<NoteProvider>(context).fetchAndSetNotes();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
      ),
      body: FutureBuilder(
        future: Provider.of<NoteProvider>(context, listen: false)
            .fetchAndSetNotes(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<NoteProvider>(
              child: const Center(
                child: Text('Please add Note'),
              ),
              builder: (ctx, notesData, chld) {
                final numberOfNotes = notesData.notes.length;
                return numberOfNotes <= 0
                    ? chld!
                    : ListView.builder(
                        itemCount: numberOfNotes,
                        itemBuilder: (ctx, index) {
                          return NoteWidget(noteItem: notesData.notes[index]);
                        });
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          return context.push('/addNote');
        },
      ),
    );
  }
}
