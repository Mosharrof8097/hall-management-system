import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ManagerBazarPage extends StatefulWidget {
  const ManagerBazarPage({super.key});

  @override
  State<ManagerBazarPage> createState() => _ManagerBazarPageState();
}

class _ManagerBazarPageState extends State<ManagerBazarPage> {
  final _itemCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  final List<Map<String, dynamic>> _bazarEntries = [
    {'id': 'B-001', 'date': '07 Mar 2026', 'item': 'Rice (50 kg)', 'amount': 3000, 'category': 'Grain', 'by': 'Rahul S.'},
    {'id': 'B-002', 'date': '07 Mar 2026', 'item': 'Vegetables', 'amount': 1200, 'category': 'Vegetable', 'by': 'Rahul S.'},
    {'id': 'B-003', 'date': '06 Mar 2026', 'item': 'Chicken (10 kg)', 'amount': 4800, 'category': 'Protein', 'by': 'Sajid R.'},
    {'id': 'B-004', 'date': '06 Mar 2026', 'item': 'Oil + Spices', 'amount': 800, 'category': 'Other', 'by': 'Sajid R.'},
    {'id': 'B-005', 'date': '05 Mar 2026', 'item': 'Fish (8 kg)', 'amount': 3200, 'category': 'Protein', 'by': 'Rahul S.'},
  ];

  final Map<String, int> _totals = {'Grain': 3000, 'Vegetable': 1200, 'Protein': 8000, 'Other': 800};

  @override
  void dispose() {
    _itemCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayTotal = _bazarEntries.where((e) => e['date'] == '07 Mar 2026').fold(0, (sum, e) => sum + (e['amount'] as int));
    final monthTotal = _bazarEntries.fold(0, (sum, e) => sum + (e['amount'] as int));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Bazar / Cost Sheet', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text('Track daily grocery and cooking expenses', style: TextStyle(color: AppColors.textSecondary)),
            ]),
            ElevatedButton.icon(
              onPressed: () => _showAddBazarDialog(context),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Entry', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
            ),
          ]),
          const SizedBox(height: 20),

          // Quick Summary
          Wrap(spacing: 16, runSpacing: 16, children: [
            _summaryCard("Today's Total", "৳ $todayTotal", Icons.today, Colors.blue, const Color(0xFFEFF6FF)),
            _summaryCard("Month Total",   "৳ $monthTotal", Icons.calendar_month, AppColors.manager, AppColors.managerLight),
            ..._totals.entries.map((e) => _summaryCard(e.key, "৳ ${e.value}", Icons.category, Colors.grey, Colors.grey.shade100)),
          ]),
          const SizedBox(height: 24),

          // Bazar Table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Bazar Entries", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.file_download_outlined, size: 16), label: const Text('Export')),
              ]),
              const SizedBox(height: 16),
              LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                    columns: const [
                      DataColumn(label: Text('ID',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Date',     style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Item',     style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Amount',   style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('By',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Actions',  style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: _bazarEntries.map((b) {
                      final catColors = {'Grain': Colors.amber, 'Vegetable': Colors.green, 'Protein': Colors.red, 'Other': Colors.grey};
                      final c = catColors[b['category']] ?? Colors.grey;
                      return DataRow(cells: [
                        DataCell(Text(b['id'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataCell(Text(b['date'], style: const TextStyle(fontSize: 13))),
                        DataCell(Text(b['item'], style: const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                          child: Text(b['category'], style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 11)),
                        )),
                        DataCell(Text('৳ ${b['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.manager))),
                        DataCell(Text(b['by'], style: const TextStyle(fontSize: 13))),
                        DataCell(Row(children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 18), onPressed: () {}, tooltip: 'Edit'),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 18), onPressed: () {}, tooltip: 'Delete'),
                        ])),
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

  Widget _summaryCard(String title, String value, IconData icon, Color color, Color bg) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: bg, width: 1.5), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 20)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ])),
      ]),
    );
  }

  void _showAddBazarDialog(BuildContext context) {
    String selectedCategory = 'Grain';
    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, setS) => AlertDialog(
      title: const Text('Add Bazar Entry'),
      content: SizedBox(width: 400, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(controller: _itemCtrl, decoration: const InputDecoration(labelText: 'Item Name', border: OutlineInputBorder())),
        const SizedBox(height: 14),
        TextFormField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (৳)', border: OutlineInputBorder())),
        const SizedBox(height: 14),
        DropdownMenu<String>(
          label: const Text('Category'),
          width: 360,
          initialSelection: selectedCategory,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'Grain', label: 'Grain'),
            DropdownMenuEntry(value: 'Vegetable', label: 'Vegetable'),
            DropdownMenuEntry(value: 'Protein', label: 'Protein'),
            DropdownMenuEntry(value: 'Other', label: 'Other'),
          ],
          onSelected: (v) => setS(() => selectedCategory = v!),
        ),
        const SizedBox(height: 14),
        TextFormField(controller: _noteCtrl, decoration: const InputDecoration(labelText: 'Note (optional)', border: OutlineInputBorder())),
      ])),
      actions: [
        TextButton(onPressed: () { _itemCtrl.clear(); _amountCtrl.clear(); _noteCtrl.clear(); Navigator.pop(ctx); }, child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Bazar entry added!')));
            _itemCtrl.clear(); _amountCtrl.clear(); _noteCtrl.clear();
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager),
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ],
    )));
  }
}
