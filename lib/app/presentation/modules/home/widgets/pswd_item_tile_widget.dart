import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/assets.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../../pswd_item/pswd_item_view.dart';

class PswdItemTileWidget extends ConsumerWidget {
  const PswdItemTileWidget({
    super.key,
    required this.pswdItem,
  });

  final PswdItemModel pswdItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () async {
        //TODO:traducir
        final result = await SWardenDialogs.dialog(
          context: context,
          title: 'Eliiminar registro',
          content: const Text('Quieres eliminar este registro?'),
        );
        if (result == true) {
          ref.read(accountRepositoryProvider).deletePswdItem(
                pswdItem.id,
              );
        }
      },
      onTap: () {
        context.pushNamed(
          PswdItemView.routeName,
          extra: pswdItem,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15).copyWith(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: pswdItem.url == null
                    ? Image.asset(Assets.icon)
                    : Image.network(
                        getFaviconUrl(pswdItem.url!),
                      ),
              ),
            ),
            15.w,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pswdItem.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${texts.global.createdOn} ${pswdItem.creationDate.toDate().toDDMMYYYY()}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getFaviconUrl(String url) {
    Uri uri = Uri.parse(url);
    if (uri.scheme.isEmpty) {
      uri = Uri.parse('https://$url');
    }
    return '${uri.scheme}://${uri.host}/favicon.ico';
  }
}
