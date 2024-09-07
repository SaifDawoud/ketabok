import 'dart:convert';

import 'ayat.dart';

List<Sura> suraFromJson(String str) =>
    List<Sura>.from(json.decode(str).map((x) => Sura.fromJson(x)));

String suraToJson(List<Sura> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sura {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  Map<String, String> audioFull;
  List<Ayat>? ayat;

  Sura({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.audioFull,
    this.ayat,
  });

  factory Sura.fromJson(Map<String, dynamic> json) {
    return Sura(
        nomor: json["nomor"],
        nama: json['nama'],
        namaLatin: json['namaLatin'],
        jumlahAyat: json['jumlahAyat'],
        tempatTurun: json['tempatTurun'],
        audioFull: Map.from(json["audioFull"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        ayat: json.containsKey('ayat')
            ? List<Ayat>.from(json["ayat"]!.map((x) => Ayat.fromJson(x)))
            : null);
  }

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurn": tempatTurun,
        "audioFull":
            Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ayat": ayat
      };
}
