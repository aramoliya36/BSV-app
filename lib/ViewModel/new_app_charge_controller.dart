import 'package:get/get.dart';

class NewAppChargeController extends GetxController {
  bool _isDro = false;

  bool get isDro => _isDro;

  setIsDro() {
    _isDro = !_isDro;
    update();
  }

  String _selectVale = '';

  String get selectVale => _selectVale;

  set selectVale(String value) {
    _selectVale = value;
    update();
  }

  double isMessageCharge = 0;
  setMessageCharge({double? value}) {
    isMessageCharge = value!;
    update();
  }

  double isCallCharge = 0;
  setCallCharge({double? value}) {
    isCallCharge = value!;
    update();
  }

  double isVideoCharge = 0;
  setVideoCharge({double? value}) {
    isVideoCharge = value!;
    update();
  }

  double isBitcoinCharge = 0;
  setBitcoinCharge({double? value}) {
    isBitcoinCharge = value!;
    update();
  }

  List<Map<String, int>> selectProductList = [];
// setIncrementSelectListProductQInc(
//   String? id,
//   int? quantity,
// ) {
//   int currentIndex =
//       selectProductList.indexWhere((e) => e.keys.toList().contains(id!));
//   if (selectProductList.isEmpty) {
//     selectProductList.add({id!: quantity!});
//     update();
//     currentIndex =
//         selectProductList.indexWhere((e) => e.keys.toList().contains(id));
//     selectProductList[currentIndex][id]++;
//   } else if (currentIndex > -1) {
//     selectProductList.add({id!: quantity!});
//     update();
//     currentIndex =
//         selectProductList.indexWhere((e) => e.keys.toList().contains(id));
//     selectProductList[currentIndex][id]++;
//   } else {
//     selectProductList.add({id!: quantity!});
//     update();
//     currentIndex =
//         selectProductList.indexWhere((e) => e.keys.toList().contains(id));
//     selectProductList[currentIndex][id]++;
//   }
//   update();
// }
}
