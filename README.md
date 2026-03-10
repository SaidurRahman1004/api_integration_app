# 📱 Flutter API Integration App

A clean, production-ready Flutter application demonstrating full **CRUD operations** integrated with a REST API. Built with a feature-based MVC architecture and GetX for reactive state management — delivering a fast, smooth, and professional user experience.

---

## 📸 Screenshots

|                Home (Post List)                 |                     Post Details                      |                     Create Post                     |
| :---------------------------------------------: | :---------------------------------------------------: | :-------------------------------------------------: |
| ![Home](https://i.postimg.cc/5972SgMv/Home.png) | ![Details](https://i.postimg.cc/T273J0Xg/details.png) | ![Create](https://i.postimg.cc/mZXgyjG1/create.png) |

|                    Edit Post                    |                 Delete Confirmation                 |
| :---------------------------------------------: | :-------------------------------------------------: |
| ![Edit](https://i.postimg.cc/qBbvxwdC/edit.png) | ![Delete](https://i.postimg.cc/T273J0X1/delete.png) |

---

## ✨ Features

- 📋 **View All Posts** — Fetches and displays all posts from the API with shimmer loading
- 🔍 **Post Details** — View full content of any post
- ✏️ **Edit Post** — Inline edit mode with form validation and instant UI update
- ➕ **Create Post** — Add new posts with title & body validation
- 🗑️ **Optimistic Delete** — Post is removed from the list **instantly** without any loading indicator; the API call runs silently in the background. If it fails, the post is automatically restored (rollback)
- 🔄 **Pull to Refresh** — Swipe down to reload the post list
- 📡 **Debug Logging** — Every API hit and response is logged to the terminal via `debugPrint`

---

## 🏗️ Architecture

Feature-based **MVC** pattern with GetX for state management and reactive UI.

```
lib/
├── core/
│   ├── const/
│   │   ├── app_colors.dart        # Global color constants
│   │   └── api_urls.dart          # Centralized API endpoint definitions
│   ├── global_widgets/
│   │   ├── custom_button.dart     # Reusable button with loading state
│   │   ├── custom_text_field.dart # Reusable text field with validation
│   │   ├── post_card.dart         # Post list item card
│   │   ├── loading_indicator.dart # Full-screen loading widget
│   │   └── empty_state.dart       # Empty list placeholder
│   └── network_caller/
│       ├── network_caller.dart    # Static HTTP client (GET, POST, PUT, DELETE)
│       └── network_response.dart  # Unified API response model
│
└── features/
    └── posts/
        ├── controller/
        │   └── post_controller.dart   # GetX controller — all business logic
        ├── model/
        │   └── post_model.dart        # Post data model with fromJson/toJson
        ├── view/
        │   ├── post_list_screen.dart    # Home screen with post list
        │   ├── post_details_screen.dart # Post detail & inline edit screen
        │   └── post_create_screen.dart  # New post creation screen
        └── widgets/
            ├── delete_confirm_dialog.dart # Reusable delete confirmation dialog
            ├── post_id_badge.dart         # Post ID display badge
            └── post_user_info_tile.dart   # User info tile widget
```

---

## ⚙️ Tech Stack

| Technology                   | Purpose                                             |
| ---------------------------- | --------------------------------------------------- |
| **Flutter**                  | Cross-platform UI framework                         |
| **Dart**                     | Programming language                                |
| **GetX** `^4.7.3`            | State management, navigation & dependency injection |
| **http** `^1.6.0`            | REST API communication                              |
| **flutter_spinkit** `^5.2.2` | Loading animations                                  |
| **intl** `^0.20.2`           | Date/number formatting                              |

---

## 🌐 API

This app consumes the **[JSONPlaceholder](https://jsonplaceholder.typicode.com)** public REST API.

| Operation        | Method   | Endpoint      |
| ---------------- | -------- | ------------- |
| Fetch all posts  | `GET`    | `/posts`      |
| Fetch post by ID | `GET`    | `/posts/{id}` |
| Create post      | `POST`   | `/posts`      |
| Update post      | `PUT`    | `/posts/{id}` |
| Delete post      | `DELETE` | `/posts/{id}` |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.11.1`
- Dart SDK (included with Flutter)
- An active internet connection

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/SaidurRahman1004/api_integration_app.git

# 2. Navigate to the project directory
cd api_integration_app

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

---

## 🔑 Key Implementation Highlights

### Optimistic Delete

When a user deletes a post, the item is removed from the UI **immediately** — no loading spinner, no waiting. The DELETE API request fires in the background. If it fails, the post is seamlessly **re-inserted** at its original position.

```dart
// Post removed from list instantly
postList.removeAt(removedIndex);

// API call runs in background (fire-and-forget)
NetworkCaller.deleteRequest(url: ApiUrls.postsById(id)).then((response) {
  if (!response.isSuccess) {
    postList.insert(removedIndex, removedPost); // rollback on failure
  }
});
```

### Centralized Network Layer

All HTTP communication goes through the `NetworkCaller` static class, which wraps every request in a try-catch and returns a unified `NetworkResponse` object — keeping controllers clean and decoupled from HTTP logic.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

<p align="center">Built with ❤️ using Flutter & GetX</p>
