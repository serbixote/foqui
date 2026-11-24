import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../models/session_chat.dart';
import '../models/shared_session.dart';
import '../models/user_profile.dart';
import '../repositories/invite.dart';
import '../screens/end_session_sheet.dart';
import '../screens/screen_time_sheet.dart';
import '../screens/session_chat_page.dart';
import '../screens/shared_session_sheets.dart';
import '../state/auth.dart';
import '../state/chat_seen.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import '../state/profile.dart';
import '../theme/app_theme.dart';
import 'motion.dart';
import 'sheet_header.dart';

const _liveGreen = Color(0xFF30D158);

/// Session sheet over the app.
///
/// The shell keeps this mounted. It rises in when a session is created or
/// started, and settles back when the session is stopped or left. A session
/// that has not been started yet uses the same sheet with the clock held.
/// Starting it is what makes the timer run.
class SessionLiveActivity extends ConsumerStatefulWidget {
  const SessionLiveActivity({super.key});

  @override
  ConsumerState<SessionLiveActivity> createState() =>
      _SessionLiveActivityState();
}

class _SessionLiveActivityState extends ConsumerState<SessionLiveActivity>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final AnimationController _slide = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  late final AnimationController _presence;
  late final CurvedAnimation _fade;
  late final Animation<Offset> _rise;
  FocusSession? _held;
  var _presenceQueued = false;
  Timer? _ticker;
  var _live = false;
  var _waiting = false;
  var _paused = false;
  var _open = false;
  var _busy = false;
  var _pausing = false;
  String? _publishedUsername;
  var _usernamePublishScheduled = false;
  String? _appliedGroupPause;
  String? _chatSessionId;
  var _chatOpen = false;
  var _chatStarting = false;

  @override
  void initState() {
    super.initState();
    _presence = AnimationController(vsync: this, duration: kMotionSheet);
    _fade = CurvedAnimation(
      parent: _presence,
      curve: kMotionCurve,
      reverseCurve: Curves.easeInCubic,
    );
    _rise = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(_fade);
    _presence.addStatusListener(_onPresence);
    final open = ref.read(focusControllerProvider).foregroundSession;
    if (open != null) {
      _held = open;
      _presence.value = 1;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _sync(ref.read(focusControllerProvider).foregroundSession);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _presence.removeStatusListener(_onPresence);
    _fade.dispose();
    _presence.dispose();
    _pulse.dispose();
    _slide.dispose();
    super.dispose();
  }

  void _onPresence(AnimationStatus status) {
    if (status != AnimationStatus.dismissed || !mounted) return;
    if (ref.read(focusControllerProvider).foregroundSession != null) return;
    if (_held == null) return;
    setState(() => _held = null);
  }

  /// Keeps the last sheet on screen long enough to slide it away.
  void _track(FocusSession? live) {
    if (live != null) {
      _held = live;
      final settling =
          _presence.status == AnimationStatus.reverse ||
          (_presence.value < 1 && !_presence.isAnimating);
      if (settling) _queuePresence();
      return;
    }
    if (_held != null &&
        _presence.value > 0 &&
        _presence.status != AnimationStatus.reverse) {
      _queuePresence();
    }
  }

  void _queuePresence() {
    if (_presenceQueued) return;
    _presenceQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenceQueued = false;
      if (!mounted) return;
      final live = ref.read(focusControllerProvider).foregroundSession;
      final reduced = MediaQuery.disableAnimationsOf(context);
      if (live != null) {
        _held = live;
        if (reduced || _presence.value == 1) {
          _presence.value = 1;
          return;
        }
        _presence.forward();
        return;
      }
      if (_held == null) return;
      if (reduced) {
        _presence.value = 0;
        return;
      }
      if (_presence.value > 0) _presence.reverse();
    });
  }

  void _sync(FocusSession? session) {
    final live = session != null;
    final waiting = session?.outcome == SessionOutcome.created;
    final paused = session?.outcome == SessionOutcome.paused;
    final open =
        session?.outcome == SessionOutcome.active && session?.endsAt == null;
    if (live == _live &&
        waiting == _waiting &&
        paused == _paused &&
        open == _open) {
      return;
    }
    _live = live;
    _waiting = waiting;
    _paused = paused;
    _open = open;

    if (live && !waiting && !paused) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
      _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
        unawaited(_tick());
      });
    } else {
      _pulse
        ..stop()
        ..value = 0;
      _ticker?.cancel();
      _ticker = null;
    }

    if (open) {
      if (!_slide.isAnimating) _slide.repeat();
    } else {
      _slide
        ..stop()
        ..value = 0;
    }
  }

  Future<void> _tick() async {
    if (!mounted) return;
    final session = ref.read(focusControllerProvider).activeSession;
    final endsAt = session?.endsAt;
    if (session != null && endsAt != null && !endsAt.isAfter(DateTime.now())) {
      await ref.read(focusControllerProvider.notifier).completeIfDue();
      return;
    }
    setState(() {});
  }

  /// A chime only while this app is open and the chat page is closed.
  /// The red dot uses the session document this sheet already watches.
  void _onSharedChat(
    AsyncValue<SharedSession?>? previous,
    AsyncValue<SharedSession?> next,
  ) {
    final after = next.asData?.value;
    final at = after?.chatAt;
    final by = after?.chatBy;
    if (after == null || at == null || by == null) return;
    if (_chatOpen) {
      ref.read(chatSeenProvider.notifier).mark(after.id, at);
      return;
    }
    final resumed =
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    if (!chatShouldChime(
      previousReady: previous?.asData != null,
      previousAt: previous?.asData?.value?.chatAt,
      nextAt: at,
      nextBy: by,
      userId: ref.read(authProvider).userId ?? '',
      chatVisible: false,
      appResumed: resumed,
    )) {
      return;
    }
    unawaited(SystemSound.play(SystemSoundType.alert));
  }

  void _openChat(SharedSession? shared) {
    final at = shared?.chatAt;
    final id = shared?.id;
    if (at != null && id != null) {
      ref.read(chatSeenProvider.notifier).mark(id, at);
    }
    setState(() => _chatOpen = true);
  }

  void _closeChat() => setState(() => _chatOpen = false);

  /// The chat is a real page, so the iOS edge swipe pops it.
  void _onChatPageRemoved(Page<Object?> page) {
    if (page.key != const ValueKey('session-chat') || !_chatOpen) return;
    setState(() => _chatOpen = false);
  }

  Future<void> _startChat(SharedSession shared) async {
    if (_chatStarting) return;
    setState(() => _chatStarting = true);
    try {
      final enabled = await ref
          .read(focusControllerProvider.notifier)
          .enableSharedChat();
      if (!mounted || !enabled) return;
      _openChat(shared);
    } catch (error, stack) {
      debugPrint('Could not start the chat: $error\n$stack');
    } finally {
      if (mounted) setState(() => _chatStarting = false);
    }
  }

  Future<void> _begin(FocusSession session) async {
    setState(() => _busy = true);
    try {
      final joined = session.sharedSessionId != null && !session.sharedHost;
      if (joined) {
        final shared = ref
            .read(sharedSessionProvider(session.sharedSessionId!))
            .asData
            ?.value;
        final code = session.inviteCode;
        if (shared == null || !shared.canStart || code == null) return;
        final started = await ref
            .read(focusControllerProvider.notifier)
            .startJoinedSession(
              listId: session.blockListId,
              shared: shared,
              inviteCode: code,
            );
        if (!started) return;
      } else {
        await ref
            .read(focusControllerProvider.notifier)
            .startSession(sessionId: session.id);
      }
      HapticFeedback.mediumImpact();
    } on FocusShieldException catch (error, stack) {
      debugPrint('Could not start the session: $error\n$stack');
      if (!mounted) return;
      if (error.code == 'NOT_AUTHORIZED') {
        await showScreenTimeSheet(context);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancel(FocusSession session) async {
    setState(() => _busy = true);
    try {
      await ref
          .read(focusControllerProvider.notifier)
          .discardSession(session.id);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pause(FocusSession session, {required bool group}) async {
    if (session.outcome != SessionOutcome.paused &&
        !canPauseSession(session, DateTime.now())) {
      await showPauseWaitSheet(context);
      return;
    }
    if (group && session.outcome != SessionOutcome.paused) {
      final confirmed = await showPauseRequestSheet(context);
      if (!confirmed || !mounted) return;
    }
    setState(() {
      _busy = true;
      _pausing = true;
    });
    try {
      final controller = ref.read(focusControllerProvider.notifier);
      if (session.outcome == SessionOutcome.paused) {
        await controller.resumeSession();
      } else if (group) {
        await controller.requestSharedPause();
      } else {
        await controller.pauseSession();
      }
      HapticFeedback.mediumImpact();
    } on FocusShieldException catch (error, stack) {
      debugPrint('Could not resume the session: $error\n$stack');
      if (!mounted) return;
      if (error.code == 'NOT_AUTHORIZED') {
        await showScreenTimeSheet(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _pausing = false;
        });
      }
    }
  }

  Future<void> _leave(FocusSession session) async {
    if (!canStopSession(session, DateTime.now())) {
      await showStopWaitSheet(context);
      return;
    }
    final confirmed = await showLeaveSessionSheet(context);
    if (!confirmed || !mounted) return;
    final userId = ref.read(authProvider).userId;
    final request = ref
        .read(pauseRequestProvider(session.sharedSessionId ?? ''))
        .asData
        ?.value;
    setState(() => _busy = true);
    try {
      await ref
          .read(focusControllerProvider.notifier)
          .leaveSession(
            cancelPause: request != null && request.requestedBy == userId,
          );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _vote({required bool accept}) async {
    setState(() => _busy = true);
    try {
      final controller = ref.read(focusControllerProvider.notifier);
      if (accept) {
        await controller.acceptSharedPause();
      } else {
        await controller.declineSharedPause();
      }
      HapticFeedback.mediumImpact();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _applyGroupPause(String sharedId) {
    if (sharedId.isEmpty || !mounted) return;
    final request = ref.read(pauseRequestProvider(sharedId)).asData?.value;
    final members = ref.read(participantsProvider(sharedId)).asData?.value;
    if (request == null || members == null) {
      _appliedGroupPause = null;
      return;
    }
    if (!pauseRequestAcceptedByAll(request, members)) return;
    final session = ref.read(focusControllerProvider).activeSession;
    if (session == null || session.sharedSessionId != sharedId) return;
    final key = _pauseKey(request);
    if (_appliedGroupPause == key) return;
    _appliedGroupPause = key;
    unawaited(ref.read(focusControllerProvider.notifier).pauseFromGroup());
  }

  String _pauseKey(PauseRequest request) {
    return '${request.requestedBy}:${request.createdAt?.millisecondsSinceEpoch ?? 0}';
  }

  /// Puts this account's username on the member document when it is missing.
  Future<void> _publishOwnUsername(String sharedId) async {
    if (sharedId.isEmpty || Firebase.apps.isEmpty) return;
    final username = ref
        .read(userProfileProvider)
        .asData
        ?.value
        .username
        ?.trim();
    final userId = ref.read(authProvider).userId;
    if (username == null || username.isEmpty || userId == null) return;
    if (_publishedUsername == username) return;
    final people = ref.read(participantsProvider(sharedId)).asData?.value;
    if (people == null) return;
    SessionParticipant? self;
    for (final person in people) {
      if (person.uid == userId) {
        self = person;
        break;
      }
    }
    if (self == null) return;
    if (self.username == username) {
      _publishedUsername = username;
      return;
    }
    final repository = ref.read(inviteRepositoryProvider);
    if (repository == null) return;
    _publishedUsername = username;
    try {
      await repository.publishUsername(sessionId: sharedId, username: username);
    } catch (error, stack) {
      debugPrint('Could not publish username: $error\n$stack');
      if (mounted) _publishedUsername = null;
    }
  }

  Future<void> _end() async {
    final session = ref.read(focusControllerProvider).foregroundSession;
    if (session != null && !canStopSession(session, DateTime.now())) {
      await showStopWaitSheet(context);
      return;
    }
    final confirmed = await showEndSessionSheet(context);
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref.read(focusControllerProvider.notifier).endSession();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final focus = ref.watch(focusControllerProvider);
    final live = focus.foregroundSession;
    _track(live);
    final session = live ?? _held;
    if (session?.id != _chatSessionId) {
      _chatSessionId = session?.id;
      _chatOpen = false;
    }
    final labels = focus.labels;
    final waiting = session?.outcome == SessionOutcome.created;
    ref.listen(focusControllerProvider, (previous, next) {
      _sync(next.foregroundSession);
    });
    final sharedId = session?.sharedSessionId ?? '';
    ref.listen(sharedSessionProvider(sharedId), (previous, next) {
      final shared = next.asData?.value;
      final current = ref.read(focusControllerProvider).foregroundSession;
      if (shared == null || current == null || current.sharedHost) return;
      if (current.sharedSessionId != shared.id) return;
      if (current.outcome == SessionOutcome.created) {
        if (shared.isOver) {
          unawaited(
            ref
                .read(focusControllerProvider.notifier)
                .discardSession(current.id),
          );
        }
        return;
      }
      final endsAt = shared.endsAt;
      final due = endsAt != null && !endsAt.isAfter(DateTime.now());
      if (shared.status == SharedSessionStatus.ended || due) {
        unawaited(ref.read(focusControllerProvider.notifier).endFromShared());
      }
    });
    ref.listen(sharedSessionProvider(sharedId), _onSharedChat);
    final members = ref.watch(participantsProvider(sharedId));
    final shared = ref.watch(sharedSessionProvider(sharedId)).asData?.value;
    final waitingForHost =
        waiting &&
        session?.sharedSessionId != null &&
        session?.sharedHost == false &&
        shared?.canStart != true;
    final request = ref.watch(pauseRequestProvider(sharedId)).asData?.value;
    ref.listen(pauseRequestProvider(sharedId), (_, _) {
      _applyGroupPause(sharedId);
    });
    ref.listen(participantsProvider(sharedId), (_, _) {
      _applyGroupPause(sharedId);
      unawaited(_publishOwnUsername(sharedId));
    });

    if (session == null) {
      return const IgnorePointer(child: SizedBox.expand());
    }

    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final shownAt = _shownAt(session, now);
    final paused = session.outcome == SessionOutcome.paused;
    final progress = _progress(session, shownAt);
    final running = !waiting && !paused;
    final people = members.asData?.value ?? const <SessionParticipant>[];
    final group = session.sharedSessionId != null && people.length > 1;
    final agreed =
        request != null && pauseRequestAcceptedByAll(request, people);
    final voteOpen = group && !waiting && !paused && request != null && !agreed;
    if (group && !waiting && agreed) {
      final key = _pauseKey(request);
      if (_appliedGroupPause != key) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _applyGroupPause(sharedId);
        });
      }
    }
    final userId = ref.watch(authProvider).userId ?? '';
    // Widget tests sign in without Firebase. The profile read needs it.
    final profile = Firebase.apps.isEmpty
        ? null
        : ref.watch(userProfileProvider).asData?.value;
    final handle = profile?.username?.trim();
    if (!_usernamePublishScheduled &&
        Firebase.apps.isNotEmpty &&
        sharedId.isNotEmpty &&
        handle != null &&
        handle.isNotEmpty &&
        people.any(
          (person) => person.uid == userId && person.username != handle,
        )) {
      _usernamePublishScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(_publishOwnUsername(sharedId));
      });
    }

    final chatOn = session.chatEnabled || shared?.chatEnabled == true;
    final showChat = _chatOpen;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final unread = chatIsUnread(
      chatAt: shared?.chatAt,
      chatBy: shared?.chatBy,
      userId: userId,
      seenAt: ref.watch(chatSeenProvider)[sharedId],
    );

    final sheet = Semantics(
      container: true,
      label: tr(
        'session_semantics',
        args: [
          _labelName(session, labels),
          session.outcomeLabel,
          blockListTitle(id: session.blockListId, name: session.blockListName),
        ],
      ),
      child: Material(
        color: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          side: BorderSide(color: FoquiColors.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          bottom: !showChat || keyboard == 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: showChat ? keyboard : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const SheetGrabber(),
                Expanded(
                  child: Navigator(
                    initialRoute: null,
                    onGenerateInitialRoutes: (navigator, initialRoute) =>
                        const <Route<dynamic>>[],
                    onDidRemovePage: _onChatPageRemoved,
                    pages: [
                      CupertinoPage(
                        key: const ValueKey('session'),
                        child: ColoredBox(
                          color: scheme.surface,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  18,
                                  20,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _BlockingCard(
                                      name: blockListTitle(
                                        id: session.blockListId,
                                        name: session.blockListName,
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.centerLeft,
                                            child: _ElapsedClock(
                                              elapsed: _elapsed(
                                                session,
                                                shownAt,
                                              ),
                                              total: _total(session),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        _StatusLine(
                                          label: session.outcomeLabel,
                                          live: running,
                                          pulse: _pulse,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    _LiveProgressBar(
                                      value: progress,
                                      slide: _slide,
                                      color: FoquiColors.violet,
                                      track: const Color(0xFF4A4A4E),
                                    ),
                                    const SizedBox(height: 22),
                                    _SessionHeading(
                                      labels: labels,
                                      selected: _selectedLabel(session, labels),
                                      onSelected: (index) {
                                        if (index < 0 ||
                                            index >= labels.length) {
                                          return;
                                        }
                                        unawaited(
                                          ref
                                              .read(
                                                focusControllerProvider
                                                    .notifier,
                                              )
                                              .setSessionLabel(
                                                sessionId: session.id,
                                                label: labels[index],
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    22,
                                    20,
                                    20,
                                  ),
                                  children: [
                                    _MemberList(
                                      members: _membersFor(
                                        session,
                                        members,
                                        userId: userId,
                                        profile: profile,
                                      ),
                                      session: session,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  8,
                                  20,
                                  12,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (chatOn || shared != null) ...[
                                      _ChatButton(
                                        enabled: chatOn,
                                        unread: unread,
                                        busy: _chatStarting,
                                        onPressed: chatOn
                                            ? () => _openChat(shared)
                                            : () => _startChat(shared!),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                    AnimatedSize(
                                      duration: kMotion,
                                      curve: kMotionCurve,
                                      alignment: Alignment.topCenter,
                                      child: voteOpen
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 12,
                                              ),
                                              child: _PauseVote(
                                                request: request,
                                                userId: userId,
                                                busy: _busy,
                                                onAccept: () =>
                                                    _vote(accept: true),
                                                onDecline: () =>
                                                    _vote(accept: false),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: double.infinity,
                                            ),
                                    ),
                                    MotionSwap(
                                      switchKey: waiting
                                          ? 'waiting'
                                          : 'running',
                                      child: waiting
                                          ? _WaitingActions(
                                              busy: _busy,
                                              canStart: !waitingForHost,
                                              onStart: () => _begin(session),
                                              onCancel: () => _cancel(session),
                                            )
                                          : _RunningActions(
                                              busy: _busy,
                                              pausing: _pausing,
                                              paused: paused,
                                              canPause:
                                                  !voteOpen &&
                                                  (paused ||
                                                      canPauseSession(
                                                        session,
                                                        now,
                                                      )),
                                              pauseMessage: voteOpen
                                                  ? tr('pause_request_waiting')
                                                  : null,
                                              onPause: () =>
                                                  _pause(session, group: group),
                                              onStop: group
                                                  ? () => _leave(session)
                                                  : _end,
                                              stopLabel: group
                                                  ? tr('session_leave')
                                                  : tr('session_stop'),
                                              stopTooltip:
                                                  canStopSession(session, now)
                                                  ? (group
                                                        ? tr(
                                                            'session_leave_action',
                                                          )
                                                        : tr('end_confirm'))
                                                  : tr(
                                                      'session_stop_wait',
                                                      args: [
                                                        '${minimumRecordedLength.inMinutes}',
                                                      ],
                                                    ),
                                              stopIcon: group
                                                  ? CupertinoIcons
                                                        .person_crop_circle_badge_minus
                                                  : CupertinoIcons.stop_fill,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_chatOpen)
                        CupertinoPage(
                          key: const ValueKey('session-chat'),
                          child: ColoredBox(
                            color: scheme.surface,
                            child: SessionChatPage(
                              sessionId: sharedId,
                              onBack: _closeChat,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        FadeTransition(opacity: _fade, child: const _SessionVeil()),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: SlideTransition(position: _rise, child: sheet),
        ),
      ],
    );
  }

  DateTime _shownAt(FocusSession session, DateTime now) {
    if (session.outcome == SessionOutcome.paused) {
      return session.pausedAt ?? now;
    }
    return now;
  }

  double? _progress(FocusSession? session, DateTime now) {
    if (session == null) return 0;
    if (session.outcome == SessionOutcome.created) return 0;
    final endsAt = session.endsAt;
    if (endsAt == null) return null;
    final total = endsAt.difference(session.startedAt).inMilliseconds;
    if (total <= 0) return 1;
    final elapsed = now.difference(session.startedAt).inMilliseconds;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  /// Time already spent. A session that has not started yet stays at zero.
  String _elapsed(FocusSession session, DateTime now) {
    if (session.outcome == SessionOutcome.created) {
      return formatRemaining(Duration.zero);
    }
    final span = now.difference(session.startedAt);
    return formatRemaining(span.isNegative ? Duration.zero : span);
  }

  /// Length chosen for the session, as a clock. Null when none was set.
  String? _total(FocusSession session) {
    final endsAt = session.endsAt;
    if (endsAt == null) return null;
    final span = endsAt.difference(session.startedAt);
    if (!span.isNegative && span > Duration.zero) {
      return formatRemaining(span);
    }
    return null;
  }
}

String _labelName(FocusSession session, List<FocusLabel> labels) {
  final label = labelForId(session.labelId, labels);
  if (label == null) return localizedLabelName(id: session.labelId);
  return localizedLabelName(id: label.id, name: label.name);
}

class _RunningActions extends StatelessWidget {
  const _RunningActions({
    required this.busy,
    required this.pausing,
    required this.paused,
    required this.canPause,
    required this.pauseMessage,
    required this.onPause,
    required this.onStop,
    required this.stopLabel,
    required this.stopTooltip,
    required this.stopIcon,
  });

  final bool busy;
  final bool pausing;
  final bool paused;
  final bool canPause;
  final String? pauseMessage;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final String stopLabel;
  final String stopTooltip;
  final IconData stopIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Tooltip(
            message:
                pauseMessage ??
                (paused
                    ? tr('session_resume_action')
                    : canPause
                    ? tr('session_pause_action')
                    : tr(
                        'session_pause_wait',
                        args: ['${minimumPauseLength.inMinutes}'],
                      )),
            child: FilledButton.icon(
              onPressed: busy || (pauseMessage != null && !canPause)
                  ? null
                  : onPause,
              style: FilledButton.styleFrom(
                backgroundColor: FoquiColors.raised,
                foregroundColor: scheme.onSurface,
                disabledBackgroundColor: FoquiColors.raised,
                disabledForegroundColor: scheme.onSurface.withValues(
                  alpha: 0.4,
                ),
                minimumSize: const Size.fromHeight(52),
              ),
              icon: MotionSwap(
                switchKey: pausing
                    ? 'busy'
                    : paused
                    ? 'resume'
                    : 'pause',
                alignment: Alignment.center,
                child: pausing
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: scheme.onSurface,
                        ),
                      )
                    : Icon(
                        paused
                            ? CupertinoIcons.play_fill
                            : CupertinoIcons.pause,
                        size: 16,
                      ),
              ),
              label: MotionSwap(
                switchKey: paused,
                alignment: Alignment.centerLeft,
                child: Text(
                  paused ? tr('session_resume') : tr('session_pause'),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Tooltip(
            message: stopTooltip,
            child: FilledButton.icon(
              onPressed: busy ? null : onStop,
              style: FilledButton.styleFrom(
                backgroundColor: FoquiColors.destructive,
                foregroundColor: Colors.white,
                disabledBackgroundColor: FoquiColors.destructive.withValues(
                  alpha: 0.4,
                ),
                disabledForegroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
              ),
              icon: MotionSwap(
                switchKey: busy && !pausing ? 'busy' : stopIcon,
                alignment: Alignment.center,
                child: busy && !pausing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(stopIcon, size: 16),
              ),
              label: Text(stopLabel),
            ),
          ),
        ),
      ],
    );
  }
}

class _PauseVote extends StatelessWidget {
  const _PauseVote({
    required this.request,
    required this.userId,
    required this.busy,
    required this.onAccept,
    required this.onDecline,
  });

  final PauseRequest request;
  final String userId;
  final bool busy;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mine = request.requestedBy == userId;
    final accepted = request.hasAccepted(userId);
    final message = mine
        ? tr('pause_request_waiting')
        : accepted
        ? tr('pause_request_accepted')
        : tr('pause_request_incoming', args: [request.requestedName]);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: FoquiColors.grouped,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface,
                height: 1.35,
              ),
            ),
            if (!mine && !accepted) ...[
              const SizedBox(height: 8),
              FilledButton(
                onPressed: busy ? null : onAccept,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(tr('pause_request_accept')),
              ),
            ],
            TextButton(
              onPressed: busy ? null : onDecline,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
              child: Text(
                mine ? tr('pause_request_cancel') : tr('pause_request_decline'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaitingActions extends StatelessWidget {
  const _WaitingActions({
    required this.busy,
    required this.canStart,
    required this.onStart,
    required this.onCancel,
  });

  final bool busy;
  final bool canStart;
  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!canStart) ...[
          Text(
            tr('invite_waiting'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
        ],
        FilledButton.icon(
          onPressed: busy || !canStart ? null : onStart,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          icon: busy
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: onPrimary,
                  ),
                )
              : const Icon(CupertinoIcons.play_fill, size: 16),
          label: Text(tr('sign_in_start')),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: busy ? null : onCancel,
          child: Text(tr('common_cancel')),
        ),
      ],
    );
  }
}

int _selectedLabel(FocusSession session, List<FocusLabel> labels) {
  if (labels.isEmpty) return 0;
  final shown = labelForId(session.labelId, labels);
  if (shown == null) return 0;
  final index = labels.indexWhere((label) => label.id == shown.id);
  if (index >= 0) return index;
  final focus = labels.indexWhere((label) => label.id == focusTimeLabelId);
  return focus < 0 ? 0 : focus;
}

const _labelPadLeft = 12.0;
const _emojiSlot = 32.0;
const _emojiGap = 10.0;

/// Label and the menu for changing it.
class _SessionHeading extends StatefulWidget {
  const _SessionHeading({
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  final List<FocusLabel> labels;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  State<_SessionHeading> createState() => _SessionHeadingState();
}

class _SessionHeadingState extends State<_SessionHeading> {
  var _open = false;
  int? _pending;
  Timer? _commit;

  @override
  void dispose() {
    _commit?.cancel();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.selectionClick();
    setState(() => _open = !_open);
  }

  void _choose(int index) {
    HapticFeedback.selectionClick();
    if (index == widget.selected && _pending == null) {
      setState(() => _open = false);
      return;
    }
    setState(() => _pending = index);
    _commit?.cancel();
    _commit = Timer(const Duration(milliseconds: 320), () {
      if (!mounted) return;
      widget.onSelected(index);
      setState(() {
        _pending = null;
        _open = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.labels;
    if (labels.isEmpty) return const SizedBox.shrink();
    final selected = widget.selected.clamp(0, labels.length - 1).toInt();
    final label = labels[selected];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Tooltip(
          message: tr('session_choose_label'),
          child: Material(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(_labelPadLeft, 8, 14, 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: _emojiSlot,
                      height: _emojiSlot,
                      child: Center(
                        child: Text(
                          label.emoji,
                          style: const TextStyle(fontSize: 24, height: 1),
                        ),
                      ),
                    ),
                    const SizedBox(width: _emojiGap),
                    Expanded(
                      child: Text(
                        localizedLabelName(id: label.id, name: label.name),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: kMotion,
                      curve: kMotionCurve,
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        size: 16,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _open
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: MotionIn(
                    child: _LabelMenu(
                      labels: labels,
                      selected: _pending ?? selected,
                      onChoose: _choose,
                    ),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.label,
    required this.live,
    required this.pulse,
  });

  final String label;
  final bool live;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LiveDot(
          pulse: pulse,
          color: live ? _liveGreen : FoquiColors.secondaryLabel,
          animate: live,
        ),
        const SizedBox(width: 6),
        MotionSwap(
          switchKey: label,
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              height: 1.1,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _LabelMenu extends StatelessWidget {
  const _LabelMenu({
    required this.labels,
    required this.selected,
    required this.onChoose,
  });

  final List<FocusLabel> labels;
  final int selected;
  final ValueChanged<int> onChoose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 240),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < labels.length; i++)
                InkWell(
                  onTap: () => onChoose(i),
                  child: AnimatedContainer(
                    duration: kMotion,
                    curve: kMotionCurve,
                    color: theme.colorScheme.primary.withValues(
                      alpha: i == selected ? 0.16 : 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        _labelPadLeft,
                        12,
                        14,
                        12,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: _emojiSlot,
                            child: Text(
                              labels[i].emoji,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, height: 1),
                            ),
                          ),
                          const SizedBox(width: _emojiGap),
                          Expanded(
                            child: Text(
                              localizedLabelName(
                                id: labels[i].id,
                                name: labels[i].name,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: nameStyle,
                            ),
                          ),
                          if (i == selected)
                            Icon(
                              CupertinoIcons.checkmark,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ElapsedClock extends StatelessWidget {
  const _ElapsedClock({required this.elapsed, required this.total});

  final String elapsed;
  final String? total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const figures = [FontFeature.tabularFigures()];
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          elapsed,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            height: 1,
            fontFeatures: figures,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (total != null)
          Text(
            ' / $total',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.3,
              height: 1,
              fontFeatures: figures,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

/// Foqui, cropped in so the character fills the blocking card.
class _FoquiMark extends StatelessWidget {
  const _FoquiMark();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 56,
      height: 52,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: 96,
          maxHeight: 88,
          alignment: Alignment(-0.22, 0.12),
          child: Image(
            image: AssetImage('assets/images/foqui.png'),
            width: 96,
            height: 88,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
        ),
      ),
    );
  }
}

class _BlockingCard extends StatelessWidget {
  const _BlockingCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: FoquiColors.separator),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const _FoquiMark(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 1,
                height: 40,
                child: ColoredBox(color: FoquiColors.separator),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('session_blocking'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurfaceVariant,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          CupertinoIcons.lock_fill,
                          size: 13,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberLine {
  const _MemberLine({required this.alias, this.username});

  final String alias;
  final String? username;
}

List<_MemberLine> _membersFor(
  FocusSession session,
  AsyncValue<List<SessionParticipant>> members, {
  required String userId,
  required UserProfile? profile,
}) {
  if (session.sharedSessionId == null) return [_localMember(profile)];
  final people = members.asData?.value;
  if (people == null || people.isEmpty) return [_localMember(profile)];
  final lines = <_MemberLine>[
    for (final person in people)
      if (person.name.isNotEmpty)
        _MemberLine(
          alias: person.name,
          username: _usernameFor(person, userId: userId, profile: profile),
        ),
  ];
  if (lines.isEmpty) return [_localMember(profile)];
  return lines;
}

_MemberLine _localMember(UserProfile? profile) {
  final alias = profile?.alias?.trim();
  final username = profile?.username?.trim();
  if (alias != null && alias.isNotEmpty) {
    return _MemberLine(alias: alias, username: username);
  }
  return _MemberLine(alias: tr('session_you'), username: username);
}

String? _usernameFor(
  SessionParticipant person, {
  required String userId,
  required UserProfile? profile,
}) {
  final stored = person.username?.trim();
  if (stored != null && stored.isNotEmpty) return stored;
  if (person.uid != userId) return null;
  final own = profile?.username?.trim();
  if (own == null || own.isEmpty) return null;
  return own;
}

class _ChatButton extends StatelessWidget {
  const _ChatButton({
    required this.enabled,
    required this.unread,
    required this.busy,
    required this.onPressed,
  });

  final bool enabled;
  final bool unread;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = enabled ? tr('session_chat') : tr('session_chat_start');
    return Tooltip(
      message: unread ? tr('session_chat_unread') : label,
      child: FilledButton.icon(
        onPressed: busy ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: FoquiColors.raised,
          foregroundColor: scheme.onSurface,
          disabledBackgroundColor: FoquiColors.raised,
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.4),
          minimumSize: const Size.fromHeight(48),
        ),
        icon: busy
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: scheme.onSurface,
                ),
              )
            : _ChatGlyph(unread: unread),
        label: Text(label),
      ),
    );
  }
}

class _ChatGlyph extends StatelessWidget {
  const _ChatGlyph({required this.unread});

  final bool unread;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(CupertinoIcons.chat_bubble_fill, size: 20),
          if (unread)
            const Positioned(
              right: -1,
              top: -1,
              child: DecoratedBox(
                key: Key('chat-unread'),
                decoration: BoxDecoration(
                  color: FoquiColors.destructive,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(width: 8, height: 8),
              ),
            ),
        ],
      ),
    );
  }
}

class _ShareButton extends ConsumerStatefulWidget {
  const _ShareButton({required this.session});

  final FocusSession session;

  @override
  ConsumerState<_ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends ConsumerState<_ShareButton> {
  var _sharing = false;

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final url = await ref
          .read(focusControllerProvider.notifier)
          .shareLink(widget.session.id);
      if (!mounted || url == null) return;
      final box = context.findRenderObject() as RenderBox?;
      final origin = box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size;
      await SharePlus.instance.share(
        ShareParams(
          text: tr('invite_share_message', args: [url]),
          sharePositionOrigin: origin,
        ),
      );
    } catch (error, stack) {
      debugPrint('Could not share the session: $error\n$stack');
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tr('session_share'),
      child: TextButton.icon(
        onPressed: _sharing ? null : _share,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          minimumSize: const Size(0, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        icon: const Icon(CupertinoIcons.square_arrow_up, size: 22),
        label: Text(tr('session_share')),
      ),
    );
  }
}

class _MemberList extends StatelessWidget {
  const _MemberList({required this.members, required this.session});

  final List<_MemberLine> members;
  final FocusSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.titleMedium?.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      height: 1.2,
      color: theme.colorScheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                tr('session_members', args: ['${members.length}']),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            _ShareButton(session: session),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < members.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _MemberRow(member: members[i], nameStyle: nameStyle),
        ],
      ],
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member, required this.nameStyle});

  final _MemberLine member;
  final TextStyle? nameStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = member.username?.trim();

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.22),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.person_fill,
            size: 22,
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: member.alias,
              style: nameStyle,
              children: [
                if (handle != null && handle.isNotEmpty)
                  TextSpan(
                    text: ' ($handle)',
                    style: nameStyle?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot({
    required this.pulse,
    required this.color,
    required this.animate,
  });

  final Animation<double> pulse;
  final Color color;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      key: const Key('session-status-dot'),
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    if (!animate) {
      return SizedBox(width: 16, height: 16, child: Center(child: dot));
    }
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(pulse.value);
        return SizedBox(
          width: 16,
          height: 16,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 8 + (8 * t),
                height: 8 + (8 * t),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.28 * (1 - t)),
                  shape: BoxShape.circle,
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: dot,
    );
  }
}

class _LiveProgressBar extends StatelessWidget {
  const _LiveProgressBar({
    required this.value,
    required this.slide,
    required this.color,
    required this.track,
  });

  /// Null draws a moving segment for sessions with no end time.
  final double? value;
  final Animation<double> slide;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: SizedBox(
        height: 6,
        child: value == null
            ? AnimatedBuilder(
                animation: slide,
                builder: (context, _) => _Track(
                  value: null,
                  slide: slide.value,
                  color: color,
                  track: track,
                ),
              )
            : TweenAnimationBuilder<double>(
                tween: Tween<double>(end: value!.clamp(0, 1).toDouble()),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, animated, _) => _Track(
                  value: animated,
                  slide: 0,
                  color: color,
                  track: track,
                ),
              ),
      ),
    );
  }
}

class _Track extends StatelessWidget {
  const _Track({
    required this.value,
    required this.slide,
    required this.color,
    required this.track,
  });

  final double? value;
  final double slide;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fill = (width * (value ?? 0)).clamp(0.0, width).toDouble();
        return Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: track)),
            if (value != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: fill,
                child: ColoredBox(color: color),
              )
            else
              _SlidingSegment(width: width, slide: slide, color: color),
          ],
        );
      },
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

class _SlidingSegment extends StatelessWidget {
  const _SlidingSegment({
    required this.width,
    required this.slide,
    required this.color,
  });

  final double width;
  final double slide;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final segment = width * 0.34;
    final dx = (width + segment) * slide - segment;
    return Stack(
      children: [
        Positioned(
          left: dx,
          width: segment,
          top: 0,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0),
                  color,
                  color.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
