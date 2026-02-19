import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.green.shade800,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/rolebase/university_logo.png',
            height: 40,
          ),
          const Expanded(
            child: Text(
              "গণপ্রজাতন্ত্রী বাংলাদেশ সরকার",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Image.asset(
            'assets/images/rolebase/bd.png',
            height: 35,
          ),
        ],
      ),
    );
  }
}
