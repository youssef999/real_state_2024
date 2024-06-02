import 'package:get/get.dart';

class PredictController extends GetxController {
  @override
  void onInit() async {
    //  radioValue = "one";
    selectedListArea.value = firstArea;
    super.onInit();
  }

  final RxList<String> firstArea = [
    "أبو فطيرة",
    "أبو فطيرة الشريط الساحلي (أبو الحصاني)",
    "الجابرية",
    "الخالدية",
    "الدسمة",
    "الدعية",
    "الدوحة",
    "الرابية",
    "الروضة",
    "السرة",
    "السلام",
    "الشامية",
    "الشعب",
    "الشهداء",
    "الشويخ السكني",
    "الصديق",
    "العديلية",
    "الفيحاء",
    "القادسية",
    "القصر",
    "القيروان",
    "المنصورية",
    "النزهة",
    "النهضة",
    "بيان",
    "جابر الأحمد",
    "حطين",
    "كيفان",
    "مبارك العبدالله",
    "مشرف",
  ].obs;
  final RxList<String> secondArea = [
    "أبو حليفة",
    "الأحمدي",
    "الجليعة",
    "الخيران السكنية",
    "الرقة",
    "الزور",
    "الشعيبة",
    "الصباحية",
    "الضباعية",
    "الظهر",
    "العقيلة",
    "الفحيحيل",
    "الفنطاس الزراعية",
    "المقوع",
    "المنقف",
    "المهبولة",
    "النويصيب",
    "الوفرة السكنية",
    "الوفرة الزراعية",
    "أم الهيمان",
    "بنيدر",
    "جابر العلي",
    "علي صباح السالم",
    "فهد الأحمد",
    "مدينة الخيران",
    "مدينة صباح الأحمد",
    "مدينة صباح الأحمد البحرية",
    "ميناء عبد الله",
    "هدية",
    "واره"
  ].obs;
  final RxList<String> thirdArea = [
    "أبرق خيطان",
    "إشبيلية",
    "الأندلس",
    "الحساوي",
    "الخيطان",
    "الخيطان الجديدة",
    "الرحاب",
    "الرقعي",
    "الري الصناعية",
    "الشدادية",
    "الضجيج",
    "العارضية",
    "العارضية الصناعية",
    "العمرية",
    "الفردوس",
    "الفروانية",
    "جليب الشيوخ",
    "ضاحية صباح الناصر",
    "ضاحية عبد الله المبارك",
  ].obs;
  final RxList<String> forthArea = [
    "البدع",
    "الرميثية",
    "الزهراء",
    "السالمية",
    "الشعب",
    "الشهداء",
    "النقرة",
    "جنوب السرة",
    "سلوى",
    "ضاحية مبارك العبد الله الجابر",
    "مشرف",
    "منطقة حولي",
    "ميدان حولي",
  ].obs;
  final RxList<String> fifthArea = [
    "القرين",
    "ضاحية مبارك الكبير",
    "العدان",
    "القصور",
    "ضاحية صباح السالم",
    "المسيلة",
    "صبحان",
    "الفنيطيس",
    "أبو فطيرة",
    "المسايل",
    "أبو الحصانية",
  ].obs;
  final RxList<String> sixthArea = [
    "الجهراء الجديدة",
    "الجهراء القديمة",
    "الروضتين",
    "السالمي",
    "الصبية",
    "الصليبية",
    "العبدلي",
    "العيون",
    "القصر",
    "القيصرية",
    "المطلاع",
    "النسيم",
    "النعيم",
    "الواحة",
    "أمغرة",
    "تيماء",
    "كاظمة",
    "كبد",
    "مدينة الحرير",
    "مدينة سعد العبد الله",
  ].obs;
  final RxList<String> countryNames = [
    'العاصمة',
    'الاحمدي',
    'الجهراء',
    'الفروانية',
    'مبارك الكبير',
    'حولي'
  ].obs;
  RxString selectedCountry = 'العاصمة'.obs;
  final RxList<String> selectedListArea = <String>[].obs;
  RxString selectedArea = "أبو فطيرة".obs;
  changeFilterCountry(String value) {
    selectedCountry.value = value;

    if (selectedCountry.value == 'العاصمة') {
      selectedListArea.value = firstArea;
      selectedArea = "أبو فطيرة".obs;
    } else if (selectedCountry.value == 'الاحمدي') {
      selectedListArea.value = secondArea;
      selectedArea = "أبو حليفة".obs;
    } else if (selectedCountry.value == 'الجهراء') {
      selectedListArea.value = thirdArea;
      selectedArea = "أبرق خيطان".obs;
    } else if (selectedCountry.value == 'الفروانية') {
      selectedListArea.value = forthArea;
      selectedArea = "البدع".obs;
    } else if (selectedCountry.value == 'مبارك الكبير') {
      selectedListArea.value = fifthArea;
      selectedArea = "القرين".obs;
    } else if (selectedCountry.value == 'حولي') {
      selectedListArea.value = sixthArea;
      selectedArea = "الجهراء الجديدة".obs;
    }

    update();
  }

  changeFilterArea(String value) {
    selectedArea.value = value;
    update();
  }
}
