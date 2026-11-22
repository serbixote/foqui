import 'package:flutter/widgets.dart';

/// Shared timing for session changes and the rest of the controls.
const kMotion = Duration(milliseconds: 220);
const kMotionSheet = Duration(milliseconds: 360);

const kMotionCurve = Curves.easeOutCubic;

/// Slides [child] in from [from] whenever [switchKey] changes.
///
/// The child that is leaving slides out the opposite way. [expand] keeps a
/// full-size stack so a page can slide without collapsing.
class MotionSwap extends StatelessWidget {
  const MotionSwap({
    super.key,
    required this.switchKey,
    required this.child,
    this.duration = kMotion,
    this.alignment = Alignment.topCenter,
    this.expand = false,
    this.from = const Offset(0, 1),
  });

  final Object? switchKey;
  final Widget child;
  final Duration duration;
  final Alignment alignment;
  final bool expand;

  /// Where the new child enters. The old child leaves the other way.
  final Offset from;

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    final time = reduced ? Duration.zero : duration;
    final switcher = AnimatedSwitcher(
      duration: time,
      switchInCurve: kMotionCurve,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (current, previous) {
        if (expand) {
          return Stack(
            fit: StackFit.expand,
            children: [
              for (final child in previous) Positioned.fill(child: child),
              if (current != null) Positioned.fill(child: current),
            ],
          );
        }
        return Stack(alignment: alignment, children: [...previous, ?current]);
      },
      transitionBuilder: (child, animation) {
        // Reverse means this child is on its way out, so it leaves opposite
        // the side the new child is entering from.
        final leaving = animation.status == AnimationStatus.reverse;
        final begin = leaving ? -from : from;
        return ClipRect(
          child: SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: ValueKey<Object?>(switchKey), child: child),
    );
    if (expand) return switcher;
    return AnimatedSize(
      duration: time,
      curve: kMotionCurve,
      alignment: alignment,
      child: switcher,
    );
  }
}

/// Slides in once, when the widget is first inserted.
class MotionIn extends StatefulWidget {
  const MotionIn({
    super.key,
    required this.child,
    this.from = const Offset(0, -1),
  });

  final Widget child;

  /// Where the child starts. The label menu drops down from above.
  final Offset from;

  @override
  State<MotionIn> createState() => _MotionInState();
}

class _MotionInState extends State<MotionIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: kMotion);
    _fade = CurvedAnimation(parent: _controller, curve: kMotionCurve);
    _slide = Tween<Offset>(begin: widget.from, end: Offset.zero).animate(_fade);
    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _controller.value = 1;
  }

  @override
  void dispose() {
    _fade.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
