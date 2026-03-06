import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Complaint Box - Student Side
/// Student can post complaints targeting either Manager or Admin
class StudentComplaintPage extends StatefulWidget {
  const StudentComplaintPage({super.key});

  @override
  State<StudentComplaintPage> createState() => _StudentComplaintPageState();
}

class _StudentComplaintPageState extends State<StudentComplaintPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _subjectCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  String _selectedTarget = 'Manager';
  String _selectedCategory = 'Meal';

  final List<Map<String, dynamic>> _myComplaints = [
    {'id': 'C-001', 'subject': 'Meal quality issue', 'target': 'Manager', 'status': 'Open', 'date': '05 Mar 2026', 'reply': ''},
    {'id': 'C-002', 'subject': 'Room maintenance needed', 'target': 'Admin', 'status': 'Resolved', 'date': '28 Feb 2026', 'reply': 'We have scheduled maintenance on 12 March.'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Complaint Box', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text('Submit complaints to Manager or Admin', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),

          // Tab Bar
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
            child: Column(children: [
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.student,
                labelColor: AppColors.student,
                unselectedLabelColor: Colors.grey,
                tabs: const [Tab(icon: Icon(Icons.add_circle_outline), text: 'Submit'), Tab(icon: Icon(Icons.history), text: 'My Complaints')],
              ),
              SizedBox(
                height: 600,
                child: TabBarView(controller: _tabController, children: [
                  _buildSubmitForm(),
                  _buildMyComplaintsList(),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('New Complaint', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),

        // Target Selector (Manager / Admin)
        const Text('Send To:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 10),
        Row(children: [
          _targetChip('Manager', Icons.manage_accounts, AppColors.manager, AppColors.managerLight),
          const SizedBox(width: 12),
          _targetChip('Admin', Icons.admin_panel_settings, AppColors.admin, AppColors.adminLight),
        ]),
        const SizedBox(height: 20),

        // Category
        DropdownMenu<String>(
          label: const Text('Category'),
          width: double.infinity,
          initialSelection: _selectedCategory,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'Meal', label: '🍽️  Meal / Food Quality'),
            DropdownMenuEntry(value: 'Room', label: '🏠  Room / Maintenance'),
            DropdownMenuEntry(value: 'Manager', label: '👤  Manager Behavior'),
            DropdownMenuEntry(value: 'Billing', label: '💰  Billing / Payment'),
            DropdownMenuEntry(value: 'Other', label: '📌  Other'),
          ],
          onSelected: (v) => setState(() => _selectedCategory = v!),
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: _subjectCtrl,
          decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder(), prefixIcon: Icon(Icons.subject)),
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: _bodyCtrl,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Describe your complaint',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
            prefixIcon: Padding(padding: EdgeInsets.only(bottom: 80), child: Icon(Icons.description_outlined)),
          ),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.warningLight, borderRadius: BorderRadius.circular(8)),
          child: const Row(children: [
            Icon(Icons.lock_outline, size: 16, color: AppColors.warning),
            SizedBox(width: 8),
            Expanded(child: Text('Your identity is kept confidential from other students.', style: TextStyle(fontSize: 12, color: AppColors.warning))),
          ]),
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ Complaint sent to $_selectedTarget successfully!'), backgroundColor: AppColors.student),
              );
              _subjectCtrl.clear();
              _bodyCtrl.clear();
            },
            icon: const Icon(Icons.send, color: Colors.white),
            label: Text('Submit to $_selectedTarget', style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.student, padding: const EdgeInsets.symmetric(vertical: 14)),
          ),
        ),
      ]),
    );
  }

  Widget _buildMyComplaintsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _myComplaints.map((c) {
        final isResolved = c['status'] == 'Resolved';
        final isManager  = c['target'] == 'Manager';
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isResolved ? AppColors.successLight : AppColors.warningLight, width: 1.5),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(c['id'], style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 12)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isResolved ? AppColors.successLight : AppColors.warningLight, borderRadius: BorderRadius.circular(20)),
                child: Text(c['status'], style: TextStyle(color: isResolved ? AppColors.success : AppColors.warning, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ]),
            const SizedBox(height: 8),
            Text(c['subject'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(children: [
              Icon(isManager ? Icons.manage_accounts : Icons.admin_panel_settings, size: 14, color: isManager ? AppColors.manager : AppColors.admin),
              const SizedBox(width: 4),
              Text('To: ${c['target']}', style: TextStyle(fontSize: 12, color: isManager ? AppColors.manager : AppColors.admin, fontWeight: FontWeight.w500)),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(c['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
            if ((c['reply'] as String).isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.adminLight, borderRadius: BorderRadius.circular(8)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.reply, size: 14, color: AppColors.admin),
                  const SizedBox(width: 8),
                  Expanded(child: Text(c['reply'], style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic))),
                ]),
              ),
            ],
          ]),
        );
      }).toList(),
    );
  }

  Widget _targetChip(String label, IconData icon, Color color, Color bg) {
    final selected = _selectedTarget == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTarget = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? color : Colors.grey.shade300, width: 2),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: selected ? Colors.white : Colors.grey, size: 20),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: selected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
