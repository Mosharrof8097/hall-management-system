import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ManagerDashboardPage extends StatelessWidget {
  const ManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mill Manager Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text('Today: Saturday, 7 March 2026', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),

          // Stat Cards
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.count(
              crossAxisCount: cols, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.2,
              children: [
                _statCard('Total Members', '248', Icons.people, AppColors.manager, AppColors.managerLight),
                _statCard('Today\'s Meals', '240', Icons.restaurant, AppColors.success, AppColors.successLight),
                _statCard('Today\'s Bazar', '৳ 7,680', Icons.shopping_cart, Colors.blue, const Color(0xFFEFF6FF)),
                _statCard('Monthly Dues', '৳ 26,500', Icons.money_off, AppColors.error, AppColors.errorLight),
              ],
            );
          }),
          const SizedBox(height: 24),

          // Today's Quick Actions + Summary
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              // Quick Actions Card
              Container(
                width: 320,
                padding: const EdgeInsets.all(20),
                decoration: _cardDeco(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Quick Actions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _actionBtn(context, Icons.restaurant, "Add Daily Meal Count", AppColors.manager),
                    const SizedBox(height: 10),
                    _actionBtn(context, Icons.shopping_cart, "Record Bazar Cost", Colors.blue),
                    const SizedBox(height: 10),
                    _actionBtn(context, Icons.receipt, "Update Student Dues", AppColors.error),
                  ],
                ),
              ),

              // Meal Summary
              Container(
                width: 500,
                padding: const EdgeInsets.all(20),
                decoration: _cardDeco(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("This Month's Meal Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Divider(),
                    _summaryRow("Total Meal Count", "7,440", AppColors.manager),
                    _summaryRow("Total Bazar Cost", "৳ 2,38,080", Colors.blue),
                    _summaryRow("Per Meal Cost", "৳ 32", Colors.indigo),
                    _summaryRow("Per Head Cost (Feb)", "৳ 960", AppColors.warning),
                    const Divider(),
                    _summaryRow("Members Paid", "220", AppColors.success),
                    _summaryRow("Members with Dues", "28", AppColors.error),
                  ],
                ),
              ),

              // Last 5 Bazar entries
              Container(
                width: 380,
                padding: const EdgeInsets.all(20),
                decoration: _cardDeco(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recent Bazar Entries", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ...[
                      {'date': '07 Mar', 'item': 'Rice + Veg', 'amount': '৳ 7,680'},
                      {'date': '06 Mar', 'item': 'Chicken + Rice', 'amount': '৳ 9,200'},
                      {'date': '05 Mar', 'item': 'Fish + Veg', 'amount': '৳ 8,400'},
                      {'date': '04 Mar', 'item': 'Egg + Dal', 'amount': '৳ 6,100'},
                    ].map((e) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(radius: 18, backgroundColor: AppColors.managerLight, child: const Icon(Icons.shopping_bag, size: 16, color: AppColors.manager)),
                      title: Text(e['item']!, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                      subtitle: Text(e['date']!, style: const TextStyle(fontSize: 12)),
                      trailing: Text(e['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.manager)),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 26)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ])),
      ]),
    );
  }

  Widget _actionBtn(BuildContext context, IconData icon, String label, Color color) => SizedBox(
    width: double.infinity,
    child: OutlinedButton.icon(
      icon: Icon(icon, color: color, size: 18),
      label: Text(label, style: TextStyle(color: color, fontSize: 13)),
      onPressed: () {},
      style: OutlinedButton.styleFrom(side: BorderSide(color: color.withValues(alpha: 0.4)), padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), alignment: Alignment.centerLeft),
    ),
  );

  Widget _summaryRow(String label, String value, Color color) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
    ]),
  );

  BoxDecoration _cardDeco() => BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
  );
}
