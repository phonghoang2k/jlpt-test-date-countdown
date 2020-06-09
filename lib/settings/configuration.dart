import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Config {
  static final List<AssetImage> imageAssetsLink = <AssetImage>[
    AssetImage(
      "assets/meo1.jpg",
    ),
    AssetImage(
      "assets/meo2.jpg",
    ),
  ];

  static final List<String> quoteString = <String>[
    "Em cắt tóc giống anh, Bố em đấm em không trượt phát lào!",
    "Tà lăng, tà lăng, tà lăng tả lẳng tà lăng.",
    "Tóc Bảnh như lông l.",
    "Vất cả tỷ vào việc chính đáng.",
    "Trên đời này đếch có chuyện đúng sai, chỉ có kẻ yếu và kẻ mạnh.",
    "Không làm mà đòi ăn, thì chỉ có ăn đồng bằng, ăn cát"
  ];

  static int imageIndex = 0;
  static int quoteIndex = 0;
  static final testDate = DateTime(2020, 8, 8);
  static final colorApp = Colors.blue;
}
