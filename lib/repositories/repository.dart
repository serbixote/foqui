import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}

const usersCollection = 'users';
const usernamesCollection = 'usernames';
const blockListsCollection = 'blockLists';
const sessionsCollection = 'sessions';
const labelsCollection = 'labels';
const invitationsCollection = 'invitations';
const participantsCollection = 'participants';
const pauseRequestCollection = 'pauseRequest';
const currentPauseRequestId = 'current';
