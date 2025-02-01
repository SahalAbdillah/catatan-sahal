import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk menambah catatan
  Future<void> addNote(Map<String, dynamic> noteData) async {
    try {
      await _firestore.collection('notes').add(noteData);
    } catch (e) {
      throw Exception('Gagal menambah catatan: ${e.toString()}');
    }
  }

  // Fungsi untuk mengedit catatan
  Future<void> editNote(String noteId, Map<String, dynamic> noteData) async {
    try {
      await _firestore.collection('notes').doc(noteId).update(noteData);
    } catch (e) {
      throw Exception('Gagal mengedit catatan: ${e.toString()}');
    }
  }

  // Fungsi untuk menghapus catatan
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      throw Exception('Gagal menghapus catatan: ${e.toString()}');
    }
  }

  // Fungsi untuk mengambil daftar catatan
  Stream<QuerySnapshot> getNotes() {
    return _firestore.collection('notes').snapshots();
  }
}
