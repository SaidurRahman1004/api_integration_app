import 'package:flutter/material.dart';

class PostUserInfoTile extends StatelessWidget {
  final int userId;

  const PostUserInfoTile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            'User ID: $userId',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
