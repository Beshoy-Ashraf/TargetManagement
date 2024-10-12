class Target {
  final String day;
  final int point;
  final int GA;
  final int orangeCash;
  final int adsl;
  final int home4g;
  final int devices;

  Target({
    required this.day,
    required this.point,
    required this.GA,
    required this.orangeCash,
    required this.adsl,
    required this.home4g,
    required this.devices,
  });
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'points': point,
      'GA': GA,
      'orangeCash': orangeCash,
      'adsl': adsl,
      'home4g': home4g,
      'devices': devices,
    };
  }

  factory Target.fromMap(Map<String, dynamic> map) {
    return Target(
      day: map['day'] ?? '',
      point: map['points'] ?? 0,
      GA: map['GA'] ?? 0,
      orangeCash: map['orangeCash'] ?? 0,
      adsl: map['adsl'] ?? 0,
      home4g: map['home4g'] ?? 0,
      devices: map['devices'] ?? 0,
    );
  }
}
