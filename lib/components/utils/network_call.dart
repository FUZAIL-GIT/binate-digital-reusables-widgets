// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reusables/components/utils/loading_indicator.dart';
import 'package:reusables/components/utils/toastification.dart';
import 'package:toastification/toastification.dart';

class NetworkCall<T> {
  static late GlobalKey<NavigatorState> navigatorKey;

  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  static Future<void> networkCall<T>({
    required Future<T?> Function() future,
    Function(T?)? onComplete,
    bool isInternetCheckEnabled = false,
    bool isAutoCloseKeyboard = false,
    Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    late T? response;
    if (isAutoCloseKeyboard) {
      // first remvoe the focus from the textfield
      final FocusScopeNode currentFocus = FocusScope.of(
        navigatorKey.currentContext!,
      );
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
    }
    if (isInternetCheckEnabled) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isEmpty || result[0].rawAddress.isEmpty) {
          AppToaster.showToast(
            'No internet connection',
            subTitle: 'Please check your internet connection and try again.',
            type: ToastificationType.error,
          );
          return;
        }
      } on SocketException catch (_) {
        AppToaster.showToast(
          'No internet connection',
          subTitle: 'Please check your internet connection and try again.',
          type: ToastificationType.error,
        );
        return;
      }
    }

    // Show loading indicator
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: AppLoadingWidget());
      },
    );

    try {
      // Execute the future function
      response = await future.call();

      // Hide loading indicator
    } catch (error, stacktrace) {
      onError?.call(error, stacktrace);
      log(
        'Error: $error\nStacktrace: $stacktrace',
        error: error,
        stackTrace: stacktrace,
      );
    } finally {
      // Execute the onComplete function
      Navigator.of(navigatorKey.currentContext!).pop();
      onComplete?.call(response);
    }
  }
}
