import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/comment/comment.dart';
import 'package:basetime/features/skills/skill_entity.dart';

class FeedContent {
  FeedContent({
    required this.user,
    required this.skills,
    required this.comments,
  });

  final UserEntity user;
  final List<Skill> skills;
  final List<Comment> comments;

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'skills': List<Map<String, dynamic>>.from(
        skills.map(
          (e) => e.toJson(),
        ),
      ),
    };
  }

  FeedContent copyWith({
    UserEntity? user,
    List<Skill>? skills,
    List<Comment>? comments,
  }) {
    return FeedContent(
      user: user ?? this.user,
      skills: skills ?? this.skills,
      comments: comments ?? this.comments,
    );
  }
}
