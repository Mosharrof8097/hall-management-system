import 'package:flutter/material.dart';
import 'package:hall_management/core/app_button/login_page_animated_btn.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Colors.grey.shade100,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: isMobile
            ? Column(
                children: [
                  _imagePart(),
                  const SizedBox(height: 30),
                  _textPart(),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _imagePart()),
                  const SizedBox(width: 40),
                  Expanded(child: _textPart()),
                ],
              ),
      ),
    );
  }

  Widget _imagePart() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/rolebase/hall_ph.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Manage. Monitor. Maintain",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "অমর একুশে হল ম্যানেজমেন্ট সিস্টেম",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "হল ব্যবস্থাপনা প্রক্রিয়াকে ডিজিটাল রূপান্তরের মাধ্যমে দ্রুত ও স্বচ্ছ করতে এই সমন্বিত সিস্টেম প্রণয়ন করা হয়েছে। শিক্ষার্থীরা এক প্ল্যাটফর্ম থেকেই আবেদন, ফি পরিশোধ ও অভিযোগ দাখিল করতে পারবে, এবং মিল ব্যবস্থাপনার কার্যক্রম ও হিসাবের কার্যকর তদারকি নিশ্চিত করা হবে।",
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        AnimatedRoleButton(
          title: "Learn More",
          width: 180,
          height: 45,
        ),
      ],
    );
  }
}
