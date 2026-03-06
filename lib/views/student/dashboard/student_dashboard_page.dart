import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(gradient: AppColors.studentGradient, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              const CircleAvatar(radius: 40, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 44, color: Colors.white)),
              const SizedBox(width: 20),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Mosharrof Hossain', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('ID: 2020-1-60-001 | CSE, 3rd Year', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 10),
                Wrap(spacing: 10, children: [
                  _badge(Icons.meeting_room, 'Room: 101-A'),
                  _badge(Icons.restaurant, 'Meal: ON'),
                  _badge(Icons.receipt, 'Due: ৳ 0'),
                ]),
              ])),
            ]),
          ),

          const SizedBox(height: 24),

          // Quick Stats
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 800 ? 4 : 2;
            return GridView.count(
              crossAxisCount: cols, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.2,
              children: [
                _statCard('Monthly Meal', '28 days', Icons.restaurant, AppColors.student, AppColors.studentLight),
                _statCard('This Month Bill', '৳ 4,900', Icons.receipt, AppColors.warning, AppColors.warningLight),
                _statCard('Amount Paid', '৳ 4,900', Icons.check_circle, AppColors.success, AppColors.successLight),
                _statCard('Outstanding Due', '৳ 0', Icons.money_off, Colors.grey, Colors.grey.shade100),
              ],
            );
          }),

          const SizedBox(height: 24),

          // Info Sections
          Wrap(spacing: 20, runSpacing: 20, children: [
            // Recent Notices
            Container(
              width: 420,
              padding: const EdgeInsets.all(20),
              decoration: _cardDeco(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Recent Notices', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('View All')),
                ]),
                const SizedBox(height: 8),
                ...[
                  {'title': 'Monthly Bill Payment Deadline', 'date': '04 Mar', 'type': 'Financial'},
                  {'title': 'Hall Day Celebration 2026', 'date': '06 Mar', 'type': 'Event'},
                  {'title': 'Room Inspection Schedule', 'date': '02 Mar', 'type': 'General'},
                ].map((n) {
                  final typeColors = {'Financial': AppColors.error, 'Event': const Color(0xFF8B5CF6), 'General': AppColors.info};
                  final c = typeColors[n['type']] ?? Colors.grey;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(radius: 18, backgroundColor: c.withValues(alpha: 0.1), child: Icon(Icons.notifications, size: 16, color: c)),
                    title: Text(n['title']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    subtitle: Text(n['date']!, style: const TextStyle(fontSize: 11)),
                    trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)), child: Text(n['type']!, style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.bold))),
                  );
                }),
              ]),
            ),

            // Meal Calendar
            Container(
              width: 340,
              padding: const EdgeInsets.all(20),
              decoration: _cardDeco(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Meal Calendar — March 2026', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(spacing: 8, runSpacing: 8, children: List.generate(31, (i) {
                  final day = i + 1;
                  final isOn = day <= 7;
                  final isToday = day == 7;
                  return Container(
                    width: 38, height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.student : isOn ? AppColors.studentLight : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isToday ? AppColors.student : isOn ? AppColors.student.withValues(alpha: 0.3) : Colors.grey.shade200),
                    ),
                    child: Text('$day', style: TextStyle(
                      color: isToday ? Colors.white : isOn ? AppColors.student : Colors.grey,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    )),
                  );
                })),
                const SizedBox(height: 12),
                Row(children: [
                  _legend(AppColors.student, 'Meal On'),
                  const SizedBox(width: 16),
                  _legend(Colors.grey.shade300, 'Meal Off'),
                ]),
              ]),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _badge(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: Colors.white),
      const SizedBox(width: 5),
      Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    ]),
  );

  Widget _statCard(String title, String value, IconData icon, Color color, Color bg) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 24)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ])),
    ]),
  );

  Widget _legend(Color color, String text) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
    const SizedBox(width: 6),
    Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
  ]);

  BoxDecoration _cardDeco() => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]);
}
