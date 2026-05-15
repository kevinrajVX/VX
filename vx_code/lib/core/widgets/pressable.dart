import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Wraps [child] with a scale-down animation on press.
///
/// On tap-down it shrinks to [pressedScale] using [AppMotion.fast] +
/// [AppMotion.emphasized]. On release it springs back with [AppMotion.spring].
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.child,
    required this.onTap,
    this.pressedScale = 0.97,
    this.borderRadius,
    this.hapticOnTap = true,
  });

  final Widget child;
  final VoidCallback onTap;
  final double pressedScale;
  final BorderRadius? borderRadius;
  final bool hapticOnTap;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.fast,
    reverseDuration: AppMotion.base,
    value: 0,
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 1.0,
    end: widget.pressedScale,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: AppMotion.emphasized,
      reverseCurve: AppMotion.spring,
    ),
  );

  void _onTapDown(TapDownDetails _) => _controller.forward();

  void _onTapUp(TapUpDetails _) => _controller.reverse();

  void _onTapCancel() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
