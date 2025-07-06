import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/features/buy_course/controller/buy_course_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyCourse extends ConsumerStatefulWidget {
  const BuyCourse({super.key});

  @override
  ConsumerState<BuyCourse> createState() => _BuyCourseState();
}

class _BuyCourseState extends ConsumerState<BuyCourse> {
  late final WebViewController _controller;
  late int courseId;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'Pay',
            onMessageReceived: (JavaScriptMessage message) {
              print("------message received------");
              print(message.message);
              Navigator.of(context).pop(message.message);
            },
          );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    courseId = int.parse(args["id"].toString());
  }

  @override
  Widget build(BuildContext context) {
    final courseBuy = ref.watch(buyCourseControllerProvider(index: courseId));

    return Scaffold(
      appBar: AppBar(),
      body: courseBuy.when(
        data: (data) {
          if (data == null) {
            return Center(
              child: Text(
                "Order exists or something went wrong",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            );
          }

          // Set URL sau khi đã có
          _controller.loadRequest(Uri.parse(data));

          return WebViewWidget(controller: _controller);
        },
        error: (error, trace) => Center(child: Text("Error loading webview")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
