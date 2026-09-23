class Institution {
  final String id;
  final String name;
  final String code;
  final bool isActive;
  final DateTime? createdAt;

  const Institution({
    required this.id,
    required this.name,
    required this.code,
    this.isActive = true,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Institution.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Institution(
      id: documentId ?? map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      isActive: map['isActive'] as bool? ?? true,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
    );
  }
}
