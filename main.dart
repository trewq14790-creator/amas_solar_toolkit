import 'dart:io';

// قاعدة بيانات الأعطال الميدانية
final Map<String, List<Map<String, String>>> errorDatabase = {
  'Voltronic Power': [
    {'code': 'F09', 'cause': 'Bus soft start failed', 'solution': 'تحقق من السوفت ستارت، ووحدة الدايودات/المكثفات الداعمة للـ Bus.'},
    {'code': 'F51', 'cause': 'Over current inverter', 'solution': 'تحقق من الحمل الزائد أو وجود قصر كهربائي (Short Circuit) في المخرج.'},
    {'code': 'F52', 'cause': 'Bus over voltage', 'solution': 'افحص جهد الألواح (PV) والبطاريات، قد يكون الارتفاع ناتج عن فصل مفاجئ للحمل.'},
    {'code': 'F56', 'cause': 'Battery connection open', 'solution': 'تحقق من كابلات البطارية والفيوزات ومقاطع البطارية.'},
  ],
  'GoodWe': [
    {'code': 'E04', 'cause': 'Grid Over Voltage', 'solution': 'جهد الشبكة أعلى من الحد المسموح، افحص إعدادات حماية الشبكة في الإنفرتر.'},
    {'code': 'E14', 'cause': 'Isolation Fault', 'solution': 'افحص العزل بين الألواح والأرضي (Earth Leakage) وجودة التأريض.'},
    {'code': 'E23', 'cause': 'Over Temperature', 'solution': 'تحقق من مراوح التبريد ونظافة المشتت الحراري والتهوية في موقع التركيب.'},
  ],
  'Solis': [
    {'code': 'OV-V-G', 'cause': 'Grid Overvoltage', 'solution': 'ارتفاع جهد الشبكة العامة، تحقق من الفولتية بين الفاز والمحايد (L-N).'},
    {'code': 'IGN-FAIL', 'cause': 'Ignition/Startup Fail', 'solution': 'فشل بدء التشغيل، تحقق من جهد بدء تشغيل السلسلة (DC Start Voltage).'},
    {'code': 'UN-BUS', 'cause': 'Bus Undervoltage', 'solution': 'انخفاض جهد الـ Bus الداخلي، افحص كفاءة دخل DC أو دخل الشبكة/البطارية.'},
  ],
  'Deye': [
    {'code': 'F13', 'cause': 'Working Mode Fault', 'solution': 'تعارض في وضع العمل، أعد ضبط إعدادات الشبكة ومود التشغيل (Grid Standard).'},
    {'code': 'F18', 'cause': 'AC Overcurrent', 'solution': 'تيار زائد في خرج AC، افحص الأحمال ومقاطع التيار الترددي.'},
    {'code': 'F20', 'cause': 'DC High Voltage', 'solution': 'ارتفاع جهد المستمر، افحص فولتية سلسلة الألواح (VOC) وعدم تجاوز حد الإنفرتر.'},
    {'code': 'F35', 'cause': 'No AC Grid', 'solution': 'انقطاع تغذية الشبكة، افحص قاطع AC الرئيسي وحساسية التردد.'},
  ],
};

// أدلة الربط والتوصيل
final Map<String, String> wiringGuides = {
  'Voltronic Power': '1. توصيل البطاريات أولاً بجهد 24V أو 48V حسب الموديل.\n2. توصيل دخل الألواح (PV) بشرط مراعاة الـ VOC والـ MPPT Voltage Window.\n3. توصيل AC Input و AC Output وتأريض الهيكل بشكل مستقل.',
  'GoodWe': '1. تركيب قاطع DC Breaker بين الألواح والإنفرتر.\n2. التأكد من ربط طرف PE (Earth) المخصص في الصندوق السفلي.\n3. عدم تجاوز تيار القصر لكل MPPT tracker.',
  'Solis': '1. استخدام وصلات MC4 المعتمدة لخطوط الألواح.\n2. التحقق من قطبية (Polarity) كابلات DC قبل التوصيل.\n3. إعداد خيار Grid Code المناسب للشبكة المحلية.',
  'Deye': '1. توصيل كابل Communication (CAN/RS485) بين إنفرتر Deye وبطارية الليثيوم (BMS).\n2. تحديد منافذ Load / Grid / AUX بدقة قبل الرفع.\n3. ربط محول التيار CT الحساس لقياس سحب الشبكة ومنع الضخ العكسي.',
};

void main() {
  print('\n====================================');
  print('    AMAS Solar Toolkit - V2.0       ');
  print('====================================');

  while (true) {
    print('\nSelect Inverter Brand:');
    print('1. Voltronic Power');
    print('2. GoodWe');
    print('3. Solis');
    print('4. Deye');
    print('5. Exit');
    stdout.write('\nEnter option number [1-5]: ');

    String? choice = stdin.readLineSync()?.trim();

    if (choice == '5') {
      print('\nExiting AMAS Solar Toolkit. Goodbye!');
      break;
    }

    switch (choice) {
      case '1':
        showBrandMenu('Voltronic Power');
        break;
      case '2':
        showBrandMenu('GoodWe');
        break;
      case '3':
        showBrandMenu('Solis');
        break;
      case '4':
        showBrandMenu('Deye');
        break;
      default:
        print('\n[!] Invalid selection.');
    }
  }
}

void showBrandMenu(String brand) {
  while (true) {
    print('\n------------------------------------');
    print('  Brand Diagnostics: $brand');
    print('------------------------------------');
    print('1. Error Codes Catalog');
    print('2. Wiring Guides');
    print('3. AI Diagnostic Assistant');
    print('4. Back to Main Menu');
    stdout.write('\nSelect service [1-4]: ');

    String? choice = stdin.readLineSync()?.trim();

    if (choice == '4') {
      break;
    }

    switch (choice) {
      case '1':
        showErrors(brand);
        break;
      case '2':
        showWiring(brand);
        break;
      case '3':
        runAiDiagnostic(brand);
        break;
      default:
        print('\n[!] Invalid selection.');
    }
  }
}

void showErrors(String brand) {
  print('\n====================================');
  print('   Error Catalog for $brand');
  print('====================================');
  var errors = errorDatabase[brand];
  if (errors != null && errors.isNotEmpty) {
    for (var err in errors) {
      print('\n[ Code ]: ${err['code']}');
      print('  Cause   : ${err['cause']}');
      print('  Solution: ${err['solution']}');
      print('------------------------------------');
    }
  }
}

void showWiring(String brand) {
  print('\n====================================');
  print('   Wiring Guide for $brand');
  print('====================================');
  print(wiringGuides[brand] ?? 'No wiring guide available.');
  print('------------------------------------');
}

void runAiDiagnostic(String brand) {
  print('\n====================================');
  print('   AI Diagnostic Assistant ($brand)');
  print('====================================');
  stdout.write('Enter Error Code or Symptom (e.g. F51 or Over Voltage): ');
  String? query = stdin.readLineSync()?.trim().toLowerCase();

  if (query == null || query.isEmpty) {
    print('[!] No input provided.');
    return;
  }

  var errors = errorDatabase[brand];
  var matches = errors?.where((err) =>
      err['code']!.toLowerCase().contains(query) ||
      err['cause']!.toLowerCase().contains(query)).toList();

  if (matches != null && matches.isNotEmpty) {
    print('\n[+] Matching Diagnostics Found (${matches.length}):');
    for (var m in matches) {
      print('\n-> Code: ${m['code']}');
      print('   Cause: ${m['cause']}');
      print('   Solution: ${m['solution']}');
    }
  } else {
    print('\n[-] No direct match found in $brand database.');
    print('   Suggestion: Inspect general connections, voltage levels, or check user manual.');
  }
}
