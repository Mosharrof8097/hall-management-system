import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdminBillingPage extends StatefulWidget {
  const AdminBillingPage({super.key});

  @override
  State<AdminBillingPage> createState() => _AdminBillingPageState();
}

class _AdminBillingPageState extends State<AdminBillingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _bills = [
    {'id': 'INV-001', 'student': 'Mosharrof Hossain', 'sid': '2020-1-60-001', 'room': '101-A', 'rent': 1200, 'meal': 3500, 'other': 200, 'total': 4900, 'paid': 4900, 'status': 'Paid', 'month': 'Feb 2026'},
    {'id': 'INV-002', 'student': 'Arafat Rahman',    'sid': '2021-1-60-032', 'room': '204-B', 'rent': 1200, 'meal': 3200, 'other': 0,   'total': 4400, 'paid': 0,    'status': 'Unpaid', 'month': 'Feb 2026'},
    {'id': 'INV-003', 'student': 'Rakib Hasan',      'sid': '2022-1-60-015', 'room': '305-A', 'rent': 1200, 'meal': 2900, 'other': 500, 'total': 4600, 'paid': 2000, 'status': 'Partial', 'month': 'Feb 2026'},
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Billing', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Manage monthly bills and payments', style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download_outlined),
                    label: const Text('Export'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showGenerateBillDialog(context),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Generate Bill', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Summary Cards
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
              children: [
                _summaryCard('Total Billed', '৳ 1,38,500', Icons.receipt_long, const Color(0xFF3B82F6), const Color(0xFFEFF6FF)),
                _summaryCard('Total Collected', '৳ 1,12,000', Icons.check_circle_outline, AppColors.success, AppColors.successLight),
                _summaryCard('Pending Dues', '৳ 26,500', Icons.pending_actions, AppColors.warning, AppColors.warningLight),
                _summaryCard('Overdue Bills', '12', Icons.warning_amber_rounded, AppColors.error, AppColors.errorLight),
              ],
            );
          }),

          const SizedBox(height: 24),

          // Filter Tabs & Table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters Row
                Row(
                  children: [
                    SizedBox(
                      width: 260,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Search by student/ID...', prefixIcon: const Icon(Icons.search, size: 20), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownMenu<String>(
                      initialSelection: 'All',
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 'All', label: 'All Status'),
                        DropdownMenuEntry(value: 'Paid', label: 'Paid'),
                        DropdownMenuEntry(value: 'Unpaid', label: 'Unpaid'),
                        DropdownMenuEntry(value: 'Partial', label: 'Partial'),
                      ],
                      onSelected: (val) {},
                    ),
                    const SizedBox(width: 12),
                    DropdownMenu<String>(
                      initialSelection: 'Feb 2026',
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 'Feb 2026', label: 'Feb 2026'),
                        DropdownMenuEntry(value: 'Jan 2026', label: 'Jan 2026'),
                      ],
                      onSelected: (val) {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Table
                LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.grey[100]),
                        columns: const [
                          DataColumn(label: Text('Invoice', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Month', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Rent', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Meal', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Other', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Paid', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: _bills.map((b) {
                          Color statusColor;
                          Color statusBg;
                          if (b['status'] == 'Paid') { statusColor = AppColors.success; statusBg = AppColors.successLight; }
                          else if (b['status'] == 'Unpaid') { statusColor = AppColors.error; statusBg = AppColors.errorLight; }
                          else { statusColor = AppColors.warning; statusBg = AppColors.warningLight; }

                          return DataRow(cells: [
                            DataCell(Text(b['id'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(b['student'], style: const TextStyle(fontWeight: FontWeight.w500)),
                              Text(b['sid'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ])),
                            DataCell(Text(b['month'])),
                            DataCell(Text('৳${b['rent']}')),
                            DataCell(Text('৳${b['meal']}')),
                            DataCell(Text('৳${b['other']}')),
                            DataCell(Text('৳${b['total']}', style: const TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('৳${b['paid']}', style: TextStyle(color: b['paid'] == b['total'] ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold))),
                            DataCell(Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                              child: Text(b['status'], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                            )),
                            DataCell(Row(children: [
                              IconButton(icon: const Icon(Icons.visibility, color: Colors.blue, size: 20), onPressed: () {}, tooltip: 'View'),
                              IconButton(icon: const Icon(Icons.payment, color: AppColors.success, size: 20), onPressed: () {}, tooltip: 'Record Payment'),
                              IconButton(icon: const Icon(Icons.print, color: Colors.grey, size: 20), onPressed: () {}, tooltip: 'Print'),
                            ])),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 26)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ])),
      ]),
    );
  }

  void _showGenerateBillDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Generate Monthly Bills'),
      content: SizedBox(width: 400, child: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownMenu<String>(
          label: const Text('Select Month'),
          width: 360,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'mar2026', label: 'March 2026'),
            DropdownMenuEntry(value: 'feb2026', label: 'February 2026'),
          ],
          onSelected: (val) {},
        ),
        const SizedBox(height: 16),
        TextFormField(decoration: const InputDecoration(labelText: 'Room Rent (৳)', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextFormField(decoration: const InputDecoration(labelText: 'Other Charges (৳)', border: OutlineInputBorder())),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(8)), child: const Row(children: [
          Icon(Icons.info_outline, color: AppColors.info, size: 18),
          SizedBox(width: 8),
          Expanded(child: Text('Meal charges will be calculated automatically from meal logs.', style: TextStyle(fontSize: 12, color: AppColors.info))),
        ])),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bills generated successfully!'))); },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin),
          child: const Text('Generate', style: TextStyle(color: Colors.white)),
        ),
      ],
    ));
  }
}
