import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_travel_tours/main.dart';
import 'package:flutter_travel_tours/screens/detail_screen.dart';

Future<void> openApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const TravelToursApp());
}

Future<void> continueAsGuest(WidgetTester tester) async {
  final button = find.text('Continue as guest');
  await tester.ensureVisible(button);
  await tester.pumpAndSettle();
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  group('registration', () {
    testWidgets('empty form shows errors and stays on the screen', (
      tester,
    ) async {
      await openApp(tester);
      await tester.tap(find.text('Sign up'));
      await tester.pump();

      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(find.text('Explore tours'), findsNothing);
    });

    testWidgets('invalid email and short password are rejected', (
      tester,
    ) async {
      await openApp(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'abc',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        '123',
      );
      await tester.pump();

      expect(find.textContaining('Enter a valid email'), findsOneWidget);
      expect(find.textContaining('at least 6'), findsOneWidget);
    });

    testWidgets('valid form opens the app with the user name', (tester) async {
      await openApp(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Aibek',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'a@narxoz.kz',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret1',
      );
      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle();

      expect(find.text('Explore tours'), findsOneWidget);
      await tester.tap(find.text('Profile'));
      await tester.pump();
      expect(find.text('Aibek'), findsOneWidget);
    });
  });

  group('feed', () {
    testWidgets('shows tours and filters by category', (tester) async {
      await openApp(tester);
      await continueAsGuest(tester);

      expect(find.text('Norway Fjord Cruise'), findsOneWidget);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Hiking'));
      await tester.pumpAndSettle();

      expect(find.text('Forest Waterfall Hike'), findsOneWidget);
      expect(find.text('Norway Fjord Cruise'), findsNothing);

      await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
      await tester.pumpAndSettle();
      expect(find.text('Norway Fjord Cruise'), findsOneWidget);
    });
  });

  group('detail and booking', () {
    testWidgets('tap opens the detail screen with the tour data', (
      tester,
    ) async {
      await openApp(tester);
      await continueAsGuest(tester);

      await tester.tap(find.text('Norway Fjord Cruise'));
      await tester.pumpAndSettle();

      expect(find.byType(DetailScreen), findsOneWidget);
      expect(
        find.textContaining('Sail between steep mountains'),
        findsOneWidget,
      );
      expect(find.text('Boat'), findsOneWidget); // a tag
      expect(find.text('Book now'), findsOneWidget);
    });

    testWidgets('back arrow returns to the feed', (tester) async {
      await openApp(tester);
      await continueAsGuest(tester);

      await tester.tap(find.text('Norway Fjord Cruise'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(DetailScreen), findsNothing);
      expect(find.text('Explore tours'), findsOneWidget);
    });

    testWidgets('booking appears in My bookings with the total', (
      tester,
    ) async {
      await openApp(tester);
      await continueAsGuest(tester);

      await tester.tap(find.text('Forest Waterfall Hike'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Book now'));
      await tester.pump();
      expect(find.text('Tour booked!'), findsOneWidget);
      expect(find.text('Cancel booking'), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bookings'));
      await tester.pump();

      expect(find.text('Forest Waterfall Hike'), findsOneWidget);
      expect(find.text('\$120'), findsOneWidget); // total
    });

    testWidgets('favorite saved in the feed shows in Favorites', (
      tester,
    ) async {
      await openApp(tester);
      await continueAsGuest(tester);

      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pump();
      await tester.tap(find.text('Favorites'));
      await tester.pump();

      expect(find.text('Norway Fjord Cruise'), findsOneWidget);
    });
  });

  group('no RenderFlex overflow', () {
    final sizes = {
      'small phone': const Size(280, 480),
      'phone': const Size(390, 844),
      'tablet': const Size(820, 1180),
      'desktop': const Size(1600, 900),
    };

    for (final entry in sizes.entries) {
      testWidgets('feed and detail on ${entry.key}', (tester) async {
        await openApp(tester, size: entry.value);
        await continueAsGuest(tester);
        expect(tester.takeException(), isNull);

        final title = find.text('Norway Fjord Cruise');
        await tester.ensureVisible(title);
        await tester.pumpAndSettle();
        await tester.tap(title);
        await tester.pumpAndSettle();
        expect(find.byType(DetailScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
