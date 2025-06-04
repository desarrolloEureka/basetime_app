import 'dart:developer';
import 'dart:io';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/pick_image/pick_image_repository.dart';
import 'package:basetime/features/skills/select_categories_form.dart';
import 'package:basetime/features/skills/skill_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';

/// Add Skill Form
class AddSkillForm extends ConsumerStatefulWidget {
  const AddSkillForm({super.key});

  static String name = 'add-skill-form';
  static String path = '/$name';

  @override
  ConsumerState<AddSkillForm> createState() => _AddSkillFormState();
}

class _AddSkillFormState extends ConsumerState<AddSkillForm> {
  /// Variables
  File? image;
  bool loadingSave = false;
  List<CategoryEntity> categories = [];

  /// Global keys
  final _form = GlobalKey<FormState>();

  /// Text Editing Controllers
  final _priceController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 164,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white38,
                    Colors.transparent,
                  ],
                ),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white54,
                  Colors.white38,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          /// Principal Layout
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                /// Image Picker
                Stack(
                  children: [
                    if (image == null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'assets/icons/image.png',
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.file(
                          image!,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          IconButton.filled(
                            onPressed: () async {
                              final source =
                                  await showModalBottomSheet<ImageSource>(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 144,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            onTap: () {
                                              context.pop(ImageSource.gallery);
                                            },
                                            leading: const Icon(Icons.image),
                                            title: Text(context.lang!.gallery),
                                            trailing: const Icon(
                                              Icons.chevron_right,
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              context.pop(ImageSource.camera);
                                            },
                                            leading:
                                                const Icon(Icons.camera_alt),
                                            title: Text(context.lang!.camera),
                                            trailing: const Icon(
                                              Icons.chevron_right,
                                            ),
                                          ),
                                        ],
                                      ).toList(),
                                    ),
                                  );
                                },
                              );
                              if (source != null) {
                                await pickImage(source);
                              }
                            },
                            icon: Icon(image == null ? Icons.add : Icons.edit),
                          ),
                          Visibility(
                            visible: image != null,
                            child: IconButton.filled(
                              onPressed: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          /// Select categories
                          Padding(
                            padding: const EdgeInsets.all(16).copyWith(
                              left: 32,
                              bottom: 0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${context.lang?.categories ?? '{{categories}}'}:',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                  ),
                                ),
                                ...categories.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      IconData(
                                        e.icon,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final result =
                                        await showDialog<List<CategoryEntity>>(
                                      context: context,
                                      builder: (context) {
                                        return SelectCategoriesForm(
                                          initialValue: categories,
                                        );
                                      },
                                    );

                                    if (result != null) {
                                      setState(() {
                                        categories = result;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Price field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ).copyWith(top: 8),
                            child: TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: context.lang!.dollarsXHourHint,
                                hintStyle: GoogleFonts.ubuntu(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                ),
                              ),
                              validator: ValidationBuilder(
                                requiredMessage:
                                    context.lang!.thisFieldIsRequired,
                              ).build(),
                            ),
                          ),

                          /// Title field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                            ).copyWith(bottom: 16),
                            child: TextFormField(
                              controller: _titleController,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: context.lang!.title,
                                hintStyle: GoogleFonts.ubuntu(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.text_fields_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              validator: ValidationBuilder(
                                requiredMessage:
                                    context.lang!.thisFieldIsRequired,
                              ).build(),
                            ),
                          ),

                          /// Description field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                            ).copyWith(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.lang!.description,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                TextFormField(
                                  controller: _descriptionController,
                                  keyboardType: TextInputType.text,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  minLines: 1,
                                  maxLines: 3,
                                  maxLength: 150,
                                  validator: ValidationBuilder(
                                    requiredMessage:
                                        context.lang!.thisFieldIsRequired,
                                  ).build(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                minimumSize: const Size(140, 34),
              ),
              onPressed: context.pop,
              child: Text(context.lang!.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                minimumSize: const Size(140, 34),
              ),
              onPressed: loadingSave
                  ? () {}
                  : () async {
                      setState(() {
                        loadingSave = true;
                      });
                      if (image == null) {
                        Future.delayed(const Duration(seconds: 5), () {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners();
                          }
                        });
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: Text(
                              context.lang?.imageNotSelected ??
                                  '{{imageNotSelected}}',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                            actions: [
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .clearMaterialBanners();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (categories.isEmpty) {
                        Future.delayed(const Duration(seconds: 5), () {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners();
                          }
                        });
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: Text(
                              context.lang?.categoriesNotSelected ??
                                  '{{categoriesNotSelected}}',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                            actions: [
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .clearMaterialBanners();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (_form.currentState!.validate()) {
                        await Skill.add(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          image: image!,
                          pricePerHour: double.parse(_priceController.text),
                          categories: categories,
                        );

                        if (context.mounted) {
                          context.pop();
                        }
                      }
                      setState(() {
                        loadingSave = false;
                      });
                    },
              child: loadingSave
                  ? const CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : Text(context.lang!.saveChanges),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final file = await PickImageRepository().pickCropCompressSquare(source);
      setState(() {
        image = file;
      });
    } catch (e) {
      log('add_token_screen.dart on pickImage: $e');
    }
  }
}
