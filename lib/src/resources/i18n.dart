import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);
  static var _t = Translations("en_us") + {"en_us": "Cust Mgnt", "vi_vn": "Quản lý khách hàng"};
}
