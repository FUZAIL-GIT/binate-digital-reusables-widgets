import 'dart:math';

import 'package:binate_digital_reusable_widgets/components/buttons/async_button.dart';
import 'package:binate_digital_reusable_widgets/components/buttons/async_toggle_widget.dart';
import 'package:binate_digital_reusable_widgets/components/buttons/primary_button.dart';
import 'package:binate_digital_reusable_widgets/components/utils/toastification.dart';
import 'package:binate_digital_reusable_widgets/reusables.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              label: 'Primary Button',
              onTap: () {},
              borderRadius: 20,
            ),
            AsyncButton(
              future: () async {
                await Future.delayed(const Duration(seconds: 2));
                Random random = Random();
                if (random.nextBool()) {
                  return 'Success';
                } else {
                  throw Exception('Error occurred');
                }
              },
              onError: (error) {
                AppToaster.showToast(
                  error.toString(),
                  subTitle: 'Error',
                  type: ToastificationType.error,
                );
              },
              onSuccess: (data) {
                AppToaster.showToast(
                  data.toString(),
                  subTitle: 'Success',
                  type: ToastificationType.success,
                );
              },
              beforeLabel: 'Follow',
              afterLabel: 'Unfollow',
            ),
            AsyncToggleWidget(
              onError: (error) {
                AppToaster.showToast(
                  error.toString(),
                  subTitle: 'Error',
                  type: ToastificationType.error,
                );
              },
              onSuccess: (data) {
                AppToaster.showToast(
                  data.toString(),
                  subTitle: 'Success',
                  type: ToastificationType.success,
                );
              },
              future: () async {
                await Future.delayed(const Duration(seconds: 2));
                Random random = Random();
                if (random.nextBool()) {
                  return 'Success';
                } else {
                  throw Exception('Error occurred');
                }
              },
              before: Icon(Icons.favorite_rounded, color: Colors.red, size: 30),
              after: Icon(
                Icons.favorite_border_rounded,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
