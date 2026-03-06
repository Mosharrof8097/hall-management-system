import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Complaint Box - Manager Side
/// Manager sees only complaints addressed to them (target = 'Manager')
class ManagerComplaintsPage extends StatefulWidget {
  const ManagerComplaintsPage({super.key});

  @override
  State<ManagerComplaintsPage> createState() => _ManagerComplaintsPageState();
}

class _ManagerComplaintsPageState extends State<ManagerComplaintsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _complaints = [
    {'id': 'C-001', 'student': 'Mosharrof Hossain', 'sid': '2020-1-60-001', 'room': '101-A', 'category': 'Meal', 'subject': 'Meal quality issue', 'body': 'The rice served on 5th March was undercooked. This has happened multiple times this week.', 'date': '05 Mar 2026', 'status': 'Open', 'reply': ''},
    {'id': 'C-003', 'student': 'Arafat Rahman', 'sid': '2021-1-60-032', 'room': '204-B', 'category': 'Meal', 'subject': 'Meal count discrepancy', 'body': 'My meal count shows 28 days but I was absent for 3 days and turned meal off.', 'date': '03 Mar 2026', 'status': 'Open', 'reply': ''},
    {'id': 'C-004', 'student': 'Rakib Hasan', 'sid': '2022-1-60-015', 'room': '305-A', 'category': 'Manager', 'subject': 'Bazar cost seems high', 'body': 'The per-meal cost this month is higher than usual. Please provide itemized bazar list.', 'date': '01 Mar 2026', 'status': 'Resolved', 'reply': 'The bazar cost was higher due to Ramadan pricing. We will try to reduce costs next month.'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _open     => _complaints.where((c) => c['status'] == 'Open').toList();
  List<Map<String, dynamic>> get _resolved => _complaints.where((c) => c['status'] == 'Resolved').toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Complaint Box', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text('Student complaints addressed to Manager', style: TextStyle(color: AppColors.textSecondary)),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: AppColors.warningLight, borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                const Icon(Icons.mark_email_unread, color: AppColors.warning, size: 20),
                const SizedBox(width: 8),
                Text('${_open.length} Open', style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold)),
              ]),
            ),
          ]),
          const SizedBox(height: 24),

          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(children: [
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.manager,
                labelColor: AppColors.manager,
                unselectedLabelColor: Colors.grey,
                tabs: [Tab(text: 'Open (${_open.length})'), Tab(text: 'Resolved (${_resolved.length})')],
              ),
              SizedBox(
                height: 560,
                child: TabBarView(controller: _tabController, children: [
                  _buildList(_open, isPending: true),
                  _buildList(_resolved),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list, {bool isPending = false}) {
    if (list.isEmpty) {
      return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.inbox, size: 48, color: Colors.grey),
        SizedBox(height: 12),
        Text('No complaints here', style: TextStyle(color: Colors.grey)),
      ]));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: list.map((c) => _complaintCard(c, isPending: isPending)).toList(),
    );
  }

  Widget _complaintCard(Map<String, dynamic> c, {bool isPending = false}) {
    final catIcon = {'Meal': Icons.restaurant, 'Manager': Icons.manage_accounts, 'Room': Icons.meeting_room, 'Other': Icons.help_outline}[c['category']] ?? Icons.feedback;
    final catColor = {'Meal': AppColors.manager, 'Manager': AppColors.error, 'Room': Colors.blue, 'Other': Colors.grey}[c['category']] ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isPending ? AppColors.warningLight : AppColors.successLight, width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            CircleAvatar(radius: 16, backgroundColor: catColor.withValues(alpha: 0.1), child: Icon(catIcon, size: 16, color: catColor)),
            const SizedBox(width: 10),
            Text(c['id'], style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 12)),
          ]),
          Text(c['date'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
        const SizedBox(height: 10),
        Text(c['subject'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(c['body'], style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: [
          _chip(Icons.person, c['student'], Colors.indigo),
          _chip(Icons.badge, c['sid'], Colors.grey),
          _chip(Icons.meeting_room, 'Room: ${c['room']}', Colors.blue),
          _chip(Icons.category, c['category'], catColor),
        ]),
        if ((c['reply'] as String).isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.managerLight, borderRadius: BorderRadius.circular(8)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.reply, size: 16, color: AppColors.manager),
              const SizedBox(width: 8),
              Expanded(child: Text('Manager Reply: ${c['reply']}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.manager))),
            ]),
          ),
        ],
        if (isPending) ...[
          const SizedBox(height: 14),
          Row(children: [
            Expanded(child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Type your reply...',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.manager),
                  onPressed: () {
                    setState(() { c['status'] = 'Resolved'; c['reply'] = 'This has been addressed by the Manager.'; });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reply sent and complaint resolved!')));
                  },
                ),
              ),
            )),
          ]),
        ],
      ]),
    );
  }

  Widget _chip(IconData icon, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: color),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    ]),
  );
}
