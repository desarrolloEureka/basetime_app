import 'dart:async';
import 'dart:io';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_changes_state.dart';
import 'package:basetime/features/auth/auth_repository.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/my_account/selected_categories.dart';
import 'package:basetime/features/payments/payments_page.dart';
import 'package:basetime/features/pick_image/pick_image_repository.dart';
import 'package:basetime/features/verification/verification_page.dart';
import 'package:basetime/features/verification/verification_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyAccountPage extends ConsumerStatefulWidget {
  const MyAccountPage({super.key});

  static String name = 'my-account';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends ConsumerState<MyAccountPage> {
  /// Variables
  String? idError;
  String? promoterIDError;
  bool isEditing = false;
  bool loadingSave = false;
  File? avatar;
  String username = '';
  String? usernameErrorText;

  Timer? _debounce;

  /// Global keys
  final _formKey = GlobalKey<FormState>();

  /// Form controllers
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _promoterIdController = TextEditingController();
  final _instagramController = TextEditingController();
  final _tiktokController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final streamUser = ref.watch(authChangesStateProvider);
        final user = streamUser.value;
        if (user != null) {
          _firstnameController.text = user.firstName;
          _lastnameController.text = user.lastName;
          _emailController.text = user.data.email ?? '';
          _idController.text = user.id.toString();
          _promoterIdController.text =
              user.promoterId == null ? '' : user.promoterId.toString();
          _instagramController.text = user.instagram ?? '';
          _tiktokController.text = user.tiktok ?? '';
          setState(() {
            username = user.username;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamAuth = ref.watch(authChangesStateProvider);
    final streamVerification = ref.watch(verificationStateProvider);
    return streamAuth.when(
      data: (user) {
        if (user == null) {
          return Container();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_circle_left_outlined),
            ),
            title: Text(
              context.lang!.myAccount,
              style: GoogleFonts.ubuntu(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.push(PaymentsPage.path);
                },
                icon: const Icon(Icons.credit_card),
              ),
              PopupMenuButton<String>(
                onSelected: (String? value) {
                  debugPrint(value);
                  switch (value!) {
                    case 'categories':
                      context.push(SelectCategories.path);
                      break;
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'categories',
                      child: Text('Editar Categorias'),
                    )
                  ];
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.settings_rounded),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                              BorderSide(
                                width: 4,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          child: avatar != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    avatar!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user.data.photoURL != null
                                        ? user.data.photoURL!
                                        : 'https://placehold.co/512x512/png',
                                  ),
                                  foregroundImage: user.data.photoURL != null
                                      ? NetworkImage(user.data.photoURL!)
                                      : null,
                                ),
                        ),
                        if (streamVerification.value?.isApproved ?? false)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.red,
                                size: 32,
                              ),
                            ),
                          ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Row(
                            children: [
                              Visibility(
                                visible: isEditing,
                                child: IconButton.filled(
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
                                                    context.pop(
                                                        ImageSource.gallery);
                                                  },
                                                  leading:
                                                      const Icon(Icons.image),
                                                  title: Text(
                                                      context.lang!.gallery),
                                                  trailing: const Icon(
                                                    Icons.chevron_right,
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    context.pop(
                                                        ImageSource.camera);
                                                  },
                                                  leading: const Icon(
                                                      Icons.camera_alt),
                                                  title: Text(
                                                      context.lang!.camera),
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
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                              Visibility(
                                visible: avatar != null,
                                child: IconButton.filled(
                                  onPressed: () {
                                    setState(() {
                                      avatar = null;
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
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (isEditing)
                            TextFormField(
                              initialValue: username,
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelText: context.lang!.username,
                                errorText: usernameErrorText,
                              ),
                              onChanged: (value) async {
                                setState(() {
                                  username = value;
                                });
                                if (_debounce?.isActive ?? false) {
                                  _debounce?.cancel();
                                }
                                _debounce = Timer(
                                  const Duration(milliseconds: 500),
                                  () async {
                                    final isAvailable =
                                        await UserEntity.availableUsername(
                                            value);
                                    setState(
                                      () {
                                        usernameErrorText = value ==
                                                user.username
                                            ? null
                                            : isAvailable
                                                ? null
                                                : context.lang!
                                                    .unavailableUsername(value);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          if (!isEditing)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '@$username',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                if (streamVerification.value?.isApproved ??
                                    false)
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                              ],
                            ),
                          const SizedBox(height: 16),
                          if (streamVerification.value?.isPending ?? false)
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.cyan,
                              ),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                ),
                                title:
                                    Text(context.lang!.verifyAgentNotification),
                                titleTextStyle: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          /// Firstname
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _firstnameController,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: context.lang!.firstname,
                            ),
                            validator: FormBuilderValidators.required(),
                          ),

                          /// Lastname
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _lastnameController,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: context.lang!.lastname,
                            ),
                            validator: FormBuilderValidators.required(),
                          ),

                          /// Email
                          TextFormField(
                            readOnly: true,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: context.lang!.email,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),

                          /// ID
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: context.lang!.id,
                            ),
                            validator: FormBuilderValidators.required(),
                          ),

                          /// Promoter ID
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _promoterIdController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: '${context.lang!.promoterId} '
                                  '(${context.lang!.optional})',
                            ),
                          ),

                          /// Instagram
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _instagramController,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText:
                                  'Instagram (${context.lang!.optional})',
                              prefixIcon:
                                  const FaIcon(FontAwesomeIcons.instagram),
                            ),
                          ),

                          /// Tiktok
                          TextFormField(
                            readOnly: !isEditing,
                            controller: _tiktokController,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Tiktok (${context.lang!.optional})',
                              prefixIcon: const FaIcon(FontAwesomeIcons.tiktok),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (streamVerification.value == null)
                      const SizedBox(height: 16),
                    if (streamVerification.value == null)
                      Row(
                        children: [
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              textStyle: GoogleFonts.ubuntu(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              context.push(VerificationPage.path);
                            },
                            icon: const Icon(Icons.warning_rounded),
                            label: Text(context.lang!.verifyAccount),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isEditing,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Theme.of(context).colorScheme.surface,
                              minimumSize: const Size(42, 42),
                            ),
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                            child: loadingSave
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(context.lang!.cancel),
                          ),
                        ),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: loadingSave
                              ? () {}
                              : isEditing
                                  ? () => saveChanges(user)
                                  : () {
                                      setState(() {
                                        isEditing = !isEditing;
                                      });
                                    },
                          child: loadingSave
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  isEditing
                                      ? context.lang!.saveChanges
                                      : context.lang!.editProfile,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return ShowError(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () => const Loader(),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final file = await PickImageRepository().pickCropCompressSquare(source);
      setState(() {
        avatar = file;
      });
    } catch (e) {
      throw Exception('my_account_screen.dart on pickImage: $e');
    }
  }

  Future<void> saveChanges(UserEntity user) async {
    try {
      setState(() {
        loadingSave = true;
        idError = null;
        promoterIDError = null;
      });
      final id = int.parse(_idController.text);
      final promoterID = int.parse(
        _promoterIdController.text.isEmpty ? '0' : _promoterIdController.text,
      );
      final validID = await AuthRepository().uniqueID(
        id,
        compareID: user.id.toInt(),
      );
      final validPromoterID = await AuthRepository().uniqueID(
        promoterID,
        compareID: user.id.toInt(),
      );

      // Validate if id is exists
      if (!validID) {
        setState(() {
          idError = context.lang!.invalidID;
        });
      }

      // Validate if promoter id is exists
      if (validPromoterID) {
        setState(() {
          promoterIDError = context.lang!.invalidPromoterID;
        });
      }

      if (username != user.username) {
        final isAvailable = await UserEntity.availableUsername(username);

        if (!isAvailable && context.mounted) {
          setState(() {
            usernameErrorText = context.lang!.unavailableUsername(username);
          });
          return;
        } else {
          setState(() {
            usernameErrorText = null;
          });
        }
      }

      // Validate if form fields is valid fields
      if (_formKey.currentState!.validate()) {
        await user.update(
          username: username,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          id: id,
          promoterId: promoterID,
          avatar: avatar,
          instagram: _instagramController.text,
          tiktok: _tiktokController.text,
        );

        // ignore: unused_local_variable
        final result = ref.refresh(authChangesStateProvider);
      }

      setState(() {
        loadingSave = false;
        isEditing = false;
      });
    } catch (error, stackTrace) {
      throw Exception('$error: $stackTrace');
    }
  }
}
