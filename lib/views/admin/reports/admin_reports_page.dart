import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  State<AdminReportsPage> createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
                Text('Reports', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text('Download and view hall management reports', style: TextStyle(color: AppColors.textSecondary)),
              ]),
              Row(children: [
                DropdownMenu<String>(
                  initialSelection: 'feb2026',
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'feb2026', label: 'February 2026'),
                    DropdownMenuEntry(value: 'jan2026', label: 'January 2026'),
                  ],
                  onSelected: (val) {},
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_download, color: Colors.white),
                  label: const Text('Export All', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 20),

          // Summary Section
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 1000 ? 3 : 2;
            return GridView.count(
              crossAxisCount: cols, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 1.8,
              children: [
                _reportCard(
                  title: 'Financial Report',
                  subtitle: 'Total collection, dues & expenses summary',
                  icon: Icons.account_balance_wallet,
                  color: Colors.blue,
                  bg: const Color(0xFFEFF6FF),
                  items: const ['Total Billed: ৳1,38,500', 'Collected: ৳1,12,000', 'Pending: ৳26,500'],
                ),
                _reportCard(
                  title: 'Occupancy Report',
                  subtitle: 'Room allocation and vacancy status',
                  icon: Icons.meeting_room,
                  color: AppColors.success,
                  bg: AppColors.successLight,
                  items: const ['Total Rooms: 250', 'Occupied: 218', 'Available: 32'],
                ),
                _reportCard(
                  title: 'Meal Report',
                  subtitle: 'Daily meal usage and costs for the month',
                  icon: Icons.restaurant,
                  color: AppColors.warning,
                  bg: AppColors.warningLight,
                  items: const ['Total Meals: 28,440', 'Cost/Day: ৳18,200', 'Per Head: ৳32'],
                ),
              ],
            );
          }),
          const SizedBox(height: 24),

          // Detailed Tables with Tabs
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Detailed Monthly Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.admin,
                  labelColor: AppColors.admin,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [Tab(text: 'Billing'),  Tab(text: 'Occupancy'), Tab(text: 'Meal Log')],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 350,
                  child: TabBarView(controller: _tabController, children: [
                    _billingTable(),
                    _occupancyTable(),
                    _mealTable(),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportCard({required String title, required String subtitle, required IconData icon, required Color color, required Color bg, required List<String> items}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: bg, width: 2), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 24)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(subtitle, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ])),
        ]),
        const Divider(height: 20),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(children: [
            Icon(Icons.circle, size: 6, color: color),
            const SizedBox(width: 8),
            Text(item, style: const TextStyle(fontSize: 13)),
          ]),
        )),
        const Spacer(),
        Align(alignment: Alignment.centerRight, child: TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.download, size: 16, color: color),
          label: Text('Download', style: TextStyle(color: color, fontSize: 12)),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        )),
      ]),
    );
  }

  Widget _billingTable() {
    final rows = [
      ['Mosharrof Hossain', '101-A', '৳4,900', '৳4,900', 'Paid'],
      ['Arafat Rahman', '204-B', '৳4,400', '৳0', 'Unpaid'],
      ['Rakib Hasan', '305-A', '৳4,600', '৳2,000', 'Partial'],
    ];
    return SingleChildScrollView(
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
        columns: const [DataColumn(label: Text('Student')), DataColumn(label: Text('Room')), DataColumn(label: Text('Total')), DataColumn(label: Text('Paid')), DataColumn(label: Text('Status'))],
        rows: rows.map((r) {
          Color sc = r[4] == 'Paid' ? AppColors.success : r[4] == 'Unpaid' ? AppColors.error : AppColors.warning;
          return DataRow(cells: [...r.sublist(0, 4).map((c) => DataCell(Text(c))), DataCell(Text(r[4], style: TextStyle(color: sc, fontWeight: FontWeight.bold)))]);
        }).toList(),
      ),
    );
  }

  Widget _occupancyTable() {
    final rows = [['101', '2-Seater', '2', '2', 'Full'], ['102', '2-Seater', '2', '1', 'Available'], ['201', '2-Seater', '2', '2', 'Full'], ['202', '2-Seater', '2', '0', 'Maintenance']];
    return SingleChildScrollView(
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
        columns: const [DataColumn(label: Text('Room')), DataColumn(label: Text('Type')), DataColumn(label: Text('Capacity')), DataColumn(label: Text('Occupied')), DataColumn(label: Text('Status'))],
        rows: rows.map((r) {
          Color sc = r[4] == 'Full' ? AppColors.error : r[4] == 'Available' ? AppColors.success : AppColors.warning;
          return DataRow(cells: [...r.sublist(0, 4).map((c) => DataCell(Text(c))), DataCell(Text(r[4], style: TextStyle(color: sc, fontWeight: FontWeight.bold)))]);
        }).toList(),
      ),
    );
  }

  Widget _mealTable() {
    final rows = [['01 Mar', '340', '800', '৳10,880', '৳32'], ['02 Mar', '328', '780', '৳10,530', '৳32'], ['03 Mar', '345', '810', '৳11,040', '৳32']];
    return SingleChildScrollView(
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
        columns: const [DataColumn(label: Text('Date')), DataColumn(label: Text('Breakfast')), DataColumn(label: Text('Lunch+Dinner')), DataColumn(label: Text('Total Cost')), DataColumn(label: Text('Per Head'))],
        rows: rows.map((r) => DataRow(cells: r.map((c) => DataCell(Text(c))).toList())).toList(),
      ),
    );
  }
}
