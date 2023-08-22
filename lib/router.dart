import 'package:chapa_integration/features/product/view/payment_page.dart';
import 'package:chapa_integration/features/product/view/products_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static String productsRouteName = '/products';
  static String paymentRouteName = '/payment';

  final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: '/products',
    routes: [
      GoRoute(
        name: productsRouteName,
        path: '/products',
        builder: (context, state) {
          return const ProductsPage();
        },
      ),
      GoRoute(
        name: paymentRouteName,
        path: '/payment',
        builder: (context, state) {
          final url = state.uri.queryParameters['paymentUrl'];

          return PaymentPage(
            paymentUrl: url ?? '',
          );
        },
      ),
    ],
  );
}
