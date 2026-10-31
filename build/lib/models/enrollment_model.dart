class EnrollmentSchedule {
  EnrollmentSchedule({required this.days, required this.timeSlot});

  factory EnrollmentSchedule.fromJson(Map<String, dynamic> json) {
    return EnrollmentSchedule(
      days: json['days']?.toString() ?? '',
      timeSlot: json['time_slot']?.toString() ?? '',
    );
  }

  final String days;
  final String timeSlot;

  Map<String, dynamic> toJson() {
    return {'days': days, 'time_slot': timeSlot};
  }
}

class PaymentInfo {
  PaymentInfo({
    required this.transactionId,
    required this.status,
    required this.amountPaid,
    required this.currency,
    required this.gateway,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      transactionId: json['transaction_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      amountPaid: (json['amount_paid'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? 'USD',
      gateway: json['gateway']?.toString() ?? 'PayPal',
    );
  }

  final String transactionId;
  final String status;
  final double amountPaid;
  final String currency;
  final String gateway;

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'status': status,
      'amount_paid': amountPaid,
      'currency': currency,
      'gateway': gateway,
    };
  }
}

class EnrollmentModel {
  EnrollmentModel({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.selectedSchedule,
    required this.paymentInfo,
    required this.enrolledAt,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['_id'].toString(),
      studentId: json['student_id'].toString(),
      courseId: json['course_id'].toString(),
      selectedSchedule: EnrollmentSchedule.fromJson(
        json['selected_schedule'] as Map<String, dynamic>? ?? {},
      ),
      paymentInfo: PaymentInfo.fromJson(
        json['payment_info'] as Map<String, dynamic>? ?? {},
      ),
      enrolledAt: json['enrolled_at']?.toString() ?? '',
    );
  }

  final String id;
  final String studentId;
  final String courseId;
  final EnrollmentSchedule selectedSchedule;
  final PaymentInfo paymentInfo;
  final String enrolledAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'course_id': courseId,
      'selected_schedule': selectedSchedule.toJson(),
      'payment_info': paymentInfo.toJson(),
      'enrolled_at': enrolledAt,
    };
  }
}