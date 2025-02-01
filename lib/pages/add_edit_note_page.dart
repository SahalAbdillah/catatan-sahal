import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddEditNotePage extends StatefulWidget {
  final String? noteId;

  AddEditNotePage({this.noteId});

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();

    if (widget.noteId != null) {
      _loadNote();
    }
  }

  // Fungsi untuk mengambil catatan dari Firestore (untuk edit)
  Future<void> _loadNote() async {
    // Ambil data catatan berdasarkan ID
  }

  // Fungsi untuk menyimpan catatan baru atau mengedit catatan
  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Judul dan konten tidak boleh kosong')),
      );
      return;
    }

    final noteData = {
      'title': _titleController.text,
      'content': _contentController.text,
    };

    try {
      if (widget.noteId == null) {
        await _firestoreService.addNote(noteData);
      } else {
        await _firestoreService.editNote(widget.noteId!, noteData);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan catatan: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.noteId == null ? 'Tambah Catatan' : 'Edit Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Isi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
