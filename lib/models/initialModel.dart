class initialTarget {
  final int point;
  final int GA;
  final int orangeCash;
  final int adsl;
  final int home4g;
  final int devices;
  final int pointper;
  final int GAper;
  final int orangeCashper;
  final int adslper;
  final double home4gper;
  final double devicesper;

  initialTarget({
    required this.point,
    required this.GA,
    required this.orangeCash,
    required this.adsl,
    required this.home4g,
    required this.devices,
    required this.pointper,
    required this.GAper,
    required this.orangeCashper,
    required this.adslper,
    required this.home4gper,
    required this.devicesper,
  });
  Map<String, dynamic> toMap() {
    return {
      'points': point,
      'GA': GA,
      'orangeCash': orangeCash,
      'adsl': adsl,
      'home4g': home4g,
      'devices': devices,
      'pointper': pointper,
      'GAper': GAper,
      'orangeCashper': orangeCashper,
      'adslper': adslper,
      'home4gper': home4gper,
      'devicesper': devicesper,
    };
  }

  factory initialTarget.fromMap(Map<String, dynamic> map) {
    return initialTarget(
      point: map['points'] ?? 0,
      GA: map['GA'] ?? 0,
      orangeCash: map['orangeCash'] ?? 0,
      adsl: map['adsl'] ?? 0,
      home4g: map['home4g'] ?? 0,
      devices: map['devices'] ?? 0,
      pointper: map['pointper'] ?? 0,
      GAper: map['GAper'] ?? 0,
      orangeCashper: map['orangeCashper'] ?? 0,
      adslper: map['adslper'] ?? 0,
      home4gper: map['home4gper'] ?? 0.0,
      devicesper: map['devicesper'] ?? 0.0,
    );
  }
}
