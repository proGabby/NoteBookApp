import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:noteapp/screen/Error_screen.dart';
import 'package:noteapp/screen/add_note.dart';
import 'package:noteapp/screen/noteview.dart';
import 'package:provider/provider.dart';

import './screen/note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp.router(
          title: 'NoteBook App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate
          // home: const NoteScreen(),
          ),
    );
  }

  final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const NoteScreen();
            }),
        GoRoute(
            path: AddNoteScreen.screenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return state.extra == null
                  ? const AddNoteScreen()
                  : AddNoteScreen(
                      note: state.extra! as Notes,
                    );
            }),
        GoRoute(
            path: NoteView.screenName,
            builder: (BuildContext context, GoRouterState state) {
              return NoteView(
                note: state.extra! as Notes,
              );
            })
      ],
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const ErrorScreen());
}
