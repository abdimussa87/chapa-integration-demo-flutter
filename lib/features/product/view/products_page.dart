import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chapa_integration/features/product/bloc/product_bloc.dart';
import 'package:chapa_integration/features/product/widgets/product_card_widget.dart';
import 'package:chapa_integration/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  void _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Products'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductBloc, ProductState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ProductStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                ));
              }
            },
          ),
          BlocListener<ProductBloc, ProductState>(
            listenWhen: (previous, current) =>
                previous.paymentStatus != current.paymentStatus,
            listener: (context, state) {
              if (state.paymentStatus == PaymentStatus.error) {
                // remove the loading indicator dialog
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                ));
              }
              if (state.paymentStatus == PaymentStatus.loading) {
                _showLoadingDialog(context);
              }
              // paymentUrl is loaded, so go to payment page
              if (state.paymentStatus == PaymentStatus.loaded) {
                context.pop();
                context.pushNamed(MyRouter.paymentRouteName, queryParameters: {
                  'paymentUrl': state.paymentUrl,
                });
              }
              // payment was successful
              if (state.paymentStatus == PaymentStatus.success) {
                AwesomeDialog(
                  dialogBorderRadius: BorderRadius.circular(5),
                  dismissOnTouchOutside: true,
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.bottomSlide,
                  title: 'Success',
                  desc: 'Payment Successful!',
                  btnOkOnPress: () {},
                ).show();
              }
            },
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status == ProductStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 10,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(product: product);
                });
          },
        ),
      ),
    );
  }
}
