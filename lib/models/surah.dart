class Surah {
  final int id;
  final String nama;
  final int nomor;
  final int jumlahAyat;
  final String tempatTurun;

  Surah({
    required this.id,
    required this.nama,
    required this.nomor,
    required this.jumlahAyat,
    required this.tempatTurun,
  });

 factory Surah.fromJson(Map<String, dynamic> json) {
  print("Processing Surah JSON: $json");
  try {
    return Surah(
      id: _parseIntSafely(json['id']),
      nama: json['nama']?.toString() ?? '',
      nomor: _parseIntSafely(json['nomor']),
      jumlahAyat: _parseIntSafely(json['jumlah_ayat']),
      tempatTurun: json['tempat_turun']?.toString() ?? '',
    );
  } catch (e) {
    print("Error parsing Surah from JSON: $e");
    throw Exception("Error parsing Surah from JSON: $e");
  }
}

// Helper method to safely parse integers
static int _parseIntSafely(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}
}
