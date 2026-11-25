import 'package:foqui/models/block_list.dart';
import 'package:foqui/models/focus_label.dart';
import 'package:foqui/models/focus_session.dart';
import 'package:foqui/services/focus_repository.dart';

class MemoryFocusRepository extends FocusRepository {
  MemoryFocusRepository({
    List<BlockList> lists = const [],
    List<FocusSession> sessions = const [],
    List<FocusLabel> labels = const [],
    this.loaded = true,
  }) : lists = List.of(lists),
       sessions = List.of(sessions),
       labels = List.of(labels);

  List<BlockList> lists;
  List<FocusSession> sessions;
  List<FocusLabel> labels;

  final bool loaded;

  @override
  bool get hasLoaded => loaded;

  @override
  List<BlockList> readLists() => List.unmodifiable(lists);

  @override
  Future<void> writeLists(List<BlockList> value) async {
    lists = List.of(value);
  }

  @override
  List<FocusSession> readSessions() => List.unmodifiable(sessions);

  @override
  Future<void> writeSessions(List<FocusSession> value) async {
    sessions = List.of(trimSessions(value));
  }

  @override
  List<FocusLabel> readLabels() => List.unmodifiable(labels);

  @override
  Future<void> writeLabels(List<FocusLabel> value) async {
    labels = List.of(value);
  }
}
