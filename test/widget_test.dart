import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_sederhana/pages/login_page.dart';

void main() {
  testWidgets('LoginPage displays email and password fields',
      (WidgetTester tester) async {
    // Memuat halaman LoginPage
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Memastikan bahwa TextField untuk email dan password muncul
    expect(find.byType(TextField),
        findsNWidgets(2)); // Seharusnya ada dua TextField (email dan password)

    // Memastikan bahwa tombol login ada
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Validasi Login dengan input kosong',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Memasukkan email kosong
    await tester.enterText(find.byType(TextField).at(0), '');
    await tester.enterText(find.byType(TextField).at(1), '');

    // Mencari tombol login dan menekan tombol tersebut
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Memastikan ada validasi yang tampil untuk email dan password kosong
    expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);
  });

  testWidgets('Validasi Login dengan email yang tidak valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Memasukkan email yang tidak valid
    await tester.enterText(find.byType(TextField).at(0), 'invalidemail');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Mencari tombol login dan menekan tombol tersebut
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Memastikan ada validasi untuk email yang tidak valid
    expect(find.text('Format email tidak valid'), findsOneWidget);
  });

  // Tes Login Berhasil
  testWidgets('LoginPage login berhasil dengan input valid',
      (WidgetTester tester) async {
    // Menggunakan widget yang sudah ada di aplikasi
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Memasukkan email dan password yang valid
    await tester.enterText(
        find.byType(TextField).at(0), 'validemail@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Menekan tombol login
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(); // Tunggu sampai animasi selesai

    // Verifikasi jika halaman utama (HomePage) muncul
    expect(find.text('Daftar Catatan'), findsOneWidget);
  });
}
