import 'package:equatable/equatable.dart';

class DashboardMetrics extends Equatable {
  final int totalUsers;
  final int activeSessions;
  final double revenue;

  const DashboardMetrics({
    required this.totalUsers,
    required this.activeSessions,
    required this.revenue,
  });

  @override
  List<Object?> get props => [totalUsers, activeSessions, revenue];
}
