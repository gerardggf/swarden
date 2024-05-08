import 'package:flutter/material.dart';
import 'package:swarden/app/domain/models/secured_item_moder.dart';

class SecuredItemWidget extends StatelessWidget {
  const SecuredItemWidget({
    super.key,
    required this.item,
  });

  final SecuredItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.email),
      onTap: () {},
    );
  }
}
