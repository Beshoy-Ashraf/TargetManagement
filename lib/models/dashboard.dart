class DashBoard {
  final int totalPoints;
  final int totalGA;
  final int totalOC;
  final int totalHome4G;
  final int totalDevices;
  final int totalDsl;
  final int pointKpi;
  final int GAKpi;
  final int OCKpi;
  final int Home4GKpi;
  final int DevicesKpi;
  final int DSLKpi;
  final int point;
  final int GA;
  final int OC;
  final int Home4G;
  final int Devices;
  final int DSL;
  final int pointper;
  final int GAper;
  final int OCper;
  final int DSLper;
  final int Home4Gper;
  final int Devicesper;
  final int totalKpi;

  DashBoard({
    required this.totalPoints,
    required this.totalGA,
    required this.totalOC,
    required this.totalHome4G,
    required this.totalDsl,
    required this.totalDevices,
    required this.pointKpi,
    required this.GAKpi,
    required this.OCKpi,
    required this.Home4GKpi,
    required this.DevicesKpi,
    required this.DSLKpi,
    required this.point,
    required this.GA,
    required this.OC,
    required this.Home4G,
    required this.Devices,
    required this.DSL,
    required this.pointper,
    required this.GAper,
    required this.OCper,
    required this.Home4Gper,
    required this.Devicesper,
    required this.DSLper,
    required this.totalKpi,
  });
  Map<String, dynamic> toMap() {
    return {
      'totalPoints': totalPoints,
      'totalGA': totalGA,
      'totalOC': totalOC,
      'totalHome4G': totalHome4G,
      'totalDevices': totalDevices,
      'totalDsl': totalDsl,
      'pointKpi': pointKpi,
      'GAKpi': GAKpi,
      'OCKpi': OCKpi,
      'Home4GKpi': Home4GKpi,
      'DevicesKpi': DevicesKpi,
      'DSLKpi': DSLKpi,
      'point': point,
      'GA': GA,
      'OC': OC,
      'Home4G': Home4G,
      'Devices': Devices,
      'DSL': DSL,
      'pointper': pointper,
      'GAper': GAper,
      'OCper': OCper,
      'Home4Gper': Home4Gper,
      'Devicesper': Devicesper,
      'DSLper': DSLper,
      'totalKpi': totalKpi,
    };
  }

  factory DashBoard.fromMap(Map<String, dynamic> map) {
    return DashBoard(
      totalPoints: map['totalPoints'] ?? 0,
      totalGA: map['totalGA'] ?? 0,
      totalOC: map['totalOC'] ?? 0,
      totalHome4G: map['totalHome4G'] ?? 0,
      totalDevices: map['totalDevices'] ?? 0,
      totalDsl: map['totalDsl'] ?? 0,
      pointKpi: map['pointKpi'] ?? 0,
      GAKpi: map['GAKpi'] ?? 0,
      OCKpi: map['OCKpi'] ?? 0,
      Home4GKpi: map['Home4GKpi'] ?? 0,
      DevicesKpi: map['DevicesKpi'] ?? 0,
      DSLKpi: map['DSLKpi'] ?? 0,
      point: map['point'] ?? 0,
      GA: map['GA'] ?? 0,
      OC: map['OC'] ?? 0,
      Home4G: map['Home4G'] ?? 0,
      Devices: map['Devices'] ?? 0,
      DSL: map['DSL'] ?? 0,
      pointper: map['pointper'] ?? 0,
      GAper: map['GAper'] ?? 0,
      OCper: map['OCper'] ?? 0,
      Home4Gper: map['Home4Gper'] ?? 0,
      Devicesper: map['Devicesper'] ?? 0,
      DSLper: map['DSLper'] ?? 0,
      totalKpi: map['totalKpi'] ?? 0,
    );
  }
}
