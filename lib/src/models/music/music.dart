import 'package:flutter/cupertino.dart';

class Music {
  String songName;
  String artists;
  String songAsset;
  AssetImage songImage;
  String lyric;

  Music({this.songAsset, this.songImage, this.songName, this.artists, this.lyric});
}
