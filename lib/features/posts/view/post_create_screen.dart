import 'package:api_integration_app/core/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/global_widgets/custom_text_field.dart';
import '../controller/post_controller.dart';
import 'package:get/get.dart';

class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Post'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.create,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              // Title Field
              CustomTextField(
                controller: titleController,
                label: 'Post Title',
                hint: 'Enter post title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  if (value.length < 3) {
                    return 'Title must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Body Field
              CustomTextField(
                controller: bodyController,
                label: 'Post Content',
                hint: 'Enter post content',
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter post content';
                  }
                  if (value.length < 10) {
                    return 'Content must be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              //Button
              Obx(
                () => CustomButton(
                  text: 'Create Post',
                  isLoading: postController.isLoading.value,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      postController.createPost(
                        title: titleController.text.trim(),
                        body: bodyController.text.trim(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
