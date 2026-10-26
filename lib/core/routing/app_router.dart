import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/details/screens/product_details_by_id_screen.dart';
import '../../features/main_navigation/screens/main_navigation_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigationScreen(),
      routes: [
        // المسار الكامل: /product/:id
        GoRoute(
          path: 'product/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            if (id == null) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: Text('Invalid product link')),
              );
            }
            return ProductDetailsByIdScreen(productId: id);
          },
        ),
      ],
    ),
  ],
);