// dart
import 'dart:async';
import 'dart:io';
// material
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whisper/constants/nums.dart';
// constants
import 'package:whisper/constants/maps.dart';
import 'package:whisper/constants/strings.dart';
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/others.dart' as others;
import 'package:whisper/constants/lists.dart';
import 'package:whisper/constants/routes.dart' as routes;
import 'package:whisper/constants/strings.dart' as strings;
// domain
import 'package:whisper/domain/user_meta/user_meta.dart';
import 'package:whisper/domain/whisper_user/whisper_user.dart';

final signupProvider = ChangeNotifierProvider(
  (ref) => SignupModel()
);

class SignupModel extends ChangeNotifier {
  
  // basic
  bool isLoading = false;
  // info
  String userName = "";
  String email = "";
  String password = "";
  bool isObscure = true;
  String gender = "";
  final displayGenderNotifier = ValueNotifier<String>('');
  DateTime birthDay = DateTime(1900,10,10);
  final displayBirthDayNotifier = ValueNotifier<DateTime>(DateTime(1900,10,10));
  String language = '';
  final displayLanguageNotifier = ValueNotifier<String>('');
  // Checkbox
  final isCheckedNotifier = ValueNotifier<bool>(false);
  // image
  bool isCropped = false;
  XFile? xFile;
  File? croppedFile;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void toggleIsObsucure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void toggleIsChecked() {
    isCheckedNotifier.value = !isCheckedNotifier.value;
  }

  Future<void> showImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      await cropImage();
    }
    notifyListeners();
  }

  Future<void> cropImage() async {
    isCropped = false;
    croppedFile = null;
    croppedFile = await others.returnCroppedFile(xFile: xFile);
    if (croppedFile != null) {
      isCropped = true;
    }
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    if (commonPasswords.contains(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ありふれたパスワードです。変更してください')));
    } else if (userName.length >= 64) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ユーザー名は64文字以内にしてください')));
    }else {
      try{
        UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,);
        User? user = result.user;
        final String uid = user!.uid;
        final String storageImageName = strings.storageUserImageName;
        final String imageURL = await voids.uploadUserImageAndGetURL(uid: uid, croppedFile: croppedFile,storageImageName: storageImageName );
        await addUserToFireStore(uid: uid, imageURL: imageURL, storageImageName: storageImageName);
        await createUserMeta(uid: uid);
        routes.toVerifyPage(context);
      } on FirebaseAuthException catch(e) {
        print(e.code);
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('パスワードが弱いです')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('そのメールアドレスはすでに使われています')));
        } else {
          print(e.toString());
        }
      }
    }
  }
  
  Future<void> addUserToFireStore({ required String uid, required String imageURL,required String storageImageName }) async {
    final List<String> searchWords = returnSearchWords(searchTerm: userName);
    final Timestamp now = Timestamp.now();
    Map<String,dynamic> whisperUserMap = WhisperUser(
      accountName: uid,
      blocksIpv6AndUids: [],
      createdAt: now,
      description: '',
      dmState: onlyFollowingAndFollowedString,
      followerCount: 0,
      imageURL: imageURL,
      isBanned: false,
      isDelete: false,
      isKeyAccount: false,
      isNFTicon: false,
      isOfficial: false,
      mutesIpv6AndUids: [],
      noDisplayWords: [],
      links: [],
      recommendState: recommendableString,
      score: defaultScore,
      storageImageName: storageImageName,
      tokenToSearch: returnTokenToSearch(searchWords: searchWords),
      uid : uid,
      updatedAt: now,
      userName: userName,
      walletAddress: '',
    ).toJson();
    await FirebaseFirestore.instance.collection(usersKey).doc(uid).set(whisperUserMap);
  }

  Future<void> createUserMeta({ required String uid }) async {
    final timestampBirthDay = Timestamp.fromDate(birthDay);
    final Timestamp now = Timestamp.now();
    final String bookmarkLabelId = returnBookmarkLabelId(now: now.toDate());
    final Map<String,dynamic> userMetaMap = UserMeta(
      authNotifications: [],
      birthDay: timestampBirthDay,
      bookmarks: [],
      createdAt: now,
      followingUids: [],
      gender: gender, 
      isAdmin: false,
      isDelete: false,
      likeComments: [],
      likeReplys: [],
      likes: [],
      language: language, 
      readNotifications: [],
      readPosts: [],
      searchHistory: [],
      uid: uid,
      updatedAt: now,
    ).toJson();
    await FirebaseFirestore.instance.collection(userMetaKey).doc(uid).set(userMetaMap);
    await others.bookmarkLabelRef(uid: uid, bookmarkLabelId: bookmarkLabelId).set(
      returnFirstBookmarkLabel(now: now, uid: uid, bookmarkLabelId: bookmarkLabelId)
    );
  }

  void showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context, 
      builder: (context) {
        final now = DateTime.now();
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CupertinoDatePicker(
            backgroundColor: Theme.of(context).focusColor,
            initialDateTime: DateTime(now.year - 18,12,31),
            minimumDate: DateTime(1900,12,31),
            maximumDate: DateTime(now.year - 6,12,31),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value){
              birthDay = value;
              displayBirthDayNotifier.value = value;
            }
          ),
        );
      }
    );
  }

  void showLanguageCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context, 
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                '日本語',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                language = 'ja';
                displayLanguageNotifier.value = '日本語';
                Navigator.pop(context);
              }, 
            ),
            CupertinoActionSheetAction(
              child: Text(
                'English',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                language = 'en';
                displayLanguageNotifier.value = '英語';
                Navigator.pop(context);
              }, 
            ),
          ],
        );
      }
    );
  }

  void showGenderCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context, 
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                '男性',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                gender = 'male';
                displayGenderNotifier.value = '男性';
                Navigator.pop(context);
              }, 
            ),
            CupertinoActionSheetAction(
              child: Text(
                '女性',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                gender = 'female';
                displayGenderNotifier.value = '女性';
                Navigator.pop(context);
              }, 
            ),
            CupertinoActionSheetAction(
              child: Text(
                'その他',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                gender = 'others';
                displayGenderNotifier.value = 'その他';
                Navigator.pop(context);
              }, 
            ),
            CupertinoActionSheetAction(
              child: Text(
                '無回答',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                gender = 'noAnswer';
                displayGenderNotifier.value = '無回答';
                Navigator.pop(context);
              }, 
            )
          ],
        );
      }
    );
  }

}