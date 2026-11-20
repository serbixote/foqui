import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/tr.dart';
import 'floating_chrome.dart';

const double kFloatingBarBottomGap = 24;
const double kFloatingBarHorizontalInset = 20;
const double kFloatingTabBarHeight = 62;

/// Space under scrolling content so the last row can rest above the bar.
const double kFloatingContentInset = 120;

/// Empty content sits a little above center, clear of the floating bar.
const kEmptyContentAlignment = Alignment(0, -0.32);

/// Insets around that empty content. The bottom inset clears the bar.
const kEmptyContentPadding = EdgeInsets.fromLTRB(
  32,
  8,
  32,
  kFloatingContentInset,
);

class FloatingTabSpec {
  const FloatingTabSpec({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const kFoquiTabs = [
  FloatingTabSpec(
    label: 'tabs_home',
    icon: CupertinoIcons.house,
    selectedIcon: CupertinoIcons.house_fill,
  ),
  FloatingTabSpec(
    label: 'tabs_stats',
    icon: CupertinoIcons.chart_bar,
    selectedIcon: CupertinoIcons.chart_bar_fill,
  ),
  FloatingTabSpec(
    label: 'tabs_friends',
    icon: CupertinoIcons.person_2,
    selectedIcon: CupertinoIcons.person_2_fill,
  ),
  FloatingTabSpec(
    label: 'tabs_lists',
    icon: CupertinoIcons.square_stack_3d_up,
    selectedIcon: CupertinoIcons.square_stack_3d_up_fill,
  ),
];

class FloatingTabBar extends StatelessWidget {
  const FloatingTabBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingChrome(
      isDark: isDark,
      hairline: true,
      shape: const StadiumBorder(),
      color: scheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: kFloatingTabBarHeight - 12,
          child: Row(
            children: [
              for (var i = 0; i < kFoquiTabs.length; i++)
                _TabButton(
                  spec: kFoquiTabs[i],
                  selected: selectedIndex == i,
                  onTap: () {
                    if (selectedIndex == i) return;
                    HapticFeedback.lightImpact();
                    onSelected(i);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.spec,
    required this.selected,
    required this.onTap,
  });

  final FloatingTabSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return Expanded(
      child: Tooltip(
        message: tr(spec.label),
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              // Zero alpha of the same color. Transparent is black, and
              // fading from black flashes a dark tint on press.
              color: scheme.primary.withValues(alpha: 0),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Icon(
                selected ? spec.selectedIcon : spec.icon,
                size: 26,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
