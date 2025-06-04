import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/auth/auth_repository.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/sub_categories/async_sub_categories_state.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Select sub category Page
class SubCategoriesPage extends ConsumerStatefulWidget {
  const SubCategoriesPage({
    super.key,
    required this.categories,
  });

  static String name = 'sub-categories';
  static String path = '/sub-categories';

  final List<CategoryEntity> categories;

  @override
  ConsumerState createState() => _SelectSubCategoryPageState();
}

class _SelectSubCategoryPageState extends ConsumerState<SubCategoriesPage> {
  /// Variables
  List<CategoryEntity> selectedSubCategories = [];
  bool loadingSave = false;

  @override
  Widget build(BuildContext context) {
    final asyncSubCategories = ref.watch(
      asyncSubCategoriesStateProvider(widget.categories),
    );

    if (!asyncSubCategories.isLoading && asyncSubCategories.value != null) {
      if (asyncSubCategories.value!.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await AuthRepository().addCategories(
            widget.categories,
            selectedSubCategories,
          );
          final result = await ref.refresh(
            authChangesStateProvider.future,
          );
          if (result != null) {
            if (context.mounted) {
              context.pushReplacement(WelcomePage.path);
            }
          }
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                context.lang!.aboutYourself,
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                context.lang!.selectCategoryDescription,
                style: GoogleFonts.ubuntu(
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: asyncSubCategories.when(
                    data: (subCategories) {
                      if (subCategories.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // number of items in each row
                          mainAxisSpacing: 16, // spacing between rows
                          crossAxisSpacing: 16, // spacing between columns
                        ),
                        padding: const EdgeInsets.all(8),
                        itemCount: subCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = subCategories[index];
                          final icon = IconData(
                            category.icon,
                            fontFamily: 'MaterialIcons',
                          );
                          return MaterialButton(
                            color: selectedSubCategories.contains(category)
                                ? Colors.red
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            onPressed: () {
                              setState(() {
                                if (selectedSubCategories.contains(category)) {
                                  selectedSubCategories.remove(category);
                                } else {
                                  selectedSubCategories.add(category);
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.lang!.localeName == 'en'
                                      ? category.nameEn
                                      : category.nameEs,
                                  style: GoogleFonts.ubuntu(
                                    color: selectedSubCategories.contains(
                                      category,
                                    )
                                        ? Colors.white
                                        : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    icon,
                                    color:
                                        selectedSubCategories.contains(category)
                                            ? Colors.white
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Text('$error: $stackTrace');
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ),
              onPressed: loadingSave ? null : context.pop,
              child: Text(context.lang!.cancel),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButton(
              onPressed: loadingSave
                  ? () {}
                  : selectedSubCategories.isEmpty
                      ? null
                      : () async {
                          setState(() {
                            loadingSave = true;
                          });
                          await AuthRepository().addCategories(
                            widget.categories,
                            selectedSubCategories,
                          );
                          final result = await ref.refresh(
                            authChangesStateProvider.future,
                          );
                          if (result != null) {
                            if (context.mounted) {
                              context.pushReplacement(WelcomePage.path);
                            }
                          }
                          setState(() {
                            loadingSave = false;
                          });
                        },
              child: loadingSave
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(context.lang!.next),
            ),
          ),
        ],
      ),
    );
  }
}
