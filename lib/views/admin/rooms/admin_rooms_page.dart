import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdminRoomsPage extends StatefulWidget {
  const AdminRoomsPage({super.key});

  @override
  State<AdminRoomsPage> createState() => _AdminRoomsPageState();
}

class _AdminRoomsPageState extends State<AdminRoomsPage> {
  String _viewMode = 'grid'; // 'grid' or 'list'
  String _filter = 'All';

  final List<Map<String, dynamic>> _rooms = [
    {'number': '101', 'type': '2-Seater', 'floor': '1st', 'capacity': 2, 'occupied': 2, 'students': ['Mosharrof H.', 'Arafat R.'], 'status': 'Full'},
    {'number': '102', 'type': '2-Seater', 'floor': '1st', 'capacity': 2, 'occupied': 1, 'students': ['Rakib H.'], 'status': 'Available'},
    {'number': '103', 'type': '2-Seater', 'floor': '1st', 'capacity': 2, 'occupied': 0, 'students': [], 'status': 'Empty'},
    {'number': '104', 'type': '4-Seater', 'floor': '1st', 'capacity': 4, 'occupied': 3, 'students': ['Karim A.', 'Hasan M.', 'Rafi S.'], 'status': 'Available'},
    {'number': '201', 'type': '2-Seater', 'floor': '2nd', 'capacity': 2, 'occupied': 2, 'students': ['Sajib K.', 'Tanbir H.'], 'status': 'Full'},
    {'number': '202', 'type': '2-Seater', 'floor': '2nd', 'capacity': 2, 'occupied': 0, 'students': [], 'status': 'Maintenance'},
    {'number': '203', 'type': '4-Seater', 'floor': '2nd', 'capacity': 4, 'occupied': 2, 'students': ['Anik P.', 'Babul D.'], 'status': 'Available'},
  ];

  List<Map<String, dynamic>> get _filtered => _filter == 'All' ? _rooms : _rooms.where((r) => r['status'] == _filter).toList();

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
                Text('Room Distribution', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text('Manage room allocations and vacancies', style: TextStyle(color: AppColors.textSecondary)),
              ]),
              ElevatedButton.icon(
                onPressed: () => _showAssignRoomDialog(context),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Assign Room', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.count(
              crossAxisCount: cols, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.4,
              children: [
                _statCard('Total Rooms', '${_rooms.length}', Icons.meeting_room, Colors.blue, const Color(0xFFEFF6FF)),
                _statCard('Full Rooms', '${_rooms.where((r) => r['status'] == 'Full').length}', Icons.people, AppColors.error, AppColors.errorLight),
                _statCard('Available Seats', '${_rooms.fold(0, (sum, r) => sum + (r['capacity'] as int) - (r['occupied'] as int))}', Icons.event_seat, AppColors.success, AppColors.successLight),
                _statCard('Under Maintenance', '${_rooms.where((r) => r['status'] == 'Maintenance').length}', Icons.engineering, AppColors.warning, AppColors.warningLight),
              ],
            );
          }),
          const SizedBox(height: 24),

          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
            child: Row(
              children: [
                ...['All', 'Full', 'Available', 'Empty', 'Maintenance'].map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(f),
                    selected: _filter == f,
                    onSelected: (v) => setState(() => _filter = f),
                    selectedColor: AppColors.adminLight,
                    checkmarkColor: AppColors.admin,
                  ),
                )),
                const Spacer(),
                IconButton(icon: Icon(Icons.grid_view, color: _viewMode == 'grid' ? AppColors.admin : Colors.grey), onPressed: () => setState(() => _viewMode = 'grid')),
                IconButton(icon: Icon(Icons.view_list, color: _viewMode == 'list' ? AppColors.admin : Colors.grey), onPressed: () => setState(() => _viewMode = 'list')),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Room Cards Grid
          if (_viewMode == 'grid')
            LayoutBuilder(builder: (context, constraints) {
              final cols = constraints.maxWidth > 1200 ? 4 : constraints.maxWidth > 800 ? 3 : 2;
              return GridView.builder(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5),
                itemCount: _filtered.length,
                itemBuilder: (context, index) => _roomCard(_filtered[index]),
              );
            })
          else
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(children: _filtered.map(_roomListTile).toList()),
            ),
        ],
      ),
    );
  }

  Widget _roomCard(Map<String, dynamic> room) {
    Color statusColor;
    Color statusBg;
    switch (room['status']) {
      case 'Full': statusColor = AppColors.error; statusBg = AppColors.errorLight; break;
      case 'Available': statusColor = AppColors.success; statusBg = AppColors.successLight; break;
      case 'Maintenance': statusColor = AppColors.warning; statusBg = AppColors.warningLight; break;
      default: statusColor = Colors.grey; statusBg = Colors.grey.shade100;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: statusBg, width: 2), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Room ${room['number']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)), child: Text(room['status'], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11))),
        ]),
        const SizedBox(height: 4),
        Text('${room['type']} • ${room['floor']} Floor', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const Spacer(),
        Row(children: [
          const Icon(Icons.people, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Text('${room['occupied']}/${room['capacity']} ', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: room['capacity'] == 0 ? 0 : room['occupied'] / room['capacity'], backgroundColor: Colors.grey[200], color: statusColor, minHeight: 6))),
        ]),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 14),
            label: const Text('Manage', style: TextStyle(fontSize: 12)),
            style: TextButton.styleFrom(foregroundColor: AppColors.admin, padding: EdgeInsets.zero, minimumSize: const Size(0, 32)),
          ),
        ]),
      ]),
    );
  }

  Widget _roomListTile(Map<String, dynamic> room) {
    Color statusColor = room['status'] == 'Full' ? AppColors.error : room['status'] == 'Available' ? AppColors.success : AppColors.warning;
    return ListTile(
      leading: CircleAvatar(backgroundColor: statusColor.withValues(alpha: 0.1), child: Text(room['number'], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold))),
      title: Text('Room ${room['number']} — ${room['type']}'),
      subtitle: Text('${room['floor']} Floor · ${room['occupied']}/${room['capacity']} occupied'),
      trailing: Text(room['status'], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 24)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ]),
      ]),
    );
  }

  void _showAssignRoomDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Assign Room to Student'),
      content: SizedBox(width: 400, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(decoration: const InputDecoration(labelText: 'Student ID', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        DropdownMenu<String>(
          label: const Text('Select Room'),
          width: 360,
          dropdownMenuEntries: _rooms
              .where((r) => r['occupied'] < r['capacity'] && r['status'] != 'Maintenance')
              .map<DropdownMenuEntry<String>>((r) => DropdownMenuEntry<String>(
                    value: r['number'] as String,
                    label: 'Room ${r['number']} (${r['type']}) - ${r['floor']} Floor',
                  ))
              .toList(),
          onSelected: (val) {},
        ),
        const SizedBox(height: 16),
        TextFormField(decoration: const InputDecoration(labelText: 'Seat Number / Bed (Optional)', border: OutlineInputBorder())),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Room assigned successfully!'))); },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.admin),
          child: const Text('Assign', style: TextStyle(color: Colors.white)),
        ),
      ],
    ));
  }
}
