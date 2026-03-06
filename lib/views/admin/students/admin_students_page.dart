import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class AdminStudentsPage extends StatefulWidget {
  const AdminStudentsPage({super.key});

  @override
  State<AdminStudentsPage> createState() => _AdminStudentsPageState();
}

class _AdminStudentsPageState extends State<AdminStudentsPage> {
  // Mock data for UI
  final List<Map<String, dynamic>> _students = [
    {
      'id': '2020-1-60-001',
      'name': 'Mosharrof Hossain',
      'email': 'student@example.com',
      'room': '101-A',
      'status': 'Allocated',
    },
    {
      'id': '2021-1-60-032',
      'name': 'Arafat Rahman',
      'email': 'arafat@example.com',
      'room': 'Pending',
      'status': 'Pending Approval',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Students',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_download, color: Colors.white),
                label: const Text('Export List', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.student,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Data Table Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter and Search Row
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by ID/Name...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownMenu<String>(
                      initialSelection: 'All',
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 'All', label: 'All Status'),
                        DropdownMenuEntry(value: 'Allocated', label: 'Allocated'),
                        DropdownMenuEntry(value: 'Pending Approval', label: 'Pending Approval'),
                      ],
                      onSelected: (value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Table
                LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.grey[100]),
                        columns: const [
                          DataColumn(label: Text('Student ID', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Contact', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Room', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: _students.map((student) {
                          final isAllocated = student['status'] == 'Allocated';
                          return DataRow(
                            cells: [
                              DataCell(Text(student['id'], style: const TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColors.studentLight,
                                      child: Icon(Icons.person, size: 16, color: AppColors.student),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(student['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              DataCell(Text(student['email'], style: const TextStyle(fontSize: 13))),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isAllocated ? Colors.grey[200] : AppColors.warningLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(student['room']),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isAllocated ? AppColors.successLight : AppColors.warningLight,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    student['status'],
                                    style: TextStyle(
                                      color: isAllocated ? AppColors.success : AppColors.warning,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    if (!isAllocated)
                                      IconButton(
                                        icon: const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                                        onPressed: () {},
                                        tooltip: 'Approve Seat',
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                      onPressed: () {},
                                      tooltip: 'Edit Profile',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                      onPressed: () {},
                                      tooltip: 'Remove',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
