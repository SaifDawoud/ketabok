class Ayat {
  int nomorAyat;
  String teksArab;
  String teksLatin;
  String teksIndonesia;
  Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
    nomorAyat: json["nomorAyat"],
    teksArab: json["teksArab"],
    teksLatin: json["teksLatin"],
    teksIndonesia: json["teksIndonesia"],
    audio: Map.from(json["audio"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "nomorAyat": nomorAyat,
    "teksArab": teksArab,
    "teksLatin": teksLatin,
    "teksIndonesia": teksIndonesia,
    "audio": Map.from(audio).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
