'db': {
    'comments': [{
        'comment': String,
        'commentId': String,
        'createdAt': TimeStamp,
        'followersCount': int,
        'ipv6': String,
        'isDelete': false,
        'isNFTicon': false,
        'isOfficial': false,
        'likesUids': [ String ],
        'likesUidsCount': int,
        'negativeScore': int,
        'passiveUid': string,
        'positiveScore': int,
        'postId': String,
        'replysCount': int,
        'score': int,
        'subUserName': String,
        'uid': String,
        'userDocId': String,
        'userName': String,
        'userImageURL': String,
    }],
    'nftOwners'{
        'ethPrice': int,
        'link': String,
        'userName'; String,
        'number': int,
        'uid': uid,
        'userImageURL': String,
    }
    'posts'{
        'audioURL': String,
        'bookmarks': [{
            'createdAt': TimeStamp,
            'uid': String,
        }],
        'bookmarksCount': int,
        'commentsCount': int,
        'commentsState': String('open','isLocked'),
        'createdAt': TimeStamp,
        'country': String,
        'description': String,
        'genre': String,
        'hashTags': List<String>,
        'imageURL': String,
        'impression': int,
        'ipv6': String,
        'isDelete': bool,
        'isNFTicon': bool,
        'isOfficial': bool,
        'isPinned': bool,
        'isPlayedCount': int,
        'likes': [{
            createdAt: TimeStamp,
            uid: String,
        }],
        'likesCount': int,
        'link': String,
        'noDisplayWords': list,
        'noDisplayIpv6AndUids': list,
        'negativeScore': int,
        'otherLinks': List<Map<String,dynamic> {
            'description': String,
            'link': String,
            'label': String,
        }>,
        'postId': String,
        'positiveScore': int,
        'score': int,
        'storageImageName': String,
        'storagePostName': String,
        'subUserName': String,
        'tagUids': List<String>,
        'title': String,
        'uid': String,
        'updatedAt': TimeStamp,
        'userDocId': String,
        'userImageURL': String,
        'userName': String
    }
    'replys'{
        'elementId': String,
        'elementState': String [ comment ],
        'createdAt': TimeStamp,
        'followersCount': int,
        'ipv6': String,
        'isDelete': bool,
        'isNFTicon': bool,
        'isOfficial': bool,
        'likesUidsCount': int,
        'negativeScore': int,
        'passiveUid': string,
        'postId': string,
        'positiveScore': int,
        'reply': String,
        'replyId': String,
        'score': int,
        'subUserName': String,
        'uid': String,
        'userDocId': String,
        'userName': String,
        'userImageURL': String,
    }
    'users'{
        'authNotifications': List<String,dynamic> {

        },
        'birthDay': TimeStamp,
        'browsingHistory': list,
        'blocksIpv6AndUids': List<Map<String,dynamic> {
            'uid': String,
            'ipv6': String,
        }>, // unUsed
        'bookmarks': [{
            'createdAt': TimeStamp,
            'postId': String,
        }],
        'commentNotifications': [{
            'comment': String,
            'commentId': String,
            'commentScore': int,
            'followersCount': int,
            'isDelete': bool,
            'isNFTicon': bool,
            'isOfficial': bool,
            'notificationId': String,
            'passiveUid': String,
            'postTitle': String,
            'postId': String,
            'subUserName': String,
            'uid': String,
            'userName': String,
            'userImageURL': String,
        }],
        'createdAt': TimeStamp,
        'description': String,
        'dmState': ['onlyFollowingAndFollowed','open'],
        'followNotifications': [],
        'followersCount': int,
        'followingUids': [
            String
        ],
        'gender': String[male,female,others,noAnswer],
        'imageURL': String,
        'isAdmin': bool,
        'isDelete': bool,
        'isNFTicon': bool,
        'isKeyAccount': bool,
        'isOfficial': bool,
        'isSubAdmin': bool,
        'language': String ja,en,
        'likedComments':[{
            commentId: String,
            createdAt: TimeStamp,
        }],
        'likeNotifications': [],
        'likedReplys': [{
            'createdAt': TimeStamp,
            'likedReplyId': String,
        }],
        'likes': [{
            'createdAt': TimeStamp,
            'likedPostId': String,
        }],
        'link': String,
        
        'mutesIpv6AndUids': List<Map<String,dynamic>>{
            'ipv6': String,
            'uid': String,
        },
        'noDisplayWords': List<String>,
        'otherLinks': List<Map<String,dynamic>{
            'description': String,
            'link': String,
            'label': String,
        }>,
        'readNotificationIds': [ String ],
        'readPosts': [{
            'createdAt': TimeStamp,
            'durationInt': int,
            'postId': String,
        }],
        'recommendState': 'recommendable',
        'replyNotifications': [{
            'comment': String,
            'createdAt': TimeStamp,
            'elementId': String,
            'elementState': String,
            'followersCount': int,
            'isDelete': bool,
            'isNFTicon': bool,
            'isOfficial': bool,
            'notificationId': String,
            'passiveUid': String,
            'postId': String,
            'reply': String,
            'replyScore': int,
            'replyId': String,
            'subUserName': String,
            'uid': String,
            'userName': String,
            'userImageURL': String,
        }],
        'score': int,
        'searchHistory': List<String>,
        'storageImageName': String,
        'subUserName': String,
        'uid': String,
        'updatedAt': String,
        'userName': String,
        'walletAddress': String,
    }
    'watchLists' {
        'creatorUid': String,
        'uids': [ String ],
        'label': String ,
        'watchListId': String,
        'createdAt': TimeStamp,
        'updatedAt': TimeStamp,
    }
    'bookmarkLabels' {
        'creatorUid': String,
        'postIds': [ String ],
        'label': String,
        'bookmarkLabelId': String,
        'createdAt': TimeStamp,
        'updatedAt': TimeStamp,
    }
    'officialAdsenses' {
        'displaySeconds': int,
        'title': String,
        'subTitle': String,
        'intervalSeconds': int,
        'createdAt': TimeStamp,
    }
}