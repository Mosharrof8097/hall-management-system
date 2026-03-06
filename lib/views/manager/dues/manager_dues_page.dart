import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ManagerDuesPage extends StatefulWidget {
  const ManagerDuesPage({super.key});

  @override
  State<ManagerDuesPage> createState() => _ManagerDuesPageState();
}

class _ManagerDuesPageState extends State<ManagerDuesPage> {
  final List<Map<String, dynamic>> _duesList = [
    {'id': '2020-1-60-001', 'name': 'Mosharrof H.', 'room': '101-A', 'totalDue': 4900, 'paid': 4900, 'balance': 0, 'status': 'Clear'},
    {'id': '2021-1-60-032', 'name': 'Arafat Rahman', 'room': '204-B', 'totalDue': 4400, 'paid': 0, 'balance': 4400, 'status': 'Due'},
    {'id': '2022-1-60-015', 'name': 'Rakib Hasan', 'room': '305-A', 'totalDue': 4600, 'paid': 2000, 'balance': 2600, 'status': 'Partial'},
    {'id': '2023-1-60-045', 'name': 'Farhan Islam', 'room': '102-B', 'totalDue': 4400, 'paid': 4400, 'balance': 0, 'status': 'Clear'},
    {'id': '2022-1-60-022', 'name': 'Karim Ahmed', 'room': '301-A', 'totalDue': 4900, 'paid': 1000, 'balance': 3900, 'status': 'Due'},
  ];

  String _filter = 'All';

  List<Map<String, dynamic>> get _filtered => _filter == 'All' ? _duesList : _duesList.where((d) => d['status'] == _filter).toList();

  int get _totalDue => _duesList.fold(0, (s, d) => s + (d['balance'] as int));
  int get _cleared => _duesList.where((d) => d['status'] == 'Clear').length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Student Dues', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text('Track and record monthly payments', style: TextStyle(color: AppColors.textSecondary)),
            ]),
            ElevatedButton.icon(
              onPressed: () => _showPaymentDialog(context, null),
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text('Record Payment', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
            ),
          ]),
          const SizedBox(height: 20),

          // Stats
          Wrap(spacing: 16, runSpacing: 12, children: [
            _statChip('Total Outstanding', '৳ $_totalDue', AppColors.error, AppColors.errorLight),
            _statChip('Members Cleared', '$_cleared / ${_duesList.length}', AppColors.success, AppColors.successLight),
            _statChip('Partial Payments', '${_duesList.where((d) => d['status'] == 'Partial').length}', AppColors.warning, AppColors.warningLight),
          ]),
          const SizedBox(height: 24),

          // Table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                ...['All', 'Due', 'Partial', 'Clear'].map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(label: Text(f), selected: _filter == f, onSelected: (v) => setState(() => _filter = f),
                    selectedColor: AppColors.managerLight, checkmarkColor: AppColors.manager),
                )),
              ]),
              const SizedBox(height: 16),
              LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                    columns: const [
                      DataColumn(label: Text('Student ID', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Name',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Room',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Total Bill', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Paid',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Due',        style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status',     style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Action',     style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: _filtered.map((d) {
                      Color sc = d['status'] == 'Clear' ? AppColors.success : d['status'] == 'Partial' ? AppColors.warning : AppColors.error;
                      Color sb = d['status'] == 'Clear' ? AppColors.successLight : d['status'] == 'Partial' ? AppColors.warningLight : AppColors.errorLight;
                      return DataRow(cells: [
                        DataCell(Text(d['id'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataCell(Text(d['name'], style: const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(Text(d['room'])),
                        DataCell(Text('৳ ${d['totalDue']}')),
                        DataCell(Text('৳ ${d['paid']}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600))),
                        DataCell(Text('৳ ${d['balance']}', style: TextStyle(color: d['balance'] > 0 ? AppColors.error : Colors.grey, fontWeight: FontWeight.bold))),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(color: sb, borderRadius: BorderRadius.circular(20)),
                          child: Text(d['status'], style: TextStyle(color: sc, fontWeight: FontWeight.bold, fontSize: 12)),
                        )),
                        DataCell(d['balance'] > 0
                            ? TextButton(onPressed: () => _showPaymentDialog(context, d), style: TextButton.styleFrom(foregroundColor: AppColors.manager), child: const Text('Pay'))
                            : const Icon(Icons.check_circle, color: AppColors.success, size: 20)),
                      ]);
                    }).toList(),
                  ),
                ),
              )),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, String value, Color color, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Text('$label: ', style: TextStyle(color: color, fontSize: 13)),
      Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
    ]),
  );

  void _showPaymentDialog(BuildContext ctx, Map<String, dynamic>? student) {
    final amtCtrl = TextEditingController();
    showDialog(context: ctx, builder: (c) => AlertDialog(
      title: const Text('Record Payment'),
      content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (student != null) ...[
          ListTile(contentPadding: EdgeInsets.zero, title: Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Due: ৳ ${student['balance']}')),
          const Divider(),
        ],
        if (student == null) TextFormField(decoration: const InputDecoration(labelText: 'Student ID', border: OutlineInputBorder())),
        if (student == null) const SizedBox(height: 14),
        TextFormField(controller: amtCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Payment Amount (৳)', border: OutlineInputBorder())),
        const SizedBox(height: 14),
        TextFormField(decoration: const InputDecoration(labelText: 'Payment Method', hintText: 'Cash / bKash / Bank', border: OutlineInputBorder())),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(c);
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('✅ Payment recorded successfully!')));
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager),
          child: const Text('Confirm', style: TextStyle(color: Colors.white)),
        ),
      ],
    ));
  }
}
