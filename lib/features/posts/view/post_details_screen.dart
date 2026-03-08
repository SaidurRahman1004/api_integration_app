import 'package:api_integration_app/core/global_widgets/custom_button.dart';
import 'package:api_integration_app/core/global_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/global_widgets/loading_indicator.dart';
import '../controller/post_controller.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;

  const PostDetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final RxBool isEditMode = false.obs;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPostDetails(postController, postId, titleController, bodyController);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(isEditMode.value ? Icons.close : Icons.edit),
              onPressed: () {
                if (isEditMode.value) {
                  final post = postController.selectedPost.value;
                  if (post != null) {
                    titleController.text = post.title;
                    bodyController.text = post.body;
                  }
                }
                isEditMode.value = !isEditMode.value;
              },
              tooltip: isEditMode.value ? 'Cancel' : 'Edit',
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const LoadingIndicator();
        }
        final post = postController.selectedPost.value;
        if (post == null) {
          return const Center(child: Text('Post not found'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // Post ID Badge
                _buildPostIdBadge(post.id),
                const SizedBox(height: 20),

                // User ID Info
                _buildUserInfo(post.userId),
                const SizedBox(height: 20),
                // Title Field
                Obx(
                  () => CustomTextField(
                    controller: titleController,
                    label: 'Title',
                    hint: 'Enter title',
                    readOnly: !isEditMode.value,
                    validator: (value) {
                      if (isEditMode.value &&
                          (value == null || value.isEmpty)) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextField(
                    controller: bodyController,
                    label: 'Content',
                    hint: 'Enter content',
                    maxLines: 10,
                    readOnly: !isEditMode.value,
                    validator: (value) {
                      if (isEditMode.value &&
                          (value == null || value.isEmpty)) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  //hide button if editing mode
                  if (!isEditMode.value) return const SizedBox.shrink();
                  return CustomButton(
                    text: 'Update Post',
                    onPressed: () => _onTapUpdatePost(
                      formKey,
                      postController,
                      postId,
                      titleController,
                      bodyController,
                      isEditMode,
                    ),
                    isLoading: postController.isLoading.value,
                    color: AppColors.success,
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  //Post ID Badge
  Widget _buildPostIdBadge(int id) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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

  // User Info User id
  Widget _buildUserInfo(int userId) {
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

  // Load Post Logic
  Future<void> _loadPostDetails(
    PostController postController,
    int postId,
    TextEditingController titleController,
    TextEditingController bodyController,
  ) async {
    await postController.fetchPostsById(postId);
    final post = postController.selectedPost.value;
    if (post != null) {
      titleController.text = post.title;
      bodyController.text = post.body;
    }
  }

  //Update Post Logic
  Future<void> _onTapUpdatePost(
    GlobalKey<FormState> formKey,
    PostController postController,
    int postId,
    TextEditingController titleController,
    TextEditingController bodyController,
    RxBool isEditMode,
  ) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (postController.isLoading.value) {
      return;
    }

    final success = await postController.updatePost(
      id: postId,
      title: titleController.text.trim(),
      body: bodyController.text.trim(),
    );

    if (success) {
      isEditMode.value = false;
    }
  }
}
