import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/categories/async_categories_state.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/my_account/selected_sub_categories.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectCategories extends ConsumerStatefulWidget {
  const SelectCategories({super.key});

  static String name = 'my-categories';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCategoriesState();
}

class _SelectCategoriesState extends ConsumerState<SelectCategories> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authChangesStateProvider);
    final asyncCategories = ref.watch(asyncCategoriesStateProvider);

    if (user.isLoading) {
      return const Scaffold(
        body: Loader(),
      );
    }

    return Scaffold(
      appBar: AppBarBT(
        title: const Text('Seleccionar categorias'),
      ),
      body: asyncCategories.when(
        data: (categories) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: Checkbox(
                  value: user.value?.categories?.contains(category) ?? false,
                  onChanged: (value) async {
                    debugPrint('hola');
                    if (user.value != null) {
                      debugPrint('user value');
                      if (value!) {
                        debugPrint('check ${user.value!.data.uid}');
                        await firestore
                            .collection('users')
                            .doc(user.value!.data.uid)
                            .update(
                          {
                            'categories': FieldValue.arrayUnion([
                              category.toJson(),
                            ]),
                          },
                        );
                      } else {
                        await firestore
                            .collection('users')
                            .doc(user.value!.data.uid)
                            .update(
                          {
                            'categories': FieldValue.arrayRemove([
                              category.toJson(),
                            ]),
                          },
                        );
                      }
                      // ignore: unused_result
                      ref.refresh(authChangesStateProvider);
                    }
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
                context.push(SelectedSubCategories.path);
              },
              child: Text(context.lang!.continueText),
            ),
          ],
        ),
      ),
    );
  }
}
