import 'package:flutter/material.dart';
import 'package:jlpt_testdate_countdown/src/models/music/music.dart';

class DataConfig {
  static final List<AssetImage> imageAssetsLink = <AssetImage>[
    AssetImage("assets/background/meo1.jpg"),
    AssetImage("assets/background/meo2.jpg"),
  ];

  // static final List<AssetImage> imageMusic = <AssetImage>[
  //   AssetImage("assets/music_image/girlimage.jfif"),
  //   AssetImage("assets/music_image/candyimage.jpg"),
  //   AssetImage("assets/music_image/image.jpg"),
  // ];

  static final List<Music> musicList = <Music>[
    Music(
        songImage: AssetImage("assets/music_image/girlimage.jfif"),
        songAsset: "music_song/music.mp3",
        songName: "Daddy Challenge",
        artists: "LIU GRACE x KAYLIN x HELIX",
        lyric:
            "[00:25.06]Whos ya daddy x 3.14\n[00:37.14]Yeah i sold my soul to you evil daddy\n[00:39.63]Biết là trap nhưng vẫn làm ngơ ya music fuckin catchy\n[00:43.01]Goin everywhere with my naughty đá đì\n[00:45.34]Mini skirt no underwear nhưng nếu mà thích thì pick all of em stussy\n[00:48.29]Well i know he love me so much call me kitty kitty kitty bae\n[00:51.36]Solve all of my problem shity shity shity go away\n[00:54.64]Communicate when pinky pussy wet like milkyway\n[00:57.37]Cummin inside Baby Show me ya fetishistic face\n[01:00.35]Lil Krazieee\n[01:01.02]You know the price is priceless\n[01:02.49]Common daddy i like it\n[01:03.96]Shake it shake it while naked\n[01:05.64]Cant help cant hold can not replace me\n[01:07.03]U see the flow is Waving\n[01:08.44]I know u love when u say hate it\n[01:09.87]Do every thang for you dady just check it\n[01:11.49]Check it check it check it\n[01:54.57]Dè Lay down\n[01:54.77]Ko lẽ lại để cho đá đi mình phải muộn phiền hay sao\n[01:55.57]Cuộc chơi là win win\n[01:56.35]U dont need to pay now\n[01:58.02]Nhìn ngắm mặt hồ nhún nhảy\n[01:58.43]Mình tan chảy cùng mây sao\n[01:59.11]Nếu mà chán đổi layout\n[02:00.14]Đâm xe vào ngõ mình thay bao\n[02:01.19]Who's ya đa đa đa đa!!???!!\n")
  ];


  static final List<String> quoteString = <String>[
    "Em cắt tóc giống anh, Bố em đấm em không trượt phát lào!",
    "Tà lăng, tà lăng, tà lăng tả lẳng tà lăng.",
    "Tóc Bảnh như lông l.",
    "Vứt cả tỷ vào việc chính đáng.",
    "Trên đời này đếch có chuyện đúng sai, chỉ có kẻ yếu và kẻ mạnh.",
    "Không làm mà đòi ăn, thì chỉ có ăn đồng bằng, ăn cát"
  ];

  static final testDate = DateTime(2020, 12, 6);
}
