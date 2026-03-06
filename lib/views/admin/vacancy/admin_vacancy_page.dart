import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdminVacancyPage extends StatefulWidget {
  const AdminVacancyPage({super.key});

  @override
  State<AdminVacancyPage> createState() => _AdminVacancyPageState();
}

class _AdminVacancyPageState extends State<AdminVacancyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _applications = [
    {'id': 'APP-001', 'name': 'Shahriar Hossain', 'sid': '2023-1-60-045', 'dept': 'CSE', 'year': '1st', 'pref': '2-Seater', 'date': '01 Mar 2026', 'status': 'Pending'},
    {'id': 'APP-002', 'name': 'Farhan Islam',     'sid': '2023-1-60-052', 'dept': 'EEE', 'year': '1st', 'pref': '4-Seater', 'date': '02 Mar 2026', 'status': 'Pending'},
    {'id': 'APP-003', 'name': 'Mehedi Hasan',     'sid': '2022-1-60-019', 'dept': 'ME',  'year': '2nd', 'pref': '2-Seater', 'date': '28 Feb 2026', 'status': 'Approved'},
    {'id': 'APP-004', 'name': 'Sabbir Ahmed',     'sid': '2023-1-60-061', 'dept': 'CE',  'year': '1st', 'pref': 'Any',      'date': '27 Feb 2026', 'status': 'Rejected'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _pending => _applications.where((a) => a['status'] == 'Pending').toList();
  List<Map<String, dynamic>> get _approved => _applications.where((a) => a['status'] == 'Approved').toList();
  List<Map<String, dynamic>> get _rejected => _applications.where((a) => a['status'] == 'Rejected').toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Room Vacancy Applications', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text('Review and approve seat allocation requests', style: TextStyle(color: AppColors.textSecondary)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: AppColors.warningLight, borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  const Icon(Icons.pending_actions, color: AppColors.warning, size: 20),
                  const SizedBox(width: 8),
                  Text('${_pending.length} Pending Reviews', style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Tab Bar
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.admin,
                  labelColor: AppColors.admin,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Pending (${_pending.length})'),
                    Tab(text: 'Approved (${_approved.length})'),
                    Tab(text: 'Rejected (${_rejected.length})'),
                  ],
                ),
                SizedBox(
                  height: 420,
                  child: TabBarView(controller: _tabController, children: [
                    _buildTable(_pending, isPending: true),
                    _buildTable(_approved),
                    _buildTable(_rejected),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<Map<String, dynamic>> data, {bool isPending = false}) {
    if (data.isEmpty) {
      return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.inbox, size: 48, color: Colors.grey),
        SizedBox(height: 12),
        Text('No applications here', style: TextStyle(color: Colors.grey)),
      ]));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
          columns: [
            const DataColumn(label: Text('App. ID', style: TextStyle(fontWeight: FontWeight.bold))),
            const DataColumn(label: Text('Applicant', style: TextStyle(fontWeight: FontWeight.bold))),
            const DataColumn(label: Text('Dept/Year', style: TextStyle(fontWeight: FontWeight.bold))),
            const DataColumn(label: Text('Room Pref.', style: TextStyle(fontWeight: FontWeight.bold))),
            const DataColumn(label: Text('Applied On', style: TextStyle(fontWeight: FontWeight.bold))),
            const DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            if (isPending) const DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: data.map((app) {
            Color sc = app['status'] == 'Approved' ? AppColors.success : app['status'] == 'Rejected' ? AppColors.error : AppColors.warning;
            Color sb = app['status'] == 'Approved' ? AppColors.successLight : app['status'] == 'Rejected' ? AppColors.errorLight : AppColors.warningLight;

            return DataRow(cells: [
              DataCell(Text(app['id'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
              DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(app['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(app['sid'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ])),
              DataCell(Text('${app['dept']} · ${app['year']} Year')),
              DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.adminLight, borderRadius: BorderRadius.circular(4)),
                child: Text(app['pref'], style: const TextStyle(fontSize: 12, color: AppColors.admin)),
              )),
              DataCell(Text(app['date'])),
              DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: sb, borderRadius: BorderRadius.circular(20)),
                child: Text(app['status'], style: TextStyle(color: sc, fontWeight: FontWeight.bold, fontSize: 12)),
              )),
              if (isPending) DataCell(Row(children: [
                ElevatedButton(
                  onPressed: () => setState(() => app['status'] = 'Approved'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: const Size(0, 32)),
                  child: const Text('Approve', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => setState(() => app['status'] = 'Rejected'),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: const Size(0, 32)),
                  child: const Text('Reject', style: TextStyle(fontSize: 12)),
                ),
              ])),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
