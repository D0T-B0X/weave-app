import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weave_app/custom_widgets/constants.dart';
import 'package:weave_app/custom_widgets/bottom_app_bar.dart';
import 'package:weave_app/custom_widgets/participants_tile.dart';

// Define a User class that has active and inactive state
class User {
  final String id;
  final String name;
  final bool isActive;

  User({required this.id, required this.name, this.isActive = true});

  User copyWith({String? id, String? name, bool? isActive}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Provider for list of users with active/inactive state
final participantsProvider = StateProvider<List<User>>((ref) => [
      User(id: '1', name: 'User 1'),
      User(id: '2', name: 'User 2'),
      User(id: '3', name: 'User 3'),
      User(id: '4', name: 'User 4'),
      User(id: '5', name: 'User 5'),
      User(id: '6', name: 'User 6'),
      User(id: '7', name: 'User 7'),
    ]);

// Provider for the selected user index
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MeetingPage extends ConsumerWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the list of participants from the provider
    final participants = ref.watch(participantsProvider);

    // Convert User objects to names for ParticipantsTile
    final participantNames = participants.map((user) => user.name).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Expanded widget to make ParticipantsTile fill the available space
            Expanded(
              child: ParticipantsTile(users: participantNames),
            ),
          ],
        ),
      ),
      // Using the CustomAppBar from bottom_app_bar.dart
      bottomNavigationBar: const CustomAppBar(),
    );
  }
}

// Method to toggle a participant's active status based on audio input
void setUserActiveStatus(WidgetRef ref, String userId, bool isActive) {
  final participants = ref.read(participantsProvider);
  final updatedParticipants = [...participants];

  final index = updatedParticipants.indexWhere((user) => user.id == userId);
  if (index != -1) {
    final user = updatedParticipants[index];
    // Only update if the state has changed
    if (user.isActive != isActive) {
      updatedParticipants[index] = user.copyWith(isActive: isActive);
      ref.read(participantsProvider.notifier).state = updatedParticipants;
    }
  }
}

// Custom participant tile that reflects active/inactive state
// This isn't used here but shows how you could extend the functionality
Widget buildUserTile(User user) {
  return Container(
    decoration: BoxDecoration(
      color: user.isActive ? backgroundColor : Colors.grey.shade800,
      borderRadius: BorderRadius.circular(12),
      // Add a bright border when the user is active
      border: user.isActive ? Border.all(color: primaryColor, width: 2) : null,
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            user.isActive
                ? 'assets/icons/circle_user3.svg'
                : 'assets/icons/inactive_user.svg',
          ),
          const SizedBox(height: 8),
          Text(
            user.name,
            style: TextStyle(
              color: user.isActive ? Colors.white : Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            user.isActive ? "Active" : "Inactive",
            style: TextStyle(
              color: user.isActive ? primaryColor : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
