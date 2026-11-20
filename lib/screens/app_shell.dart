import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/focus_controller.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/session_bar_button.dart';
import '../widgets/session_live_activity.dart';
import 'block_lists_screen.dart';
import 'friends_screen.dart';
import 'home_screen.dart';
import 'stats_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(focusControllerProvider).foregroundSession;
    final locked = session != null;
    if (locked) _index = 0;
    final topInset = MediaQuery.paddingOf(context).top;

    return PopScope(
      canPop: !locked,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            ExcludeSemantics(
              excluding: locked,
              child: IgnorePointer(
                ignoring: locked,
                child: IndexedStack(
                  index: _index,
                  children: const [
                    HomeScreen(),
                    StatsScreen(),
                    FriendsScreen(),
                    BlockListsScreen(),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: kFloatingBarBottomGap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kFloatingBarHorizontalInset,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ExcludeSemantics(
                        excluding: locked,
                        child: IgnorePointer(
                          ignoring: locked,
                          child: FloatingTabBar(
                            selectedIndex: _index,
                            onSelected: (index) {
                              if (locked) return;
                              setState(() => _index = index);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: kFloatingTabBarHeight,
                      height: kFloatingTabBarHeight,
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: kFloatingBarHorizontalInset,
              bottom: kFloatingBarBottomGap,
              child: SessionBarButton(),
            ),
            if (locked) ...[
              const Positioned.fill(child: _SessionVeil()),
              Positioned(
                left: 0,
                right: 0,
                top: topInset,
                bottom: 0,
                child: const SessionLiveActivity(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Soft veil over the app while the session sheet is up.
class _SessionVeil extends StatelessWidget {
  const _SessionVeil();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ExcludeSemantics(
      child: AbsorbPointer(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: ColoredBox(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.45)
                  : Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}
