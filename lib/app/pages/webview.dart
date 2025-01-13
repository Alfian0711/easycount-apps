import 'package:easycount/app/controller/PremiumC.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class PaymentWebView extends StatefulWidget {
  final String snapToken;

  PaymentWebView({required this.snapToken});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (url.contains('status_code=200') || url.contains('/finish')) {
              PremiumC().onPaymentSuccess(url, context);
            } else if (url.contains('status_code=201') || url.contains('/pending')) {
              PremiumC().onPaymentPending(url, context);
            } else if (url.contains('status_code=400') || url.contains('/failed')) {
              PremiumC().onPaymentFailed(context);
            }
          },
          onPageFinished: (url) {
            print('Halaman selesai dimuat: $url');
          },
          onWebResourceError: (error) {
            print('Error: ${error.description}, URL: ${error}');
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Tutup WebView saat tombol back ditekan
          },
        ),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
