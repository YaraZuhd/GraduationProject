# Protect My Kids (PMK)

A Flutter mobile application that helps parents monitor and protect their children in real time using GPS tracking, geo-fencing, and push notifications.

---

## Features

- **Device Role Selection** — On first launch, choose whether the device belongs to a Parent or a Child.
- **Parent Sign Up / Sign In** — Secure authentication via Firebase Auth with email and password.
- **Child Device Registration** — Parents generate a unique 6-character pairing code; the child enters it to link their device.
- **Real-Time GPS Tracking** — The child's location is continuously streamed to Firestore and displayed on an interactive Google Map on the parent's device.
- **Red & Green Geo-Fencing Areas** — Parents define safe (green) and unsafe (red) zones by drawing on the map or entering coordinates manually.
- **Push Notifications** — The child can send a distress message to the parent via Firebase Cloud Messaging (FCM).
- **Application Usage Monitoring** — Parents can view app-usage statistics from the child's device.
- **History** — Browse previously defined geo-fence areas.
- **Profile** — View parent account details and linked child information.
- **Password Reset** — Reset your password via email using Firebase Auth.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Maps | Google Maps Flutter |
| Push Notifications | Firebase Cloud Messaging + flutter_local_notifications |
| Location | location package |
| HTTP | http / dio |

---

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── screens/
│   ├── parent_or_child.dart     # Role selection screen
│   ├── signin_screen.dart       # Parent sign-in
│   ├── signup_parent_screen.dart# Parent registration
│   ├── signup_child_screen.dart # Child device setup
│   ├── reset_password.dart      # Password reset
│   ├── nav.dart                 # Main navigation (drawer + map)
│   ├── home_screen.dart         # Home screen with map
│   ├── add_kid.dart             # Generate child pairing code
│   ├── add_favorite.dart        # Choose area determination method
│   ├── select_from_map.dart     # Draw areas on map
│   ├── select_coordinates.dart  # Enter area coordinates manually
│   ├── view_areas.dart          # History of defined areas
│   ├── location.dart            # Real-time child location tracker
│   ├── notification.dart        # Child notification sender
│   ├── notification_parent.dart # Parent notification receiver
│   ├── profile.dart             # User profile screen
│   ├── settings.dart            # App settings
│   └── ...
├── data/
│   ├── data_model.dart          # User/child data model
│   ├── data_repositry.dart      # Firestore CRUD operations
│   └── data_repositry_areas.dart# Firestore geo-fence area operations
├── reusable_widgets/
│   └── reusable_widget.dart     # Shared UI widgets
└── utils/
    └── color_utils.dart         # Hex color helper
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=2.16.2 <3.0.0`
- A Firebase project with the following services enabled:
  - Authentication (Email/Password)
  - Cloud Firestore
  - Firebase Cloud Messaging
- A Google Maps API key with the **Maps SDK for Android** and **Maps SDK for iOS** enabled.

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/YaraZuhd/GraduationProject.git
   cd GraduationProject
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase configuration**

   - Download `google-services.json` from your Firebase project and place it in `android/app/`.
   - Download `GoogleService-Info.plist` and place it in `ios/Runner/`.

4. **Google Maps API key**

   - Android: Add your key to `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <meta-data
         android:name="com.google.android.geo.API_KEY"
         android:value="YOUR_API_KEY"/>
     ```
   - iOS: Add your key to `ios/Runner/AppDelegate.swift`:
     ```swift
     GMSServices.provideAPIKey("YOUR_API_KEY")
     ```

5. **Run the app**

   ```bash
   flutter run
   ```

---

## How It Works

### Parent Flow
1. Open the app and select **Parent device**.
2. Sign in or create a new account.
3. From the navigation drawer, go to **Add Kid** and fill in the child's name and date of birth to generate a 6-character pairing code.
4. Share the code with your child.
5. Use **Track your Kids** to see the child's live location on the map.
6. Use **Determine Red & Green Areas** to set up geo-fencing zones.
7. Receive push notifications when the child sends a distress alert.

### Child Flow
1. Open the app on the child's device and select **Child device**.
2. Enter the child's name and the pairing code provided by the parent.
3. The app starts streaming the child's GPS location to Firestore in the background.
4. The child can tap **Send** on the notification screen to alert the parent.

---

## Firestore Data Structure

```
DataModel (collection)
  └── {docId}
        ├── username       : String
        ├── email          : String
        ├── password       : String   (hashed by Firebase Auth; stored for reference)
        ├── kidName        : String
        ├── childDateOB    : String   (YYYY-MM-DD)
        └── uniqueCode     : String   (6-char pairing code)

location (collection)
  └── user1
        ├── latitude  : double
        ├── longitude : double
        └── name      : String

Token_parent / Token_child (collections)
  └── user1
        └── TokenParent / TokenChild : String (FCM token)
```

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## License

This project was developed as a graduation project. All rights reserved.
