import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sanjibautomobiles/providers/realm_services.dart';
import 'package:sanjibautomobiles/theme.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:sanjibautomobiles/providers/app_services.dart';
import 'package:sanjibautomobiles/screens/homepage.dart';
import 'package:sanjibautomobiles/screens/log_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config realmConfig = await Config.getConfig('assets/config/atlasConfig.json');

  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Config>(create: (_) => realmConfig),
    ChangeNotifierProvider<AppServices>(
        create: (_) => AppServices(realmConfig.appId, realmConfig.baseUrl)),
    ChangeNotifierProxyProvider<AppServices, RealmServices?>(
        // RealmServices can only be initialized only if the user is logged in.
        create: (context) => null,
        update: (BuildContext context, AppServices appServices,
            RealmServices? realmServices) {
          return appServices.app.currentUser != null
              ? RealmServices(appServices.app)
              : null;
        }),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<RealmServices?>(context, listen: false)?.currentUser;
    return MaterialApp(
      title: 'Sanjib Automobiles Kesinga',
      initialRoute: currentUser != null ? '/' : '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LogIn()
      },
    );
  }
}

// This class gets app info from `atlasConfig.json`, which is
// populated with field by the server when you download the
// template app through the Atlas App Services UI or CLI.
class Config extends ChangeNotifier {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  Config._create(dynamic realmConfig) {
    appId = realmConfig['appId'];
    atlasUrl = realmConfig['dataExplorerLink'];
    baseUrl = Uri.parse(realmConfig['baseUrl']);
  }

  static Future<Config> getConfig(String jsonConfigPath) async {
    dynamic realmConfig =
        json.decode(await rootBundle.loadString(jsonConfigPath));

    var config = Config._create(realmConfig);

    return config;
  }
}
