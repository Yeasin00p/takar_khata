# Money Manager

A Flutter mobile app for tracking money collected from people (Raising) and managing market expenses. Built with clean architecture and local SQLite storage.

---

## Features

- **Raising** — Record money collected from people, grouped by floor and person. The same person can make multiple payments and all payments are grouped together automatically.
- **Market** — Track market expenses as due or paid. Mark due items as paid and it reflects in the balance automatically.
- **Dashboard** — See total raised, total spent, total due, and remaining balance at a glance.
- **History** — Full chronological log of all raisings and market entries.

---

## Tech Stack

| Purpose | Package |
|---------|---------|
| Framework | Flutter |
| Local database | sqflite |
| State management | Provider |
| Date formatting | intl |
| Testing | flutter_test, mockito, sqflite_common_ffi |
| Mock generation | build_runner |

---

## Architecture

This app follows **clean architecture** with a strict one-way dependency rule:

```
Screen → Provider → Usecase → Repository → DAO → SQLite
```

Each layer only talks to the layer directly below it. The screen never touches the database. The DAO never knows about the UI.

### Layer responsibilities

| Layer | Responsibility |
|-------|---------------|
| **Screen** | Collects user input, displays widgets, calls provider |
| **Provider** | Holds UI state, calls usecases, calls `notifyListeners()` |
| **Usecase** | One class per action, one `call()` method, calls repository |
| **Repository** | Calls DAOs, converts `Map` → Model, contains business logic |
| **DAO** | Raw `db.insert` / `db.query` / `db.delete` only, returns `Map` |
| **DBHelper** | Opens the database and creates tables only |

---

## Folder Structure

```
money_manager/
├── lib/
│   ├── core/
│   │   ├── database/
│   │   │   ├── db_helper.dart              ← opens DB, creates tables only
│   │   │   ├── database_provider.dart      ← wires all DAOs together, singleton
│   │   │   └── daos/
│   │   │       ├── person_dao.dart         ← persons table CRUD
│   │   │       ├── payment_dao.dart        ← payments table CRUD
│   │   │       └── market_dao.dart         ← market table CRUD
│   │   ├── theme/
│   │   │   └── app_theme.dart              ← colors, text styles
│   │   └── utils/
│   │       └── date_helper.dart            ← date formatting helpers
│   │
│   ├── features/
│   │   ├── raising/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── person_model.dart   ← PersonModel + PaymentModel
│   │   │   │   └── repositories/
│   │   │   │       └── raising_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── usecases/
│   │   │   │       └── raising_usecases.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── raising_provider.dart
│   │   │       ├── screens/
│   │   │       │   └── raising_screen.dart
│   │   │       └── widgets/
│   │   │           └── raising_widgets.dart
│   │   │
│   │   ├── market/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── market_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── market_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── usecases/
│   │   │   │       └── market_usecases.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── market_provider.dart
│   │   │       ├── screens/
│   │   │       │   └── market_screen.dart
│   │   │       └── widgets/
│   │   │           └── market_tile.dart
│   │   │
│   │   ├── dashboard/
│   │   │   └── presentation/
│   │   │       └── screens/
│   │   │           └── dashboard_screen.dart
│   │   │
│   │   └── history/
│   │       └── presentation/
│   │           └── screens/
│   │               └── history_screen.dart
│   │
│   └── main.dart                           ← MultiProvider, navigation
│
├── pubspec.yaml
└── README.md
```

---

## Database Schema

### `persons` table
Stores one row per unique person.

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PK | Auto-incremented |
| name | TEXT | Person's name |
| floor | TEXT | Floor they are on (e.g. 3rd) |

### `payments` table
Stores every individual payment. Many payments per person.

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PK | Auto-incremented |
| person_id | INTEGER FK | References `persons.id` (CASCADE delete) |
| amount | REAL | Amount given |
| date | TEXT | Date of payment (yyyy-MM-dd) |

### `market` table
Stores every market expense.

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PK | Auto-incremented |
| item | TEXT | Item or description |
| cost | REAL | Cost of the item |
| date | TEXT | Date of purchase (yyyy-MM-dd) |
| status | TEXT | `due` or `paid` |

---

## Key Design Decisions

**Same person, multiple payments** — `persons` holds one row per unique name+floor combination. Each time money is collected, a new row is added to `payments` linked by `person_id`. The repository groups payments under their person at query time.

**Same floor, multiple people** — the provider's `byFloor` getter groups persons by floor into a `Map<String, List<PersonModel>>`. The UI renders a floor header per group.

**Due → Paid flow** — marking a market entry as paid updates only the `status` column. The remaining balance is recalculated as `total raised − total paid` and reflected immediately on the dashboard.

**DAO pattern** — `DBHelper` only opens the database and creates tables. All queries live in focused DAO classes (`PersonDao`, `PaymentDao`, `MarketDao`), each responsible for exactly one table. Repositories call DAOs and never touch raw SQLite.

---

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter plugin

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/money_manager.git
cd money_manager

# 2. Install dependencies
flutter pub get

# 3. Generate mock files (required for tests)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

---

## Running Tests

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/core/database/daos/person_dao_test.dart

# Run all tests in a folder
flutter test test/features/raising/

# Run tests with coverage
flutter test --coverage
```

## Currency

This app uses the Bangladeshi Taka symbol **৳** throughout.

---

## License

MIT
