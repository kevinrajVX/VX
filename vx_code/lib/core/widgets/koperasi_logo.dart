import 'package:flutter/material.dart';

import '../theme/tokens.dart';

class KoperasiLogo extends StatelessWidget {
  const KoperasiLogo({
    super.key,
    this.size = 56,
    this.showWordmark = false,
    this.onBrand = false,
  });

  final double size;
  final bool showWordmark;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    final mark = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: onBrand
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xCCFFFFFF)],
              )
            : AppColors.brandGradient,
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: onBrand
            ? null
            : [
                BoxShadow(
                  color: AppColors.brandIndigo.withValues(alpha: 0.25),
                  blurRadius: size * 0.4,
                  offset: Offset(0, size * 0.15),
                  spreadRadius: -size * 0.12,
                ),
              ],
      ),
      child: CustomPaint(
        painter: _VXMarkPainter(
          color: onBrand ? AppColors.brandViolet : Colors.white,
        ),
      ),
    );

    if (!showWordmark) return mark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        SizedBox(width: size * 0.28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Koperasi VX',
              style: TextStyle(
                fontSize: size * 0.36,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                height: 1.05,
                color: onBrand ? Colors.white : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: size * 0.04),
            Text(
              'Berhad',
              style: TextStyle(
                fontSize: size * 0.22,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
                color: onBrand
                    ? AppColors.textOnBrandMuted
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _VXMarkPainter extends CustomPainter {
  _VXMarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final inset = w * 0.24;

    final stroke = w * 0.10;
    final paint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final topLeft = Offset(inset, inset);
    final topRight = Offset(w - inset, inset);
    final bottomMid = Offset(w / 2, h - inset);

    final vPath = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomMid.dx, bottomMid.dy)
      ..lineTo(topRight.dx, topRight.dy);

    canvas.drawPath(vPath, paint);

    final dotPaint = Paint()..color = color;
    final dotRadius = w * 0.055;
    canvas.drawCircle(
      Offset(w / 2, h - inset + dotRadius * 1.6),
      dotRadius,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _VXMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
