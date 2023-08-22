import 'package:chapa_integration/features/product/bloc/product_bloc.dart';
import 'package:chapa_integration/features/product/repositories/product_repository.dart';
import 'package:chapa_integration/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = MyRouter();
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductRepository(),
      child: BlocProvider(
        create: (context) => ProductBloc()..add(GetProducts()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Chapa Integration Demo',
          routerConfig: _router.router,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
