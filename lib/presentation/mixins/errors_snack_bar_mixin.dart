import 'package:flutter/material.dart';

mixin ErrorsSnackBarMixin {
  void showNetworkErrorSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sorry, there was a network error. '
            'Please check your internet connection and try again.',
          ),
        ),
      );

  void showGenericErrorSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Try later, please.'),
        ),
      );
}
