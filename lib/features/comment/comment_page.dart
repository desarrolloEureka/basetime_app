import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/custom_user.dart';
import 'package:basetime/features/comment/comment.dart';
import 'package:basetime/features/comment/comments_state.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/widgets/rate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsPage extends ConsumerStatefulWidget {
  const CommentsPage({super.key, required this.meet, required this.match});

  final Meet meet;
  final MatchModel match;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentPagesState();
}

class _CommentPagesState extends ConsumerState<CommentsPage> {
  int _rate = 0;
  bool _loadingComment = false;

  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      context.lang!.rateYourMatch,
                      style: GoogleFonts.ubuntu(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          '${context.lang!.comment}:',
                          style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8).copyWith(top: 0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _commentController,
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.required(),
                        buildCounter: (
                          context, {
                          required currentLength,
                          required isFocused,
                          maxLength,
                        }) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                currentLength.toString(),
                                style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '/',
                                style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                maxLength.toString(),
                                style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                        maxLength: 150,
                        minLines: 3,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8).copyWith(top: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${context.lang!.classification}:',
                              style: GoogleFonts.ubuntu(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Rate(
                          value: _rate.toDouble(),
                          onChange: (value) {
                            setState(() {
                              _rate = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: _loadingComment
                        ? null
                        : () async {
                            final commentsNotifier =
                                ref.read(commentsStateProvider(null).notifier);
                            setState(() {
                              _loadingComment = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              final currentUser =
                                  FirebaseAuth.instance.currentUser!;
                              await commentsNotifier.add(
                                Comment(
                                  id: '',
                                  content: _commentController.text,
                                  rate: _rate.toInt(),
                                  createdAt: DateTime.now(),
                                  user: CustomUser(
                                    uid: widget.match.supplier.id,
                                    photoURL: widget.match.supplier.imageUrl,
                                  ),
                                  author: CustomUser.fromUser(currentUser),
                                ),
                              );
                              await widget.meet.update({
                                'status': MeetStatus.complete.name,
                              });
                            }
                            setState(() {
                              _loadingComment = false;
                            });
                          },
                    child: Center(
                      child: Text(
                        _loadingComment
                            ? context.lang!.loading
                            : context.lang!.finish,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
