import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/global.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';
import 'package:swarden/app/presentation/global/widgets/loading_widget.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_drawer.dart';
import 'package:swarden/app/presentation/views/pswd_item/pswd_item_view.dart';

import '../../../domain/either/either.dart';
import '../../../domain/models/pswd_item_model.dart';
import '../../global/widgets/error_info_widget.dart';

final pswdItemsStreamProvider =
    StreamProvider<Either<Exception, List<PswdItemModel>>>(
  (ref) {
    return ref.read(accountRepositoryProvider).subscribeToPswdItems();
  },
);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final pswdItemsStream = ref.watch(pswdItemsStreamProvider);
    return Scaffold(
      drawer: const SWardenDrawer(),
      appBar: AppBar(
        title: const Text(Global.appName),
      ),
      body: pswdItemsStream.when(
        data: (pswdItemsEither) {
          return pswdItemsEither.when(
            left: (error) => ErrorInfoWidget(
              text: error.toString(),
            ),
            right: (pswdItems) {
              if (pswdItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No items in the list'),
                      20.h,
                      TextButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          addPswdItem();
                        },
                        label: const Text('Add item'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: pswdItems.length + 1,
                itemBuilder: (context, index) {
                  if (index == pswdItems.length) {
                    return ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add pswd item'),
                      onTap: () async {
                        addPswdItem();
                      },
                    );
                  }
                  final pswdItem = pswdItems[index];
                  return ListTile(
                    leading: const Icon(Icons.password),
                    title: Text(pswdItem.name),
                    onLongPress: () {
                      ref.read(accountRepositoryProvider).deletePswdItem(
                            pswdItem.id,
                          );
                    },
                    onTap: () {
                      context.pushNamed(
                        PswdItemView.routeName,
                        extra: pswdItem,
                      );
                    },
                  );
                },
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) {
          return ErrorInfoWidget(
            text: error.toString(),
          );
        },
      ),
    );
  }

  Future<void> addPswdItem() async {
    final result = await ref.read(accountRepositoryProvider).addPswdItem(
          name: 'eee',
          username: 'eeee@eee.ee',
          pswd: 'ee1ee1ee1e',
        );
    if (!mounted) return;
    if (result) {
      SWardenDialogs.snackBar(context: context, text: 'Password added');
    } else {
      SWardenDialogs.snackBar(
        context: context,
        text: 'Something went wrong',
        color: Colors.red,
      );
    }
  }
}
