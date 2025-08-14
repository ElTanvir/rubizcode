import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/core/services/cache/cache_provider.dart';
import 'package:my_app/core/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    Log.error(details.exceptionAsString(), stackTrace: details.stack);
  };
  try {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentsDir.path);
  } catch (e) {
    Log.error('Hive initialization failed: $e');
  }
  await Hive.openBox<dynamic>(CacheKeys.boxName);
  await ScreenUtil.ensureScreenSize();

  runApp(ProviderScope(child: await builder()));
}
