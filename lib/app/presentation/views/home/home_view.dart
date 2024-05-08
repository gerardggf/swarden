import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/const/global.dart';
import 'package:swarden/app/domain/models/secured_item_moder.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_drawer.dart';
import 'package:swarden/app/presentation/views/home/widgets/secured_item_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final securedItems = <SecuredItemModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SWardenDrawer(),
      appBar: AppBar(
        title: const Text(Global.appName),
      ),
      body: ListView.builder(
        itemCount: securedItems.length,
        itemBuilder: (context, index) {
          final item = securedItems[index];
          return SecuredItemWidget(item: item);
        },
      ),
    );
  }
}
