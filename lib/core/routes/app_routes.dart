class AppRoutes {
  AppRoutes._();

  static const splash        = '/';
  static const landing       = '/landing';
  static const roleSelection = '/role-selection';
  static const login         = '/login';
  static const register      = '/register';

  // Admin
  static const adminDashboard  = '/admin/dashboard';
  static const adminStudents   = '/admin/students';
  static const adminManagers   = '/admin/managers';
  static const adminRooms      = '/admin/rooms';
  static const adminBilling    = '/admin/billing';
  static const adminNotices    = '/admin/notices';
  static const adminVacancy    = '/admin/vacancy';
  static const adminReports    = '/admin/reports';
  static const adminSettings   = '/admin/settings';
  static const adminComplaints = '/admin/complaints';

  // Manager
  static const managerDashboard  = '/manager/dashboard';
  static const managerMeal       = '/manager/meal';
  static const managerBazar      = '/manager/bazar';
  static const managerAccount    = '/manager/account';
  static const managerDues       = '/manager/dues';
  static const managerNotices    = '/manager/notices';
  static const managerComplaints = '/manager/complaints';

  // Student
  static const studentDashboard  = '/student/dashboard';
  static const studentMeal       = '/student/meal';
  static const studentDues       = '/student/dues';
  static const studentNotices    = '/student/notices';
  static const studentComplaints = '/student/complaints';
  static const studentProfile    = '/student/profile';
}