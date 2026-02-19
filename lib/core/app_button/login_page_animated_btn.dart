import 'package:flutter/material.dart';

class AnimatedRoleButton extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  final double? width;   // Desktop base width
  final double? height;  // Desktop base height
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final IconData? icon;
  final Border? border;

  const AnimatedRoleButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor = const Color(0xFF043D04),
    this.textColor = Colors.white,
    this.borderRadius = 12,
    this.icon,
    this.border,
  });

  @override
  State<AnimatedRoleButton> createState() => _AnimatedRoleButtonState();
}

class _AnimatedRoleButtonState extends State<AnimatedRoleButton> {
  double scale = 1.0;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    /// Responsive breakpoints
    double scaleFactor;
    if (screenWidth < 600) {
      scaleFactor = 0.85; // Mobile
    } else if (screenWidth < 1100) {
      scaleFactor = 0.95; // Tablet
    } else {
      scaleFactor = 1.0; // Desktop
    }

    final baseWidth = widget.width ?? 260;
    final baseHeight = widget.height ?? 52;

    final buttonWidth = baseWidth * scaleFactor;
    final buttonHeight = baseHeight * scaleFactor;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => scale = 0.96),
        onTapUp: (_) => setState(() => scale = 1.0),
        onTapCancel: () => setState(() => scale = 1.0),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 120),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: buttonWidth,
            height: buttonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHovering
                  ? widget.backgroundColor.withOpacity(0.9)
                  : widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: widget.border,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: isHovering ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon,
                      color: widget.textColor,
                      size: 18 * scaleFactor),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
