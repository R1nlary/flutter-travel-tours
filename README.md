# Travel Tours — Capstone Project (Milestone 1)

A mobile app for finding and booking tours: sea cruises, hikes, city trips
and road trips.

## Pitch

**Problem.** Planning a trip means jumping between many sites to compare
tours, prices and photos.
**Solution.** One app where a traveller browses tours with photos, price and
rating, filters them by category, saves favorites, opens a detailed page and
books a tour in one tap.
**User.** Young travellers who plan trips from their phone.

## Run

```bash
flutter pub get
flutter run -d chrome
```

```bash
flutter test
```

## Screens

| Screen | File | What it shows |
|---|---|---|
| Sign up | `screens/registration_screen.dart` | Form with validation, or "Continue as guest" |
| Explore (Feed) | `screens/feed_screen.dart` | Category filter chips and tour cards (`Column`, `Row`, `Card`) |
| Tour details | `screens/detail_screen.dart` | `Stack` banner with a gradient and the title, tags (`Wrap`), sticky booking bar |
| Favorites | `screens/favorites_screen.dart` | Saved tours |
| My bookings | `screens/bookings_screen.dart` | Booked tours and the total price |
| Profile | `screens/profile_screen.dart` | User info, counters, settings switches |

## Interactive features (`StatefulWidget` + `setState`)

* Category filter in the feed.
* Favorite heart (feed, details, favorites share the same data).
* Book / cancel booking with a `SnackBar`; the total is counted in "My bookings".
* Form validation on the sign-up screen.
* Settings switches in the profile.

## Project structure

```
lib/
├── main.dart
├── models/tour.dart
├── data/tours.dart            # 6 sample tours
├── screens/                   # full screens
└── widgets/                   # tour_card, booking_bar
assets/images/                 # tour photos
test/travel_tours_test.dart    # 12 widget tests, including no-overflow checks
```

## Roadmap (next milestones)

* REST API: load the tours from a server instead of local data.
* Database: store users, bookings and favorites.
* BLoC: move the app state out of `setState`.
* Search, tour reviews and a payment screen.

Photos: [Lorem Picsum](https://picsum.photos) (Unsplash license).
