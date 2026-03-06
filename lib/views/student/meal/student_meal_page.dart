import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StudentMealPage extends StatefulWidget {
  const StudentMealPage({super.key});

  @override
  State<StudentMealPage> createState() => _StudentMealPageState();
}

class _StudentMealPageState extends State<StudentMealPage> {
  bool _mealOn = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Meal Status', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text('Toggle your daily meal on or off', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),

          // Meal Toggle Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12)],
            ),
            child: Column(children: [
              Icon(Icons.restaurant, size: 56, color: _mealOn ? AppColors.success : Colors.grey),
              const SizedBox(height: 16),
              Text(
                _mealOn ? 'Meal is ON' : 'Meal is OFF',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _mealOn ? AppColors.success : Colors.grey),
              ),
              const SizedBox(height: 6),
              Text(_mealOn ? 'You are included in today\'s meal count.' : 'You are excluded from today\'s meal.', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              Transform.scale(
                scale: 1.5,
                child: Switch(
                  value: _mealOn,
                  activeColor: AppColors.success,
                  onChanged: (v) {
                    setState(() => _mealOn = v);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(v ? '✅ Meal turned ON for today!' : '🔴 Meal turned OFF for today!'), backgroundColor: v ? AppColors.success : Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(8)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.info_outline, size: 16, color: AppColors.info),
                  SizedBox(width: 8),
                  Text('Cut-off time: 9:00 PM (next day)', style: TextStyle(fontSize: 12, color: AppColors.info)),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          // Meal History
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Meal History — March 2026', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              // Quick summary
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _mealStat('Days ON', '7', AppColors.success),
                _mealStat('Days OFF', '0', Colors.grey),
                _mealStat('Total Meals', '21', AppColors.student),
              ]),
              const Divider(height: 28),
              Wrap(spacing: 8, runSpacing: 8, children: List.generate(7, (i) {
                return Container(
                  width: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.studentLight, borderRadius: BorderRadius.circular(8)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('0${i + 1} Mar', style: const TextStyle(fontSize: 12, color: AppColors.student, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Row(children: [
                      Icon(Icons.restaurant, size: 12, color: AppColors.success),
                      SizedBox(width: 4),
                      Text('3 meals', style: TextStyle(fontSize: 11)),
                    ]),
                  ]),
                );
              })),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _mealStat(String label, String val, Color color) => Column(children: [
    Text(val, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
    Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
  ]);
}
