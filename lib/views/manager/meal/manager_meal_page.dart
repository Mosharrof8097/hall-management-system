import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ManagerMealPage extends StatefulWidget {
  const ManagerMealPage({super.key});

  @override
  State<ManagerMealPage> createState() => _ManagerMealPageState();
}

class _ManagerMealPageState extends State<ManagerMealPage> {
  final _mealCtrl = TextEditingController();
  final _breakfastCtrl = TextEditingController();
  final _lunchCtrl = TextEditingController();
  final _dinnerCtrl = TextEditingController();

  final List<Map<String, dynamic>> _mealLog = [
    {'date': '06 Mar 2026', 'breakfast': 120, 'lunch': 230, 'dinner': 195, 'total': 545, 'perMeal': 32, 'totalCost': '৳ 17,440'},
    {'date': '05 Mar 2026', 'breakfast': 115, 'lunch': 228, 'dinner': 190, 'total': 533, 'perMeal': 32, 'totalCost': '৳ 17,056'},
    {'date': '04 Mar 2026', 'breakfast': 118, 'lunch': 235, 'dinner': 200, 'total': 553, 'perMeal': 32, 'totalCost': '৳ 17,696'},
    {'date': '03 Mar 2026', 'breakfast': 110, 'lunch': 220, 'dinner': 185, 'total': 515, 'perMeal': 32, 'totalCost': '৳ 16,480'},
  ];

  @override
  void dispose() {
    _mealCtrl.dispose();
    _breakfastCtrl.dispose();
    _lunchCtrl.dispose();
    _dinnerCtrl.dispose();
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Daily Meal Entry', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text('Record daily meal counts per shift', style: TextStyle(color: AppColors.textSecondary)),
            ]),
            Text('Today: 07 Mar 2026', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          ]),
          const SizedBox(height: 24),

          // Entry Form
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.managerLight, width: 2),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Add Today's Meal Count", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Wrap(spacing: 16, runSpacing: 16, children: [
                _mealInput(_breakfastCtrl, 'Breakfast Count', Icons.wb_sunny_outlined, Colors.orange),
                _mealInput(_lunchCtrl, 'Lunch Count', Icons.wb_sunny, Colors.amber),
                _mealInput(_dinnerCtrl, 'Dinner Count', Icons.nights_stay_outlined, Colors.indigo),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                const Icon(Icons.info_outline, size: 16, color: AppColors.info),
                const SizedBox(width: 6),
                Text('Per Meal Rate: ৳ 32 (Set in Mill Account)', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Meal count saved for today!')));
                    _breakfastCtrl.clear();
                    _lunchCtrl.clear();
                    _dinnerCtrl.clear();
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text("Save Entry", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager, padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 28),

          // Meal Log Table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Recent Meal Log", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                    columns: const [
                      DataColumn(label: Text('Date',       style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Breakfast',  style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Lunch',      style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Dinner',     style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Total',      style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Per Meal',   style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Total Cost', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: _mealLog.map((m) => DataRow(cells: [
                      DataCell(Text(m['date'], style: const TextStyle(fontWeight: FontWeight.w500))),
                      DataCell(Text('${m['breakfast']}')),
                      DataCell(Text('${m['lunch']}')),
                      DataCell(Text('${m['dinner']}')),
                      DataCell(Text('${m['total']}', style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text('৳ ${m['perMeal']}')),
                      DataCell(Text(m['totalCost'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.manager))),
                    ])).toList(),
                  ),
                ),
              )),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _mealInput(TextEditingController ctrl, String label, IconData icon, Color color) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: color),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2)),
        ),
      ),
    );
  }
}
