import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:simplenote/pages/add_edit_note_page.dart';
import 'package:simplenote/pages/search_page.dart';
import 'package:simplenote/providers/note_provider.dart';
import 'package:simplenote/widgets/error_dialog.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  static const String routeName = 'note-page';

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String userId;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (context.read<NoteList>().hasNextDocs) {
          context.read<NoteList>().getNotes(userId, 10);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = context.read<firebaseAuth.User>();
      userId = user.uid;
      try {
        // note를 다 읽어옴
        await context.read<NoteList>().getNotes(userId, 10);
        // await context.read<NoteList>().getAllNotes(userId);
      } catch (e) {
        errorDialog(context, e);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildBody(NoteListState noteList) {
    if (noteList.loading && noteList.notes.length == 0) {
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

    return ListView(
      controller: scrollController,
      children: [
        ...noteList.notes.map((note) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (_) async {
              try {
                await context.read<NoteList>().removeNote(note);
              } catch (e) {
                errorDialog(context, e);
              }
            },
            confirmDismiss: (_) {
              return showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are yo sure?'),
                      content: Text('Once done, cannot be recovered'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Yes'),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('NO'),
                        )
                      ],
                    );
                  });
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
                subtitle: Text(DateFormat('yyyy-MM-dd, hh:mm:ss')
                    .format(note.timestamp.toDate())),
              ),
            ),
          );
        }).toList(),
        if (context.read<NoteList>().hasNextDocs)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );

    return ListView.builder(
      itemCount: noteList.notes.length,
      itemBuilder: (BuildContext context, int index) {
        final note = noteList.notes[index];

        return Dismissible(
          key: ValueKey(note.id),
          onDismissed: (_) async {
            try {
              await context.read<NoteList>().removeNote(note);
            } catch (e) {
              errorDialog(context, e);
            }
          },
          confirmDismiss: (_) {
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Are yo sure?'),
                    content: Text('Once done, cannot be recovered'),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Yes'),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('NO'),
                      )
                    ],
                  );
                });
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
              subtitle: Text(DateFormat('yyyy-MM-dd, hh:mm:ss')
                  .format(note.timestamp.toDate())),
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
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return SearchPage();
                        }));
              },
            )
          ],
        ),
        body: _buildBody(noteList));
  }
}
