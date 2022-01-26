// material
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// constants
import 'package:whisper/constants/routes.dart' as routes;
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/themes/themes_model.dart';
import 'package:whisper/links/links_model.dart';

class WhisperDrawer extends StatelessWidget {
  
  WhisperDrawer({
    Key? key,
    required this.mainModel,
    required this.themeModel,
    required this.linksModel
  }) : super(key: key);

  final MainModel mainModel;
  final ThemeModel themeModel;
  final LinksModel linksModel;
  
  @override  
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('アカウント'),
            onTap: () {
              routes.toAccountPage(context, mainModel);
            },
          ),
         
          ListTile(
            title: Text('テーマ変更'),
            trailing: CupertinoSwitch(
              value: themeModel.isDarkTheme, 
              onChanged: (value) { themeModel.setIsDartTheme(value); },
            ),
          ),
          
          ListTile(
            title: Text('NFTowners'),
            onTap: () {
              routes.toNFTownersPage(context);
            },
          ),
          ListTile(
            title: Text('Whisperについて'),
            onTap: () {
              routes.toImportantMattersPage(context);
            },
          ),
          ListTile(
            title: Text('Links'),
            onTap: () {
              linksModel.init(context: context, linkMaps: mainModel.currentWhisperUser.links);
            },
          )
        ],
      ),
    );
  }
}