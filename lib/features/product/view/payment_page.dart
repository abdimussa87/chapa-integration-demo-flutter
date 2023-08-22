import 'package:chapa_integration/features/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;
  const PaymentPage({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late InAppWebViewController webViewController;
  String url = "";
  double progress = 0;

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.paymentUrl)),
              onWebViewCreated: (controller) {
                setState(() {
                  webViewController = controller;
                });
                controller.addJavaScriptHandler(
                    handlerName: "buttonState",
                    callback: (args) async {
                      webViewController = controller;

                      if (args[2][1] == 'CancelbuttonClicked') {
                        _showSnackbar(context, 'Payment Cancelled');
                        context.pop();
                      }

                      return args.reduce((curr, next) => curr + next);
                    });
              },
              onUpdateVisitedHistory: (InAppWebViewController controller,
                  Uri? uri, androidIsReload) async {
                if (uri.toString() == 'https://chapa.co') {
                  _showSnackbar(context, 'Payment Successful');
                  context.read<ProductBloc>().add(PaymentSuccessful());
                  context.pop();
                } else if (uri
                    .toString()
                    .contains('checkout/test-payment-receipt/')) {
                  _showSnackbar(context, 'Payment Successful');

                  await delay();
                  if (mounted) {
                    context.read<ProductBloc>().add(PaymentSuccessful());
                    context.pop();
                  }
                }
                controller.addJavaScriptHandler(
                    handlerName: "handlerFooWithArgs",
                    callback: (args) async {
                      webViewController = controller;

                      if (args[2][1] == 'failed') {
                        await delay();
                        if (mounted) {
                          context.pop();
                        }
                      }
                      if (args[2][1] == 'success') {
                        if (mounted) {
                          _showSnackbar(context, 'Payment Successful');
                        }
                        await delay();
                        if (mounted) {
                          context.read<ProductBloc>().add(PaymentSuccessful());
                          context.pop();
                        }
                      }
                      return args.reduce((curr, next) => curr + next);
                    });

                controller.addJavaScriptHandler(
                    handlerName: "buttonState",
                    callback: (args) async {
                      webViewController = controller;

                      if (args[2][1] == 'CancelbuttonClicked') {
                        _showSnackbar(context, 'Payment Cancelled');

                        context.pop();
                      }

                      return args.reduce((curr, next) => curr + next);
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
