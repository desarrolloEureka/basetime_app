import 'dart:io';

import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/verification/verification_request.dart';
import 'package:basetime/features/verification/verification_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class VerificationPage extends ConsumerStatefulWidget {
  const VerificationPage({super.key});

  static String name = 'verification';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  File? _frontImage;
  File? _backImage;
  File? _selfieImage;
  bool _loadingUpload = false;

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lang!.verifyAccount),
        centerTitle: true,
        titleTextStyle: GoogleFonts.ubuntu(
          color: Colors.red,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                context.lang!.verifyAccountDescription,
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.white,
                height: 32,
              ),
              Text(
                context.lang!.varifyAccountGuide,
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // front
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_frontImage != null) {
                            final result = await context.showConfirm<bool>(
                              content: context.lang!.changePhotoConfirm,
                              onConfirm: () {
                                context.pop(true);
                              },
                            );

                            if (result == null) {
                              return;
                            }
                          }
                          await _getFrontPhoto();
                        },
                        child: Stack(
                          children: [
                            Icon(
                              _frontImage != null
                                  ? Icons.photo_rounded
                                  : Icons.camera_alt_rounded,
                              size: 86,
                              color: Colors.white,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                _frontImage != null
                                    ? Icons.check_circle_rounded
                                    : Icons.add_circle_rounded,
                                color: _frontImage != null
                                    ? Colors.yellow
                                    : Colors.red,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          context.lang!.dniFrontPhoto,
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // back
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_backImage != null) {
                            final result = await context.showConfirm<bool>(
                              content: context.lang!.changePhotoConfirm,
                              onConfirm: () {
                                context.pop(true);
                              },
                            );

                            if (result == null) {
                              return;
                            }
                          }
                          await _getBackPhoto();
                        },
                        child: Stack(
                          children: [
                            Icon(
                              _backImage != null
                                  ? Icons.photo_rounded
                                  : Icons.camera_alt_rounded,
                              size: 86,
                              color: Colors.white,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                _backImage != null
                                    ? Icons.check_circle_rounded
                                    : Icons.add_circle_rounded,
                                color: _backImage != null
                                    ? Colors.yellow
                                    : Colors.red,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          context.lang!.dniBackPhoto,
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // Selfie Dni Button
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_selfieImage != null) {
                            final result = await context.showConfirm<bool>(
                              content: context.lang!.changePhotoConfirm,
                              onConfirm: () {
                                context.pop(true);
                              },
                            );

                            if (result == null) {
                              return;
                            }
                          }
                          await _getSelfiePhoto();
                        },
                        child: Stack(
                          children: [
                            Icon(
                              _selfieImage != null
                                  ? Icons.photo_rounded
                                  : Icons.camera_alt_rounded,
                              size: 86,
                              color: Colors.white,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                _selfieImage != null
                                    ? Icons.check_circle_rounded
                                    : Icons.add_circle_rounded,
                                color: _selfieImage != null
                                    ? Colors.yellow
                                    : Colors.red,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          context.lang!.dniSelfie,
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: _loadingUpload
                  ? null
                  : _frontImage != null &&
                          _backImage != null &&
                          _selfieImage != null
                      ? () async {
                          final result = await context.showConfirm<bool>(
                            content: context.lang!.uploadVerifyDataConfirm,
                            onConfirm: () {
                              context.pop(true);
                            },
                          );

                          if ((result ?? false) && context.mounted) {
                            await _uplodaFiles(context);
                          }
                        }
                      : null,
              child: _loadingUpload
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      context.lang!.verifyAccount,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getFrontPhoto() async {
    final xfile = await _picker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      setState(() {
        _frontImage = File(xfile.path);
      });
    }
  }

  Future<void> _getBackPhoto() async {
    final xfile = await _picker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      setState(() {
        _backImage = File(xfile.path);
      });
    }
  }

  Future<void> _getSelfiePhoto() async {
    final xfile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (xfile != null) {
      setState(() {
        _selfieImage = File(xfile.path);
      });
    }
  }

  Future<void> _uplodaFiles(BuildContext context) async {
    setState(() {
      _loadingUpload = true;
    });
    await VerificationRequest.sendVerifyAccountRequest(
      front: _frontImage!,
      back: _backImage!,
      selfie: _selfieImage!,
    );
    if (context.mounted) {
      context.pushReplacement(
        VerificationSuccess.path,
      );
    }
    setState(() {
      _loadingUpload = false;
    });
  }
}
