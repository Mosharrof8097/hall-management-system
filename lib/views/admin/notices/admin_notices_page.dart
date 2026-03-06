import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdminNoticesPage extends StatefulWidget {
  const AdminNoticesPage({super.key});

  @override
  State<AdminNoticesPage> createState() => _AdminNoticesPageState();
}

class _AdminNoticesPageState extends State<AdminNoticesPage> {
  final List<Map<String, dynamic>> _notices = [
    {'id': 1, 'title': 'Hall Day Celebration 2026', 'body': 'Hall Day will be celebrated on 15th March 2026. All students are requested to participate.', 'date': '06 Mar 2026', 'type': 'Event', 'important': true},
    {'id': 2, 'title': 'Monthly Bill Payment Deadline', 'body': 'All students must pay their February 2026 dues by 10th March 2026. Late payment will incur a fine.', 'date': '04 Mar 2026', 'type': 'Financial', 'important': true},
    {'id': 3, 'title': 'Dining Room Maintenance', 'body': 'The dining room will be under maintenance on 8th March from 8AM–12PM. Meals will be served in the common room.', 'date': '03 Mar 2026', 'type': 'General', 'important': false},
    {'id': 4, 'title': 'Room Inspection Schedule', 'body': 'Room inspection for 1st and 2nd floor will be conducted on 12th March 2026.', 'date': '02 Mar 2026', 'type': 'General', 'important': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Notice Board', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text('Post and manage hall announcements', style: TextStyle(color: AppColors.textSecondary)),
              ]),
              ElevatedButton.icon(
                onPressed: () => _showAddNoticeDialog(context),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Post Notice', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notices List
          ..._notices.map((notice) => _noticeCard(context, notice)).toList(),
        ],
      ),
    );
  }

  Widget _noticeCard(BuildContext context, Map<String, dynamic> notice) {
    final typeColors = {
      'Event': (color: const Color(0xFF8B5CF6), bg: const Color(0xFFF3E8FF)),
      'Financial': (color: AppColors.error, bg: AppColors.errorLight),
      'General': (color: AppColors.info, bg: AppColors.infoLight),
    };
    final tc = typeColors[notice['type']] ?? (color: Colors.grey, bg: Colors.grey.shade100);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: notice['important'] ? Border.all(color: AppColors.error.withValues(alpha: 0.3), width: 1.5) : null,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (notice['important'])
                Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(4)), child: const Text('⚠ Important', style: TextStyle(fontSize: 11, color: AppColors.error, fontWeight: FontWeight.bold))),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3), decoration: BoxDecoration(color: tc.bg, borderRadius: BorderRadius.circular(20)), child: Text(notice['type'], style: TextStyle(fontSize: 11, color: tc.color, fontWeight: FontWeight.bold))),
              const Spacer(),
              Text(notice['date'], style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(width: 8),
              IconButton(icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.blue), onPressed: () {}, tooltip: 'Edit'),
              IconButton(icon: const Icon(Icons.delete_outlined, size: 18, color: Colors.red), onPressed: () {}, tooltip: 'Delete'),
            ],
          ),
          const SizedBox(height: 10),
          Text(notice['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(notice['body'], style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }

  void _showAddNoticeDialog(BuildContext context) {
    bool isImportant = false;
    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, setDialogState) => AlertDialog(
      title: const Text('Post New Notice'),
      content: SizedBox(
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(decoration: const InputDecoration(labelText: 'Notice Title', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          DropdownMenu<String>(
            label: const Text('Category'),
            width: 460,
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'General', label: 'General'),
              DropdownMenuEntry(value: 'Financial', label: 'Financial'),
              DropdownMenuEntry(value: 'Event', label: 'Event'),
            ],
            onSelected: (val) {},
          ),
          const SizedBox(height: 16),
          TextFormField(maxLines: 4, decoration: const InputDecoration(labelText: 'Notice Body', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          Row(children: [
            Checkbox(value: isImportant, onChanged: (v) => setDialogState(() => isImportant = v!)),
            const Text('Mark as Important'),
          ]),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notice posted successfully!'))); },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin),
          child: const Text('Post', style: TextStyle(color: Colors.white)),
        ),
      ],
    )));
  }
}
