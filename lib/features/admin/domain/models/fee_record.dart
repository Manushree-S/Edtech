enum FeeStatus {
  pending,
  paid,
  overdue;

  String get id => name;

  static FeeStatus fromString(String? val) {
    if (val == null) return FeeStatus.pending;
    return switch (val.toLowerCase()) {
      'paid' => FeeStatus.paid,
      'overdue' => FeeStatus.overdue,
      _ => FeeStatus.pending,
    };
  }
}

class FeeRecord {
  final String id;
  final String studentId;
  final String studentName;
  final String title;
  final double amount;
  final DateTime dueDate;
  final FeeStatus status;
  final DateTime? paidAt;
  final String? receiptNumber;
  final String? paymentMethod;

  const FeeRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.title,
    required this.amount,
    required this.dueDate,
    this.status = FeeStatus.pending,
    this.paidAt,
    this.receiptNumber,
    this.paymentMethod,
  });

  FeeRecord copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? title,
    double? amount,
    DateTime? dueDate,
    FeeStatus? status,
    DateTime? paidAt,
    String? receiptNumber,
    String? paymentMethod,
  }) {
    return FeeRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'title': title,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'status': status.id,
      'paidAt': paidAt?.toIso8601String(),
      'receiptNumber': receiptNumber,
      'paymentMethod': paymentMethod,
    };
  }

  factory FeeRecord.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return FeeRecord(
      id: documentId ?? map['id'] ?? '',
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      status: FeeStatus.fromString(map['status'] as String?),
      paidAt: map['paidAt'] != null
          ? DateTime.tryParse(map['paidAt'].toString())
          : null,
      receiptNumber: map['receiptNumber'] as String?,
      paymentMethod: map['paymentMethod'] as String?,
    );
  }
}
