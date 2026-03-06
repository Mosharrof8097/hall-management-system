import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ManagerAccountPage extends StatelessWidget {
  const ManagerAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Monthly summary mock data
    final double totalCollection = 112000;
    final double totalBazar = 72000;
    final double utilityOther = 5000;
    final double balance = totalCollection - totalBazar - utilityOther;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mill Account (Ledger)', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text('Monthly income, expenses and balance', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),

          // Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.managerGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('February 2026 — Net Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Text('৳ ${balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(children: [
                _balanceChip('Collection', '৳ ${totalCollection.toStringAsFixed(0)}', Icons.arrow_downward),
                const SizedBox(width: 16),
                _balanceChip('Bazar', '৳ ${totalBazar.toStringAsFixed(0)}', Icons.arrow_upward),
                const SizedBox(width: 16),
                _balanceChip('Utilities', '৳ ${utilityOther.toStringAsFixed(0)}', Icons.arrow_upward),
              ]),
            ]),
          ),

          const SizedBox(height: 28),

          // Settings + Ledger Row
          Wrap(spacing: 20, runSpacing: 20, children: [
            // Meal Rate Setting
            Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: _cardDeco(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Meal Rate Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: '32',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Per Meal Rate (৳)', border: OutlineInputBorder(), suffixText: '৳'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: '1200',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Room Rent (৳)', border: OutlineInputBorder(), suffixText: '৳'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.manager),
                    child: const Text('Update Rates', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]),
            ),

            // Ledger Table
            Container(
              width: 620,
              padding: const EdgeInsets.all(20),
              decoration: _cardDeco(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Monthly Ledger', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download, size: 16), label: const Text('Export')),
                ]),
                const SizedBox(height: 16),
                DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                  columns: const [
                    DataColumn(label: Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Type',        style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Amount',      style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: const [
                    DataRow(cells: [DataCell(Text('Meal Collection')),  DataCell(Text('Income',  style: TextStyle(color: AppColors.success))), DataCell(Text('৳ 95,000'))]),
                    DataRow(cells: [DataCell(Text('Room Rent')),         DataCell(Text('Income',  style: TextStyle(color: AppColors.success))), DataCell(Text('৳ 17,000'))]),
                    DataRow(cells: [DataCell(Text('Total Bazar Cost')),  DataCell(Text('Expense', style: TextStyle(color: AppColors.error))),   DataCell(Text('৳ 72,000'))]),
                    DataRow(cells: [DataCell(Text('Utility (Water)')),   DataCell(Text('Expense', style: TextStyle(color: AppColors.error))),   DataCell(Text('৳ 3,000'))]),
                    DataRow(cells: [DataCell(Text('Salary (Cook)')),     DataCell(Text('Expense', style: TextStyle(color: AppColors.error))),   DataCell(Text('৳ 2,000'))]),
                    DataRow(cells: [DataCell(Text('Net Balance', style: TextStyle(fontWeight: FontWeight.bold))), DataCell(Text('—')), DataCell(Text('৳ 35,000', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.success)))]),
                  ],
                ),
              ]),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _balanceChip(String label, String value, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.white70, size: 14),
      const SizedBox(width: 6),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
      ]),
    ]),
  );

  BoxDecoration _cardDeco() => BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
  );
}
