import 'package:flutter/material.dart';
import 'package:hall_management/core/app_button/login_page_animated_btn.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1100;

    double heroHeight;
    if (isMobile) {
      heroHeight = MediaQuery.of(context).size.height * 0.55;
    } else if (isTablet) {
      heroHeight = 420;
    } else {
      heroHeight = 500;
    }

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/rolebase/hall_ph.png',
            fit: BoxFit.cover,
          ),

          /// Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.75),
                  Colors.black.withOpacity(0.45),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          /// Content
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
          
                  Text(
                    "ময়মনসিংহ ইঞ্জিনিয়ারিং কলেজ",
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 22 : 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          
                  const SizedBox(height: 8),
          
                  Text(
                    "অমর একুশে হল ম্যানেজমেন্ট সিস্টেম",
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 16 : 22,
                    ),
                  ),
          
                  const SizedBox(height: 30),
          
                  Wrap(
                    alignment: isMobile
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    spacing: 20,
                    runSpacing: 15,
                    children: [
          
                      AnimatedRoleButton(
                        title: "Login",
                        width: 180,
                        height: 45,
                        backgroundColor: Colors.green.shade900,
                        textColor: Colors.white,
                        border: Border.all(
                          color: Colors.green.shade900,
                        ),
                      ),
          
                      AnimatedRoleButton(
                        title: "Apply For Seat",
                        width: 220,
                        height: 45,
                        backgroundColor: Colors.white,
                        textColor: Colors.green.shade900,
                        border: Border.all(
                          color: Colors.green.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
