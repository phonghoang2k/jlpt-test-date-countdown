import 'package:flutter/material.dart';

class DataConfig {
  static final List<AssetImage> imageAssetsLink = <AssetImage>[
    AssetImage("assets/background/meo1.jpg"),
    AssetImage("assets/background/meo2.jpg"),
  ];

  static final List<AssetImage> imageMusic = <AssetImage>[
    AssetImage("assets/music_image/girlimage.jfif"),
    AssetImage("assets/music_image/candyimage.jpg"),
    AssetImage("assets/music_image/image.jpg"),
  ];

  static final List<String> songMusic = <String>[
    "music_song/music.mp3",
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
