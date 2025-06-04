import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectCategoriesForm extends ConsumerStatefulWidget {
  const SelectCategoriesForm({
    super.key,
    required this.initialValue,
  });

  final List<CategoryEntity> initialValue;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCategoriesFormState();
}

class _SelectCategoriesFormState extends ConsumerState<SelectCategoriesForm> {
  List<CategoryEntity> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedCategories = widget.initialValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final streamUser = ref.watch(authChangesStateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
        title: Text(context.lang?.categories ?? '{{categories}}'),
        actions: [
          IconButton(
            onPressed: () => context.pop(selectedCategories),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: streamUser.when(
        data: (user) {
          if (user == null && user!.categories == null) {
            return Container();
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final category = user.categories![index];
              return ListTile(
                leading: Icon(
                  IconData(
                    category.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: Colors.red,
                ),
                title: Text(
                  context.getLocale.languageCode == 'en'
                      ? category.nameEn
                      : category.nameEs,
                ),
                trailing: Checkbox(
                    value: selectedCategories.contains(category),
                    onChanged: (_) {
                      setState(() {
                        if (selectedCategories.contains(category)) {
                          selectedCategories.remove(category);
                        } else {
                          selectedCategories.add(category);
                        }
                      });
                    }),
              );
            },
            separatorBuilder: (_, __) {
              return const Divider();
            },
            itemCount: user.categories!.length,
          );
        },
        error: (error, stackTrace) {
          return ShowError(
            error: error,
            stackTrace: stackTrace,
          );
        },
        loading: () => const Loader(),
      ),
    );
  }
}
