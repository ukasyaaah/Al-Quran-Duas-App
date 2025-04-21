class Doa {
  final int id;
  final String judul;
  final String arab;
  final String terjemah;

  Doa({
    required this.id,
    required this.judul,
    required this.arab,
    required this.terjemah,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      id: json['id'],
      judul: json['judul'],
      arab: json['arab'],
      terjemah: json['terjemah'],
    );
  }
}
