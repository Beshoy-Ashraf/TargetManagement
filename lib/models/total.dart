class Total {
  final int point;
  final int GA;
  final int orangeCash;
  final int adsl;
  final int home4g;
  final int devices;

  Total({
    required this.point,
    required this.GA,
    required this.orangeCash,
    required this.adsl,
    required this.home4g,
    required this.devices,
  });
  Map<String, dynamic> toMap() {
    return {
      'totalPoints': point,
      'totalGA': GA,
      'totalOC': orangeCash,
      'totalDsl': adsl,
      'totalHome4G': home4g,
      'totalDevices': devices,
    };
  }

  factory Total.fromMap(Map<String, dynamic> map) {
    return Total(
      point: map['totalPoints'] ?? 0,
      GA: map['totalGA'] ?? 0,
      orangeCash: map['totalOC'] ?? 0,
      adsl: map['totalDsl'] ?? 0,
      home4g: map['totalHome4G'] ?? 0,
      devices: map['totalDevices'] ?? 0,
    );
  }
}
