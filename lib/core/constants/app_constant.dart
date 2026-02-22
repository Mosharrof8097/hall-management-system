

class AppConstants {
  AppConstants._(); // prevent instantiation

  


  // App Info
  static const String appName = 'Omor Ekushe Hall';
  static const String appVersion = '1.0.0';

  // Supabase Table Names
  static const String profilesTable = 'profiles';
  static const String seatsTable = 'seats';
  static const String applicationsTable = 'applications';
  static const String noticesTable = 'notices';

  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleManager = 'manager';
  static const String roleStudent = 'student';

  // Application Status
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';

  // Seat Status
  static const String seatAvailable = 'available';
  static const String seatOccupied = 'occupied';
  static const String seatReserved = 'reserved';
}