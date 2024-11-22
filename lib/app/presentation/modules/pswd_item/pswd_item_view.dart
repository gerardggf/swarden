import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';
import 'package:swarden/app/presentation/global/controllers/session_controller.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';
import 'package:swarden/app/presentation/global/widgets/error_info_widget.dart';
import 'package:swarden/app/presentation/global/widgets/loading_widget.dart';
import 'package:swarden/app/presentation/modules/edit_pswd_item/edit_pswd_item_view.dart';
import 'package:swarden/app/presentation/modules/pswd_item/pswd_item_controller.dart';

import '../../../core/const/assets.dart';
import '../../../domain/models/pswd_item_model.dart';
import '../../global/functions/urls_functions.dart';

//TODO: traducir pag

final decryptFutureProvider =
    FutureProvider.autoDispose.family<String?, String>(
  (ref, message) {
    final user = ref.watch(sessionControllerProvider);
    if (user == null) return null;
    return ref.watch(pswdRepositoryProvider).decryptMessage(message, user.id);
  },
);

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
    final decryptFuture = ref.watch(
      decryptFutureProvider(widget.pswdItem.pswd),
    );
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
          if (widget.pswdItem.url != null) const Text('URL:'),
          if (widget.pswdItem.url != null) 5.h,
          if (widget.pswdItem.url != null)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                launchCustomUrl(widget.pswdItem.url!);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: ref
                        .watch(getFaviconFutureProvider(widget.pswdItem.url))
                        .when(
                          data: (url) {
                            if (url == null) return Image.asset(Assets.icon);
                            return Image.network(url);
                          },
                          error: (_, __) => const SizedBox(),
                          loading: () => const LoadingWidget(),
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
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.pswdItem.username,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
                15.h,
                Text(texts.auth.password),
                decryptFuture.when(
                  data: (password) {
                    if (password == null) return const SizedBox();
                    return Row(
                      children: [
                        const Icon(
                          Icons.password,
                          size: 30,
                        ),
                        10.w,
                        Expanded(
                          child: Text(
                            state.showPassword
                                ? password
                                : List.generate(
                                    password.length,
                                    (index) => '*',
                                  ).join(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                          onPressed: !state.showPassword
                              ? null
                              : () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: password,
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
                    );
                  },
                  error: (e, _) => ErrorInfoWidget(
                    text: e.toString(),
                  ),
                  loading: () => const LoadingWidget(),
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
