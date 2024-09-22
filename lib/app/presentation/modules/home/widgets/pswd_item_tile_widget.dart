import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/assets.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../../../global/functions/urls_functions.dart';
import '../../pswd_item/pswd_item_view.dart';

class PswdItemTileWidget extends ConsumerWidget {
  const PswdItemTileWidget({
    super.key,
    required this.pswdItem,
  });

  final PswdItemModel pswdItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onLongPress: () async {
        //TODO:traducir
        final result = await SWardenDialogs.dialog(
          context: context,
          title: 'Eliminar registro',
          content: const Text('¿Quieres eliminar este registro?'),
        );
        if (result != true || !context.mounted) return;
        final result2 = await SWardenDialogs.dialog(
          context: context,
          title: 'Eliminar registro',
          content: const Text('¿Estás seguro/a?'),
        );
        if (result2 == true) {
          ref.read(accountRepositoryProvider).deletePswdItem(
                pswdItem.id,
              );
          if (!context.mounted) return;
          SWardenDialogs.snackBar(
            context: context,
            text: 'Contraseña eliminada',
          );
        }
      },
      onTap: () async {
        final authenticate = await ref
            .read(authenticationRepositoryProvider)
            .authenticateWithBiometrics();
        if (!authenticate || !context.mounted) return;
        context.pushNamed(
          PswdItemView.routeName,
          extra: pswdItem,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: pswdItem.url == null
                    ? Image.asset(Assets.icon)
                    : Image.network(
                        getFaviconUrl(
                          pswdItem.url!,
                        ),
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
}
