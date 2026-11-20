import 'package:flutter/cupertino.dart';

import '../l10n/tr.dart';
import '../widgets/empty_state.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/screen_header.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, kFloatingContentInset),
        children: [
          ScreenHeader(
            title: tr('friends_title'),
            subtitle: tr('friends_subtitle'),
          ),
          const SizedBox(height: 48),
          EmptyState(
            icon: CupertinoIcons.person_2,
            message: tr('friends_empty'),
          ),
        ],
      ),
    );
  }
}
