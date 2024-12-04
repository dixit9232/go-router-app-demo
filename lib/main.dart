import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter Example',
      routerConfig: _router, // Assign the GoRouter configuration
    );
  }

  // Define your GoRouter
  final GoRouter _router = GoRouter(
    initialLocation: '/', // Starting route
    routes: [
      // Define the root route
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage(child: HomeScreen());
        },
        routes: [
          // Nested route example
          GoRoute(
            path: 'nested',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const MaterialPage(child: NestedScreen());
            },
          ),
        ],
      ),
      // About screen route
      GoRoute(
        path: '/about',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage(child: AboutScreen());
        },
      ),
      // Contact screen route
      GoRoute(
        path: '/contact',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage(child: ContactScreen());
        },
      ),
      // Item details route with query parameters
      GoRoute(
        path: '/item/:id',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final itemId = state.pathParameters['id'];
          final filter = state.uri.queryParameters['filter'] ?? 'all';
          return MaterialPage(child: ItemDetailScreen(itemId: itemId.toString(), filter: filter));
        },
      ),
    ],
  );

  MyApp({super.key});
}

// Home Screen widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the 'about' screen
                context.go('/about');
              },
              child: const Text('Go to About Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the 'contact' screen
                context.go('/contact');
              },
              child: const Text('Go to Contact Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the nested screen
                context.go('/nested');
              },
              child: const Text('Go to Nested Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to an item details screen with query params
                context.go('/item/123?filter=active');
              },
              child: const Text('Go to Item 123 with Filter'),
            ),
          ],
        ),
      ),
    );
  }
}

// About Screen widget
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the 'contact' screen
            context.go('/contact');
          },
          child: const Text('Go to Contact Screen'),
        ),
      ),
    );
  }
}

// Contact Screen widget
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the 'home' screen
            context.go('/');
          },
          child: const Text('Go to Home Screen'),
        ),
      ),
    );
  }
}

// Nested Screen widget
class NestedScreen extends StatelessWidget {
  const NestedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Go back to the home screen
            context.go('/');
          },
          child: const Text('Go to Home Screen'),
        ),
      ),
    );
  }
}

// Item Detail Screen widget
class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  final String filter;

  const ItemDetailScreen({super.key, required this.itemId, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item $itemId')),
      body: Center(
        child: Text('Item ID: $itemId\nFilter: $filter'),
      ),
    );
  }
}
