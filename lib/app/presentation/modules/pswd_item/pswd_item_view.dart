import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/pswd_item_model.dart';

class PswdItemView extends ConsumerStatefulWidget {
  const PswdItemView(this.pswdItem, {super.key});

  final PswdItemModel pswdItem;

  static const String routeName = 'pswd-item';

  @override
  ConsumerState<PswdItemView> createState() => _PswdItemViewState();
}

class _PswdItemViewState extends ConsumerState<PswdItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pswdItem.name),
      ),
      body: ListView(
        children: const [],
      ),
    );
  }
}
