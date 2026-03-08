import 'package:api_integration_app/core/const/api_urls.dart';
import 'package:api_integration_app/core/network_caller/network_caller.dart';
import 'package:api_integration_app/features/posts/model/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<PostModel> postList = <PostModel>[].obs;
  final Rx<PostModel?> selectedPost = Rx<PostModel?>(null);

  //Read all
  Future<bool> fetchPosts() async {
    isLoading.value = true;
    final response = await NetworkCaller.getRequest(url: ApiUrls.posts);
    isLoading.value = false;
    if (response.isSuccess) {
      var fetchedPosts = (response.responseData as List)
          .map((item) => PostModel.fromJson(item))
          .toList();
      postList.assignAll(fetchedPosts);
      Get.snackbar(
        'Success',
        'Posts loaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } else {
      Get.snackbar(
        'Error',
        response.errorMessage ?? 'Failed to load posts',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  //Read by id
  Future<bool> fetchPostsById(int id) async {
    isLoading.value = true;
    final response = await NetworkCaller.getRequest(url: ApiUrls.postsById(id));
    isLoading.value = false;
    if (response.isSuccess) {
      selectedPost.value = PostModel.fromJson(response.responseData);
      return true;
    } else {
      Get.snackbar(
        'Error',
        'Failed to load posts',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  //create
  Future<bool> createPost({required String title, required String body}) async {
    if (isLoading.value) return false;
    isLoading.value = true;
    final response = await NetworkCaller.postRequest(
      url: ApiUrls.posts,
      body: {'title': title, 'body': body, 'userId': 1},
    );
    isLoading.value = false;
    if (response.isSuccess) {
      final newPost = PostModel.fromJson(response.responseData);
      postList.insert(0, newPost);
      Get.back();
      Get.snackbar(
        'Success',
        'Post created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      //back previous page with dealy
      await Future.delayed(const Duration(milliseconds: 300));
      return true;
    } else {
      Get.snackbar(
        'Error',
        'Failed to create post',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  //update
  Future<bool> updatePost({
    required int id,
    required String title,
    required String body,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;
    final response = await NetworkCaller.putRequest(
      url: ApiUrls.postsById(id),
      body: {'id': id, 'title': title, 'body': body, 'userId': 1},
    );
    isLoading.value = false;
    if (response.isSuccess) {
      int isNotFound = -1;
      final index = postList.indexWhere((post) => post.id == id);
      if (index != isNotFound) {
        postList[index] = PostModel.fromJson(response.responseData);
      }
      //Update selected post
      selectedPost.value = PostModel.fromJson(response.responseData);
      Get.snackbar(
        'Success',
        'Post updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } else {
      Get.snackbar(
        'Error',
        'Failed to update post',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Optimistic Delete
  Future<bool> deletePost(int id) async {
    // find post from list
    final int removedIndex = postList.indexWhere((post) => post.id == id);
    if (removedIndex == -1) return false;
    final PostModel removedPost = postList[removedIndex];

    // remove post from list without isloading
    postList.removeAt(removedIndex);

    //call api from bg without await
    NetworkCaller.deleteRequest(url: ApiUrls.postsById(id)).then((response) {
      if (response.isSuccess) {
        Get.snackbar(
          'Deleted',
          'Post deleted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        // if api fail then rollback
        postList.insert(removedIndex, removedPost);
        Get.snackbar(
          'Error',
          response.errorMessage ?? 'Failed to delete post. Restored.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    });

    return true;
  }
}
