import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StudentDuesPage extends StatelessWidget {
  const StudentDuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = [
      {'month': 'March 2026', 'rent': 1200, 'meal': 3500, 'other': 0, 'total': 4700, 'paid': 0, 'status': 'Unpaid'},
      {'month': 'February 2026', 'rent': 1200, 'meal': 3700, 'other': 200, 'total': 5100, 'paid': 5100, 'status': 'Paid'},
      {'month': 'January 2026', 'rent': 1200, 'meal': 3400, 'other': 0, 'total': 4600, 'paid': 4600, 'status': 'Paid'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Dues & Bills', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text('View your billing history and outstanding dues', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),

          // Outstanding Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.error.withValues(alpha: 0.9), AppColors.error.withValues(alpha: 0.7)]), borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Outstanding Due', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const Text('৳ 4,700', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const Text('March 2026 bill not paid', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payment, size: 18),
                label: const Text('Pay Now'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.error),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          // Bill Cards
          ...bills.map((b) {
            final isPaid = b['status'] == 'Paid';
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isPaid ? AppColors.successLight : AppColors.errorLight, width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
              ),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(b['month'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: isPaid ? AppColors.successLight : AppColors.errorLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(b['status'] as String, style: TextStyle(color: isPaid ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ]),
                const Divider(height: 20),
                _billRow('Room Rent', '৳ ${b['rent']}'),
                _billRow('Meal Charges', '৳ ${b['meal']}'),
                if ((b['other'] as int) > 0) _billRow('Other Charges', '৳ ${b['other']}'),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('৳ ${b['total']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ]),
                if (!isPaid) ...[
                  const SizedBox(height: 12),
                  SizedBox(width: double.infinity, child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.payment, color: Colors.white),
                    label: const Text('Pay ৳ ${4700}', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.student, padding: const EdgeInsets.symmetric(vertical: 14)),
                  )),
                ],
              ]),
            );
          }),
        ],
      ),
    );
  }

  Widget _billRow(String label, String amount) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      Text(amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    ]),
  );
}
