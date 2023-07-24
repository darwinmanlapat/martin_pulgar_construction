import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martin_pulgar_construction/src/app.dart';
import 'package:martin_pulgar_construction/src/config/config.dart';
import 'package:martin_pulgar_construction/src/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.photos.request();
  await AppConfig.instance.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = const SimpleBlocObserver();

  runApp(
    const MartinPulgarConstruction(),
  );
}
