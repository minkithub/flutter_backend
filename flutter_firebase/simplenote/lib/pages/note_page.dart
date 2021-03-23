import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:simplenote/pages/add_edit_note_page.dart';
import 'package:simplenote/providers/note_provider.dart';
import 'package:simplenote/widgets/error_dialog.dart';

class NotesPage extends StatefulWidget {
  static const String routeName = 'note-page';

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = context.read<firebaseAuth.User>();
      userId = user.uid;
      try {
        // note를 다 읽어옴
        await context.read<NoteList>().getAllNotes(userId);
      } catch (e) {
        errorDialog(context, e);
      }
    });
  }

  Widget _buildBody(NoteListState noteList) {
    if (noteList.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (noteList.notes.length == 0) {
      return Center(
        child: Text(
          'Add Some',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }

    Widget showDismissibleBackground(int secondary) {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        alignment:
            secondary == 0 ? Alignment.centerLeft : Alignment.centerRight,
        child: Icon(Icons.delete, size: 30, color: Colors.white),
      );
    }

    return ListView.builder(
      itemCount: noteList.notes.length,
      itemBuilder: (BuildContext context, int index) {
        final note = noteList.notes[index];

        return Dismissible(
          key: ValueKey(note.id),
          onDismissed: (_) {},
          confirmDismiss: (_) {
            return null;
          },
          background: showDismissibleBackground(0),
          secondaryBackground: showDismissibleBackground(1),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddEditNotePage(note: note);
                }));
              },
              title: Text(
                note.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(note.timestamp.toDate().toIso8601String()),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // user.uid를 provider를 이용해 쉽게 접근핧 수 있다.
    // final user = context.watch<firebaseAuth.User>();
    // print('>>>>> ${user.uid}');

    final noteList = context.watch<NoteList>().state;

    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddEditNotePage();
                }));
              },
            )
          ],
        ),
        body: _buildBody(noteList));
  }
}
