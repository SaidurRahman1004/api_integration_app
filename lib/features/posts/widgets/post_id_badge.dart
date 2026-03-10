import 'package:flutter/material.dart';
import '../../../../core/const/app_colors.dart';

class PostIdBadge extends StatelessWidget {
  final int id;

  const PostIdBadge({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.tag, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Text(
            'Post ID: $id',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
