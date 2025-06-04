import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/sub_categories/async_sub_categories_state.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectedSubCategories extends ConsumerStatefulWidget {
  const SelectedSubCategories({super.key});

  static String name = 'my-sub-categories';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectedSubCategoriesState();
}

class _SelectedSubCategoriesState extends ConsumerState<SelectedSubCategories> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authChangesStateProvider);
    if (user.isLoading) {
      return const Scaffold(body: Loader());
    }

    if (user.value != null) {
      final asyncSubCategories = ref.watch(
        asyncSubCategoriesStateProvider(user.value!.categories ?? []),
      );

      debugPrint(user.value!.subCategories.toString());

      return Scaffold(
        appBar: AppBarBT(
          title: const Text('Seleccionar sub categorias'),
        ),
        body: asyncSubCategories.when(
          data: (categories) {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: Checkbox(
                    value: user.value!.subCategories
                            ?.map((e) => e.id)
                            .toList()
                            .contains(category.id) ??
                        false,
                    onChanged: (value) async {
                      if (value!) {
                        await firestore
                            .collection('users')
                            .doc(user.value!.data.uid)
                            .update(
                          {
                            'subCategories': FieldValue.arrayUnion([
                              {
                                ...category.toJson(),
                                'parent': category.parent!.toJson(),
                              }
                            ]),
                          },
                        );
                      } else {
                        await firestore
                            .collection('users')
                            .doc(user.value!.data.uid)
                            .update(
                          {
                            'subCategories': FieldValue.arrayRemove([
                              {
                                ...category.toJson(),
                                'parent': category.parent!.toJson(),
                              }
                            ]),
                          },
                        );
                      }
                      // ignore: unused_result
                      ref.refresh(authChangesStateProvider);
                    },
                  ),
                  title: Row(
                    spacing: 8,
                    children: [
                      Icon(
                        IconData(
                          category.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: Colors.red,
                      ),
                      Text(category.langName(context)),
                    ],
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => ShowError(
            error: error,
            stackTrace: stackTrace,
          ),
          loading: () => const Loader(),
        ),
        bottomNavigationBar: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  context
                    ..pop()
                    ..pop();
                },
                child: Text(context.lang!.finish),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
