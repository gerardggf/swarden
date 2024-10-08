import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';
import 'package:swarden/app/presentation/modules/edit_pswd_item/edit_pswd_item_view.dart';
import 'package:swarden/app/presentation/modules/pswd_item/pswd_item_controller.dart';

import '../../../core/const/assets.dart';
import '../../../domain/models/pswd_item_model.dart';
import '../../global/functions/urls_functions.dart';

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
    final state = ref.watch(pswdItemControllerProvider);
    final notifier = ref.read(pswdItemControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pswdItem.name),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                EditPswdItemView.routeName,
                extra: widget.pswdItem,
              );
            },
            icon: const Icon(Icons.edit),
          ),
          10.w,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          if (widget.pswdItem.url != null) const Text('URL'),
          if (widget.pswdItem.url != null) 5.h,
          if (widget.pswdItem.url != null)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                launchCustomUrl(widget.pswdItem.url!);
              },
              child: Row(
                children: [
                  widget.pswdItem.url == null
                      ? Image.asset(Assets.icon)
                      : Image.network(
                          getFaviconUrl(
                            widget.pswdItem.url!,
                          ),
                        ),
                  10.w,
                  FittedBox(
                    child: Text(
                      widget.pswdItem.url!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          20.h,
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  color: Colors.black26,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(texts.auth.name),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    10.w,
                    Text(
                      widget.pswdItem.username,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: widget.pswdItem.username,
                          ),
                        );
                        SWardenDialogs.snackBar(
                          context: context,
                          text: 'Nombre de usuario copiado al portapapeles',
                        );
                      },
                      icon: const Icon(
                        Icons.copy_outlined,
                      ),
                    ),
                  ],
                ),
                20.h,
                if (widget.pswdItem.url != null) Text(texts.auth.password),
                if (widget.pswdItem.url != null)
                  Row(
                    children: [
                      const Icon(Icons.public),
                      Text(widget.pswdItem.url ?? ''),
                    ],
                  ),
                20.h,
                Text(texts.auth.password),
                Row(
                  children: [
                    const Icon(
                      Icons.password,
                      size: 30,
                    ),
                    10.w,
                    Text(
                      state.showPassword
                          ? widget.pswdItem.pswd
                          : List.generate(
                                  widget.pswdItem.pswd.length, (index) => '*')
                              .join(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        notifier.updateShowPassword(!state.showPassword);
                      },
                      icon: Icon(
                        state.showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: widget.pswdItem.pswd,
                          ),
                        );
                        SWardenDialogs.snackBar(
                          context: context,
                          text: 'Contraseña copiada al portapapeles',
                        );
                      },
                      icon: const Icon(
                        Icons.copy_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.h,
          Text(
            '${texts.global.createdOn} ${widget.pswdItem.creationDate.toDate().toDDMMYYYY()}',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
