// notes - userId1 - userNotes - note1, note2, note3 형식으로 user당 note db 구성
// note CRUD

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simplenote/constants/db_constatns.dart';
import 'package:simplenote/models/note_model.dart';

class NoteListState extends Equatable {
  final bool loading;
  final List<Note> notes;

  NoteListState({this.loading, this.notes});

  NoteListState copywith({bool loading, List<Note> notes}) {
    return NoteListState(
        loading: loading ?? this.loading, notes: notes ?? this.notes);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, notes];
}

class NoteList extends ChangeNotifier {
  NoteListState state = NoteListState(loading: false, notes: []);
  bool _hasNextDocs = true;

  bool get hasNextDocs => _hasNextDocs;

  void handleError(Exception e) {
    print(e);
    state = state.copywith(loading: false);
    notifyListeners();
  }

  Future<void> getNotes(String userId, int limit) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      QuerySnapshot userNotesSnapshot;
      DocumentSnapshot startAfterDoc;

      if (state.notes.isNotEmpty) {
        Note n = state.notes.last;
        startAfterDoc =
            await notesRef.doc(userId).collection('userNotes').doc(n.id).get();
      } else {
        startAfterDoc = null;
      }

      final refNotes = notesRef
          .doc(userId)
          .collection('userNotes')
          .orderBy('timestamp', descending: true)
          .limit(limit);

      if (startAfterDoc == null) {
        // 마지막에 get을 해야 데이터가 얻어짐
        userNotesSnapshot = await refNotes.get();
      } else {
        userNotesSnapshot =
            await refNotes.startAfterDocument(startAfterDoc).get();
      }

      List<Note> notes = userNotesSnapshot.docs.map((noteDoc) {
        return Note.fromDoc(noteDoc);
      }).toList();

      if (userNotesSnapshot.docs.length < limit) {
        _hasNextDocs = false;
      }

      state = state.copywith(loading: false, notes: [...state.notes, ...notes]);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // note list 읽어오기
  Future<void> getAllNotes(String userId) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      QuerySnapshot userNotesSnapshot = await notesRef
          .doc(userId)
          .collection('userNotes')
          .orderBy('timestamp', descending: true)
          .get();

      List<Note> notes = userNotesSnapshot.docs.map((noteDoc) {
        return Note.fromDoc(noteDoc);
      }).toList();

      state = state.copywith(loading: false, notes: notes);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // 서치타입 1 : res를 state에 저장하지 않고 그냥 return
  Future<List<QuerySnapshot>> searchNotes(
      String userId, String searchTerm) async {
    try {
      final snapshotOne = notesRef
          .doc(userId)
          .collection('userNotes')
          .where('title', isGreaterThanOrEqualTo: searchTerm)
          .where('title', isLessThanOrEqualTo: searchTerm + 'z');

      final snapshotTwo = notesRef
          .doc(userId)
          .collection('userNotes')
          .where('desc', isGreaterThanOrEqualTo: searchTerm)
          .where('desc', isLessThanOrEqualTo: searchTerm + 'z');

      final userNotesSnapshot =
          await Future.wait([snapshotOne.get(), snapshotTwo.get()]);

      return userNotesSnapshot;
    } catch (e) {
      rethrow;
    }
  }

  // 새로운 note 만들기
  Future<void> addNote(Note newNote) async {
    state = state.copywith(loading: false);
    notifyListeners();

    // noteOwnerId아래애 다음의 스키마를 생성하고 업로드 해줌.
    try {
      DocumentReference docRef =
          await notesRef.doc(newNote.noteOwnerId).collection('userNotes').add({
        'title': newNote.title,
        'desc': newNote.desc,
        'noteOwnerId': newNote.noteOwnerId,
        'timestamp': newNote.timestamp
      });
      final note = Note(
          id: docRef.id,
          title: newNote.title,
          desc: newNote.desc,
          noteOwnerId: newNote.noteOwnerId,
          timestamp: newNote.timestamp);

      state = state.copywith(loading: false, notes: [note, ...state.notes]);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> updateNote(Note note) async {
    state = state.copywith(loading: false);
    notifyListeners();

    try {
      // 서버에서 적용
      await notesRef
          .doc(note.noteOwnerId)
          .collection('userNotes')
          .doc(note.id)
          .update({'title': note.title, 'desc': note.desc});

      // ui 작용
      final notes = state.notes.map((n) {
        return n.id == note.id
            ? Note(
                id: n.id,
                title: note.title,
                desc: note.desc,
                timestamp: note.timestamp)
            : n;
      }).toList();

      state = state.copywith(loading: false, notes: notes);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> removeNote(Note note) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      await notesRef
          .doc(note.noteOwnerId)
          .collection('userNotes')
          .doc(note.id)
          .delete();

      final notes = state.notes.where((n) => n.id != note.id).toList();
      state = state.copywith(loading: false, notes: notes);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
