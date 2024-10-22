class Knowladgemodel {
  final String title;
  final String description;
  final String pdf;

  Knowladgemodel({
    required this.title,
    required this.description,
    required this.pdf,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'pdf': pdf,
    };
  }

  factory Knowladgemodel.fromMap(Map<String, dynamic> map) {
    return Knowladgemodel(
      title: map['title'],
      description: map['description'],
      pdf: map['pdf'],
    );
  }
}
