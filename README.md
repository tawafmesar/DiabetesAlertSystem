
<img  alt="Loading" src="https://github.com/user-attachments/assets/727d414f-b446-4d48-af8d-86163f52d2e7" />

# DiabetesAlertSystem
A smart diabetes management application — cross-platform mobile frontend built with Flutter (Dart) and a lightweight PHP + MySQL backend. Features real-time blood sugar tracking, configurable alerts, medication reminders, activity logs, and simple REST-style endpoints to enable integration with other systems.

> This document provides a clear project overview, technical architecture, deployment and development instructions, API references, and contribution guidelines suitable for professional audiences (maintainers, reviewers, and developers).

---

**Table of Contents**

- [Project Overview](#project-overview)  
- [Key Features](#key-features)  
- [Screenshots](#screenshots)  
- [Technology Stack](#technology-stack)  
- [Repository Structure (high-level)](#repository-structure-high-level)  
- [Quick Start — Local Development](#quick-start--local-development)  
  - [Prerequisites](#prerequisites)  
  - [Backend (PHP + MySQL)](#backend-php--mysql)  
  - [Frontend (Flutter)](#frontend-flutter)  
- [Configuration & Environment](#configuration--environment)  
- [Database](#database)  
- [API Reference (summary)](#api-reference-summary)  
- [Testing](#testing)  
- [Building & Release](#building--release)  
- [Contributing](#contributing)  
- [Security & Privacy Notes](#security--privacy-notes)  
- [License](#license)  
- [Contact / Maintainers](#contact--maintainers)  
- [Appendix — Useful commands & tips](#appendix--useful-commands--tips)

---

<a name="project-overview"></a>
## Project Overview

DiabetesAlertSystem is a cross-platform mobile application for tracking and managing diabetes-related health metrics. The app lets patients record metrics (blood sugar, blood pressure, heart rate), receive alerts, store medication schedules, and view historical metrics. The backend is a lightweight PHP-based API that stores users, metrics, alarms and medication records in a MySQL database.

This repository contains:
- Flutter app source (src/diabetes_alert_system/)
- PHP backend API (src/backend/)
- SQL schema and seed data (src/backend/database/)
- Supporting scripts and utilities

Before making the repository public, ensure all secrets are removed from source control (see Security & Privacy Notes).

---

<a name="key-features"></a>
## Key Features

- User authentication endpoints (login/signup flows).
- Persistent user metrics (blood sugar, blood pressure, heart rate).
- Alarm management (create/view/remove alarms).
- Medication records and simple CRUD.
- A Flutter frontend with organized screens and controllers.
- Lightweight PHP backend using PDO with JSON responses.
- Exportable SQL schema to easily initialize a database.

---

<a name="screenshots"></a>
## Screenshots


|                                           Splash Animation 1                                          |                                           Splash Animation 2                                          |                                           Registration Screen                                           |                                           Email Verification Screen                                           |                                           Success Registration Screen                                           |
| :---------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------: |
| ![Splash Animation1](https://github.com/user-attachments/assets/16e485ef-25fc-4843-bcf9-a414b5475ad1) | ![Splash Animation2](https://github.com/user-attachments/assets/93e00f7e-f1b0-4551-b96f-1c38fb5a45e4) | ![Registration Screen](https://github.com/user-attachments/assets/ebac2389-4bcb-469a-8478-d946dff03e9b) | ![Email Verification Screen](https://github.com/user-attachments/assets/0a6223cb-64e7-43be-a0d8-39e396903f03) | ![Success Registration Screen](https://github.com/user-attachments/assets/fa33b3e2-b536-4c7a-b730-74b40d327ad4) |

|                                           Login Screen                                           |                                           Forget Password Screen                                           |                                           Verification Code Screen                                           |                                           Reset Password Screen                                           |                                           Password Reset Success Screen                                           |
| :----------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------: |
| ![Login Screen](https://github.com/user-attachments/assets/bd5838bd-6af9-49af-8fdc-77cec8fd3720) | ![Forget Password Screen](https://github.com/user-attachments/assets/8c4bc3a1-271b-491d-bef0-58b3fe636f90) | ![Verification Code Screen](https://github.com/user-attachments/assets/74fd6ec8-507a-4009-ac3c-2b601210484b) | ![Reset Password Screen](https://github.com/user-attachments/assets/d32c93c3-ece9-4c58-b4c4-a750580776eb) | ![Password Reset Success Screen](https://github.com/user-attachments/assets/d5b47d8f-2925-4377-bb34-02a732fcddc3) |

|                                           Bottom Navigation                                           |                                           Custom Drawer Open                                           |                                           Medication List Screen 1                                           |                                          Medication List Screen 2                                          |                                           Add Medication Bottom Dialog                                           |
| :---------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------: |
| ![Bottom Navigation](https://github.com/user-attachments/assets/ef9ee269-29dc-457a-8e1a-f760ca648b88) | ![Custom Drawer Open](https://github.com/user-attachments/assets/f87e3ee4-53d3-4b12-99ab-d1347e179e73) | ![Medication List Screen 1](https://github.com/user-attachments/assets/ba766ea5-4ff2-400e-9ede-efc3f13805b8) | ![Medication List Screen](https://github.com/user-attachments/assets/3d757ea4-9706-47b8-9fd7-1d951568fa10) | ![Add Medication Bottom Dialog](https://github.com/user-attachments/assets/3d742654-7d58-4050-b5f5-6ed0f4b48164) |

|                                           Delete Confirmation Dialog                                           |                                       Health Metrics List — Screen 1                                      |                                       Health Metrics List — Screen 2                                      |                                     Add Medication Dialog (add metric)                                    |                                           Result of Adding Metric                                           |
| :------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------: |
| ![Delete Confirmation Dialog](https://github.com/user-attachments/assets/36522960-668d-42c9-8e6e-968cf7119cc1) | ![Health Metrics List 1](https://github.com/user-attachments/assets/6a7d8fa5-8367-448e-8f82-f09d9852ddfc) | ![Health Metrics List 2](https://github.com/user-attachments/assets/710655c6-97ea-418d-822a-3785a42fef4d) | ![Add Medication Dialog](https://github.com/user-attachments/assets/c5a452c3-933b-4d12-abdd-fda91f921982) | ![Result of Adding Metric](https://github.com/user-attachments/assets/22ce87fe-057e-4e70-bd07-8172cf0adac0) |

|                                          Delete Confirmation (metric)                                          |                                           Result of Deleting Metric                                           |                                       Health Metric Guidance — Pop-up 1                                      |                                       Health Metric Guidance — Pop-up 2                                      |                                           Alarm List 1                                           |
| :------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------: |
| ![Delete Confirmation Metric](https://github.com/user-attachments/assets/fdc875c1-6359-4871-ade3-deb59481614e) | ![Result of Deleting Metric](https://github.com/user-attachments/assets/f72ba788-111d-45dd-b379-4830e518b0db) | ![Health Metric Guidance 1](https://github.com/user-attachments/assets/f2551d3b-4907-4ca5-b636-fddfcb9a1a0d) | ![Health Metric Guidance 2](https://github.com/user-attachments/assets/ac06bb4a-a3fc-490c-bedb-74d2808ced66) | ![Alarm List 1](https://github.com/user-attachments/assets/3b76c060-22b3-4811-a39d-8862cb908d21) |

|                                           Alarm List 2                                           |                                           Add Alarm Screen                                           |                                          Add Alarm Screen (Time Picker)                                          |                                           Ringing Alarm                                           |                                           Notification                                           |
| :----------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------: |
| ![Alarm List 2](https://github.com/user-attachments/assets/fe4c235f-3f9b-4a7c-bc14-70f718c3fe41) | ![Add Alarm Screen](https://github.com/user-attachments/assets/d2ec0d0c-8742-4380-833b-07226a2184b2) | ![Add Alarm Screen Time Picker](https://github.com/user-attachments/assets/e91a79cb-6b3d-47b2-ac4b-b22f428c0c76) | ![Ringing Alarm](https://github.com/user-attachments/assets/7c3d8b63-d5c4-46f9-832a-2f5f74dd177f) | ![Notification](https://github.com/user-attachments/assets/ee3ebb9a-cefa-44ce-b07e-68723e5741b1) |

|                                           Challenge Screen                                           |                                           After Finish Challenge                                           |                                          Delete Confirmation (alarm)                                          |                                           Result of Deleting Alarm                                           |                                       Activity List — Screen 1                                      |
| :--------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------: |
| ![Challenge Screen](https://github.com/user-attachments/assets/cc483581-727f-49f9-b045-4e9d6797a315) | ![After finish Challenge](https://github.com/user-attachments/assets/069a9866-6607-45ac-8fe5-64c221aac058) | ![Delete Confirmation Alarm](https://github.com/user-attachments/assets/64dfd0fb-7110-48c2-bec8-1bd567638fc8) | ![Result of Deleting Alarm](https://github.com/user-attachments/assets/baff3757-7f7c-4b4a-9500-4ad0e16a4fff) | ![Activity List 1](https://github.com/user-attachments/assets/73d476d9-b7cf-489b-9ad5-6dd1129ff540) |

|                                       Activity List — Screen 2                                      |                                        Add Activity (before selecting a type)                                       |                                           Add Activity                                           |                                          Add Activity (Stopwatch)                                          |                                           Activity added successfully                                           |
| :-------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------: |
| ![Activity List 2](https://github.com/user-attachments/assets/ba4b6807-3582-4b63-a0c5-598251997352) | ![Add Activity before select type](https://github.com/user-attachments/assets/26f276b9-501d-40e1-a07d-618fdc2cd0ae) | ![Add Activity](https://github.com/user-attachments/assets/b7cfd848-a095-4789-a5af-35f875741cb9) | ![Add Activity Stopwatch](https://github.com/user-attachments/assets/c1492904-7118-498f-85a7-ad1b1f236358) | ![Activity added successfully](https://github.com/user-attachments/assets/48b7fb63-dcba-47ea-bc8d-cb19d6f4d6d6) |

|                                          Dashboard — Overview                                          |                                          Home — Quick Actions opens                                          |                                          Home — Scrolling 1                                          |                                          Home — Scrolling 2                                          |  Loading  |
| :----------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------: | :-: |
| ![Dashboard Overview](https://github.com/user-attachments/assets/52fe5a98-6cd5-4c61-9736-e405f5603938) | ![Home Quick Actions opens](https://github.com/user-attachments/assets/a9702dc6-26a2-4f53-a872-58c4a024caa6) | ![Home Scrolling 1](https://github.com/user-attachments/assets/eb8e6048-f7b2-482a-9287-0b96aab59fb9) | ![Home Scrolling 2](https://github.com/user-attachments/assets/b8bc33b9-0903-47e4-98ef-03cc03310ffc) |  <img width="1547" height="3272" alt="Loading" src="https://github.com/user-attachments/assets/33a93cca-bac5-4833-a1a1-b5307ca76afa" />  |


---

<a name="technology-stack"></a>
## Technology Stack

- Frontend: Flutter (Dart) — located at `src/diabetes_alert_system/` (contains `lib/`, `pubspec.yaml`, `assets/`).
- Backend: Plain PHP (PDO) — located at `src/backend/` (PHP controllers / endpoints).
- Database: MySQL (schema SQL files in `src/backend/database/`).
- Email: PHPMailer (bundled in backend includes).
- Optional: any third-party API keys are read from environment variables.

---

<a name="repository-structure-high-level"></a>
## Repository structure (high-level)

The repository is organized to separate the mobile app from the server API:

```
DiabetesAlertSystem/
├─ LICENSE
├─ README.md
├─ .gitignore
└─ src/
   ├─ diabetes_alert_system/   # Flutter app
   │  ├─ lib/                  # Flutter source code (UI, controllers, services)
   │  ├─ pubspec.yaml
   │  └─ assets/
   └─ backend/                  # PHP backend (small REST-style endpoints)
      ├─ auth/                  # authentication endpoints (e.g., login.php)
      ├─ alarms/                # alarm endpoints (view.php, remove.php)
      ├─ metrics/               # metrics endpoints (add.php)
      ├─ database/              # SQL schema and seed files (e.g., medications.sql)
      ├─ includes/              # PHPMailer and helpers
      ├─ connect.php            # DB connection and environment loader
      ├─ env.php                # .env file loader
      └─ .env                   # (DO NOT commit to public repo) environment values
```

Note: The exact file listing may be larger — inspect the repository UI for a complete file tree.

---

<a name="quick-start--local-development"></a>
## Quick Start — Local Development

These instructions help contributors run the system locally. They are intentionally explicit to onboard new developers quickly.

### Prerequisites

- Flutter SDK (stable; recommended matching the project channel in `.metadata`).
- Android Studio / Xcode or another device/emulator to run the Flutter app.
- PHP 7.4+ with PDO MySQL extension enabled.
- MySQL / MariaDB server.
- A local web server environment (XAMPP, MAMP, LAMP) or Docker for the PHP backend.
- curl or Postman for testing API endpoints.

---

<a name="backend-php--mysql"></a>
### Backend (PHP + MySQL)

1. Place the backend into a web-accessible directory. Example:
   - Linux: `/var/www/html/diabetes-backend`
   - Windows (XAMPP): `C:\xampp\htdocs\diabetes-backend`

2. Import the database schema:

   - Using MySQL CLI:
     ```
     mysql -u root -p < src/backend/database/medications.sql
     ```
     (This imports the medications table and seed data — import any additional `.sql` files found in `src/backend/database/`.)

   - Using phpMyAdmin:
     - Create a database (e.g., `diabetes_alert_system`), set collation to `utf8mb4_unicode_ci`.
     - Import the `.sql` files via phpMyAdmin -> Import.

3. Configure environment variables:
   - Create a `.env` file in `src/backend/` (do NOT commit this to public repo) with the following variables:
     ```
     DB_HOST=127.0.0.1
     DB_NAME=diabetes_alert_system
     DB_USER=root
     DB_PASSWORD=your_db_password
     SMTP_USER=your_smtp_user@example.com
     SMTP_PASSWORD=your_smtp_password
     ```
   - The backend includes `env.php` to load this file at runtime.

4. File permissions:
   - Ensure the webserver user can read `connect.php`, `env.php` and write to any upload directories if used.

5. Test an endpoint (adjust URL based on your server):
   ```
   curl -X POST "http://localhost/diabetes-backend/auth/login.php" \
     -F "email=alice@example.com" -F "password=secret"
   ```

6. Quick PHP built-in server (for small-scale testing):
   ```
   cd src/backend
   php -S 0.0.0.0:8000
   # then point your Flutter app API_BASE_URL to http://<host>:8000/
   ```

---

<a name="frontend-flutter"></a>
### Frontend (Flutter)

1. Open `src/diabetes_alert_system/` in your IDE.

2. Update backend base URL:
   - Locate the code that stores the API base URL (commonly in a `lib/linkapi.dart` or similar file). Update it to the backend address you configured (local or remote).
   - Example:
     ```dart
     static const String server = "http://YOUR_SERVER_ADDRESS/diabetes-backend/";
     ```

3. (Optional) Add environment variables if used (create `.env` in `src/diabetes_alert_system/` next to `pubspec.yaml` if the project reads from it):
   ```
   API_BASE_URL=http://YOUR_SERVER_ADDRESS/diabetes-backend/
   OTHER_API_KEYS=...
   ```

4. Install packages and run:
   ```
   cd src/diabetes_alert_system
   flutter pub get
   flutter run
   ```

5. For emulator network mapping:
   - Android emulator: host machine is reachable at `10.0.2.2` (if you run PHP server on the same machine).
   - Physical device: use machine LAN IP (e.g., `http://192.168.1.10/diabetes-backend/`).

---

<a name="configuration--environment"></a>
## Configuration & Environment

- Backend `.env` (create locally; DO NOT commit):
  ```
  DB_HOST=127.0.0.1
  DB_NAME=diabetes_alert_system
  DB_USER=root
  DB_PASSWORD=your_db_password
  SMTP_USER=youremail@example.com
  SMTP_PASSWORD=your_smtp_password
  ```

- Frontend optional `.env` (next to `pubspec.yaml`):
  ```
  API_BASE_URL=http://YOUR_SERVER_ADDRESS/diabetes-backend/
  OTHER_KEYS=...
  ```

- Update any server constants in frontend source (e.g., `lib/linkapi.dart`) if the project does not read from environment.

---

<a name="database"></a>
## Database

- SQL files are stored under `src/backend/database/`. Example: `medications.sql`.
- Typical tables to expect: `users`, `metrics`, `alarms` (or `alarms` related views), `medications`.
- After import, verify tables and seed data via your database client.

---

<a name="api-reference-summary"></a>
## API Reference (summary)

Base URL (example):
```
http://<your-host>/diabetes-backend/
```

Note: The backend exposes small PHP endpoint scripts. All POST endpoints accept form-encoded data; file uploads use multipart/form-data. Responses are JSON objects with `status` and optional `data`.

Authentication:
- `auth/login.php` (POST) — params: `email`, `password` (note: password may be hashed with sha1 in current implementation). Returns user record on success.

Alarms / Notifications:
- `alarms/view.php` (POST) — params: `id` (user id) — returns alarms/metrics view for user.
- `alarms/remove.php` (POST) — params: `id` (alarm id) — deletes a single alarm.
- `alarms/removeall.php` (POST) — params: `id` (user id) — remove all alarms for a user.

Metrics:
- `metrics/add.php` (POST) — params include `id` (user id), `metric_type` (e.g., "Blood Sugar", "Blood Pressure", "Heart Rate"), `value1`, `value2` (optional for BP). Stores a metric and returns status.

Medications:
- SQL and seed available at `src/backend/database/medications.sql`. Backend endpoints for CRUD on medications may exist — inspect `src/backend/` for specific files.

Utility:
- `connect.php` — sets up PDO connection, CORS headers and includes `functions.php`.
- `functions.php` — contains helpers (filterRequest, getData, insertData, getAllData, etc.) and PHPMailer integration.

Important: The above is a summary from repository inspection; for an exhaustive list, browse `src/backend/` and grep for `<?php` endpoints.

---

<a name="testing"></a>
## Testing

- Manual testing: Use Postman or curl to call endpoints.
- E2E: Run Flutter in debug and exercise UI flows (login, add metrics, create alarms).
- Unit tests: The Flutter project currently does not include unit/widget tests by default. Add tests under `src/diabetes_alert_system/test/` for critical logic.
- Backend tests: None included — consider adding PHPUnit or integration tests that run against a test database.

---

<a name="building--release"></a>
## Building & Release

- Android: `flutter build apk --release` or `flutter build appbundle`
- iOS: `flutter build ios` (macOS + Xcode required)
- Make sure to update frontend API base URL to production endpoint before building release artifacts.

---

<a name="contributing"></a>
## Contributing

Thank you for contributing. Suggested workflow:
1. Fork the repository and create a feature branch (e.g., `feature/metrics-export`).
2. Commit changes in small, testable increments and include descriptive commit messages.
3. Open a pull request and describe the change, include screenshots for UI updates.
4. Add or update API contract docs if endpoint behavior changes.

Coding standards:
- Dart: follow official Dart/Flutter style guidelines.
- PHP: prefer prepared statements (PDO) and sanitize inputs (already using helpers like `filterRequest()` in code).

---

<a name="security--privacy-notes"></a>
## Security & Privacy Notes

- DO NOT publish `.env` files or credentials. I found `src/backend/.env` committed in the repo during inspection. That file includes SMTP credentials — remove it and rotate the exposed credentials immediately before making the repo public.
- Remove any commits that contain secrets from repository history (use `git filter-repo` or BFG Repo-Cleaner). Rotate credentials after removal.
- Add `.env` to `.gitignore`.
- Sanitize and validate all user inputs server-side. The backend uses helper functions but review them for edge cases and injection risks.
- Use HTTPS for production API endpoints and secure SMTP configuration for email sending.
- Consider hashing passwords with a stronger algorithm (bcrypt/argon2) instead of sha1.

Suggested commands to scrub secrets:
- BFG:
  ```
  bfg --delete-files .env
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  ```
- Or use `git filter-repo` to remove sensitive files/strings.

---


<a name="license"></a>
## License

This project is distributed under the MIT License. See `LICENSE` for full text.

---

<a name="contact--maintainers"></a>
## Contact / Maintainers

- Owner / primary maintainer: GitHub: [tawafmesar](https://github.com/tawafmesar)
- For issues, feature requests, or security disclosures: open an issue in this repository or contact the maintainer directly (email in AUTHORS/metadata if provided). If you exposed credentials and rotated them, list rotated secrets in a secure channel.

---

<a name="appendix--useful-commands--tips"></a>
## Appendix — Useful commands & tips

- Import DB:
  ```
  mysql -u <user> -p diabetes_alert_system < src/backend/database/medications.sql
  ```

- Run PHP built-in server:
  ```
  cd src/backend
  php -S 0.0.0.0:8000
  ```

- Flutter run:
  ```
  cd src/diabetes_alert_system
  flutter pub get
  flutter run
  ```

- Remove `.env` from history (example with BFG):
  ```
  bfg --delete-files .env
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  ```


- Critical: remove and rotate credentials (SMTP, DB passwords) found in `src/backend/.env` before making the repository public. If you want, I can produce a .gitignore and a short migration plan to remove secrets from history.
