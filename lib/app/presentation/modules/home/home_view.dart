import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/global.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/presentation/global/widgets/loading_widget.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_drawer.dart';
import 'package:swarden/app/presentation/modules/add_pswd_item/add_pswd_item_view.dart';

import '../../../domain/either/either.dart';
import '../../../domain/models/pswd_item_model.dart';
import '../../global/widgets/error_info_widget.dart';
import 'widgets/pswd_item_tile_widget.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AddPswdItemView.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
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
                          context.pushNamed(AddPswdItemView.routeName);
                        },
                        label: const Text('Add item'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: pswdItems.length,
                itemBuilder: (context, index) {
                  final pswdItem = pswdItems[index];
                  return PswdItemTileWidget(
                    pswdItem: pswdItem,
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
}