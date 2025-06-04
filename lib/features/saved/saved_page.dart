import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/feed/feed_details.dart';
import 'package:basetime/features/saved/saved_state.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final streamSaved = ref.watch(savedStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lang!.favorites),
        titleTextStyle: GoogleFonts.ubuntu(
          color: Colors.red.shade900,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: streamSaved.when(
        data: (skills) {
          if (skills.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.lang!.emptySaved,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final save = skills[index];
              return ListTile(
                onTap: () async {
                  final userDoc = await users.doc(save.userID).get();

                  final accessToken =
                      await FirebaseAuth.instance.currentUser!.getIdToken();

                  final response = await dio.post<Map<String, dynamic>>(
                    'https://api-hrgux4jeyq-uc.a.run.app/search-user',
                    options: Options(
                      headers: {
                        'Authorization': 'Bearer $accessToken',
                      },
                      contentType: 'application/json',
                    ),
                    data: <String, dynamic>{
                      'uids': [save.userID],
                    },
                  );

                  if (response.statusCode == 200) {
                    final authUser = response.data!['users']
                        .cast<Map<String, dynamic>>()
                        .first;

                    final json = <String, dynamic>{
                      'data': authUser as Map<String, dynamic>,
                      ...userDoc.data()!,
                    };
                    final user = UserEntity.fromJson(json);
                    if (context.mounted) {
                      await context.push(
                        FeedDetails.path,
                        extra: user,
                      );
                    }
                  }
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    save.imageURL,
                  ),
                ),
                title: Text(save.title),
                subtitle: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(save.userID)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.data()!;
                      return Text('${data['firstName']} ${data['lastName']}');
                    }
                    return const LinearProgressIndicator();
                  },
                ),
                trailing: const Icon(Icons.chevron_right),
              );
            },
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
