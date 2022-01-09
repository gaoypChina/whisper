// packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'whipser_reply.g.dart';

@JsonSerializable()
class WhisperReply {
  WhisperReply({
    required this.elementId,
    required this.elementState,
    required this.followerCount,
    required this.ipv6,
    required this.isDelete,
    required this.isNFTicon,
    required this.isOfficial,
    required this.likesUidsCount,
    required this.negativeScore,
    required this.passiveUid,
    required this.postId,
    required this.positiveScore,
    required this.reply,
    required this.replyId,
    required this.score,
    required this.subUserName,
    required this.uid,
    required this.userName,
    required this.userImageURL
  });
  final String elementId;
  final String elementState;
  final int followerCount;
  final String ipv6;
  final bool isDelete;
  final bool isNFTicon;
  final bool isOfficial;
  final int likesUidsCount;
  final double negativeScore;
  final String passiveUid;
  final String postId;
  final double positiveScore;
  final String reply;
  final String replyId;
  final double score;
  final String subUserName;
  final String uid;
  final String userName;
  final String userImageURL;

  factory WhisperReply.fromJson(Map<String,dynamic> json) => _$WhisperReplyFromJson(json);

  Map<String,dynamic> toJson() => _$WhisperReplyToJson(this);
}