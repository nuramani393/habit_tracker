import 'package:flutter/material.dart';

import 'package:habit_tracker/src/services/notification_services.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    // notifyHelper = NotifyHelper();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
