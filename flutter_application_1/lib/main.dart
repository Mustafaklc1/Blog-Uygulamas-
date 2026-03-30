import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(Duration(seconds: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Iskele());
  }
}

class Iskele extends StatefulWidget {
  const Iskele({super.key});

  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();

  Future<void> yaziEkle() async {
    if (t1.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('Yazilar').doc(t1.text).set({
      'baslik': t1.text,
      'icerik': t2.text,
    });
    debugPrint('Yazı Eklendi');
  }

  Future<void> yaziGuncelle() async {
    if (t1.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('Yazilar').doc(t1.text).update({
      'baslik': t1.text,
      'icerik': t2.text,
    });
    debugPrint('Yazı Güncellendi');
  }

  Future<void> yaziSil() async {
    if (t1.text.isEmpty) return;
    await FirebaseFirestore.instance
        .collection('Yazilar')
        .doc(t1.text)
        .delete();
    debugPrint('Yazı Silindi');
  }

  @override
  void dispose() {
    t1.dispose();
    t2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: t1,
                decoration: const InputDecoration(labelText: 'Başlık'),
              ),
              TextField(
                controller: t2,
                decoration: const InputDecoration(labelText: 'İçerik'),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => yaziEkle(),
                    child: const Text("Ekle"),
                  ),
                  ElevatedButton(
                    onPressed: () => yaziGuncelle(),
                    child: const Text("Guncelle"),
                  ),
                  ElevatedButton(
                    onPressed: () => yaziSil(),
                    child: Text("Sil"),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Kayıt Ol")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
