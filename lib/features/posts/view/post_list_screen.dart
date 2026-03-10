import 'package:api_integration_app/core/global_widgets/post_card.dart';
import 'package:api_integration_app/features/posts/controller/post_controller.dart';
import 'package:api_integration_app/features/posts/view/post_create_screen.dart';
import 'package:api_integration_app/features/posts/view/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/global_widgets/empty_state.dart';
import '../../../core/global_widgets/loading_indicator.dart';
import '../widgets/delete_confirm_dialog.dart';

class PostListScreen extends StatelessWidget {
  PostListScreen({super.key});

  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    //load all posts when Screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.fetchPosts();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        //loading
        if (postController.isLoading.value) {
          return const LoadingIndicator();
        }
        //emty
        if (postController.postList.isEmpty) {
          return const EmptyState();
        }

        //PostList
        return RefreshIndicator(
          onRefresh: () => postController.fetchPosts(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: postController.postList.length,
            itemBuilder: (_, index) {
              final post = postController.postList[index];
              return PostCard(
                post: post,
                onTap: () => Get.to(() => PostDetailsScreen(postId: post.id)),
                onDelete: () {
                  DeleteConfirmDialog.show(
                    context,
                    onDelete: () => postController.deletePost(post.id),
                  );
                },
              );
            },
          ),
        );
      }),
      //floating button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => PostCreateScreen()),
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        label: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
