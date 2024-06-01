import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_prokit/screen/SocialWalkThrough.dart';
import 'package:social_prokit/store/AppStore.dart';
import 'package:social_prokit/utils/AppTheme.dart';
import 'package:social_prokit/utils/SocialDataGenerator.dart';
import 'package:social_prokit/utils/SocialStrings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



  
AppStore appStore = AppStore();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xflffrnsyxqttkkafeeh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhmbGZmcm5zeXhxdHRra2FmZWVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUwNjI5NDQsImV4cCI6MjAzMDYzODk0NH0.5r_yEdy864eMV_Pd1u4UGyloThV8ORx6ftLur8XOVpA',
  );

  final supabase = Supabase.instance.client;

String email = 'example@example.com';
String password = '123456';

// Email and password sign up
await supabase.auth.signUp(
  email: email,
  password: password,
);

// Email and password login
await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);

// Magic link login
await supabase.auth.signInWithOtp(email: 'my_email@example.com');

// Listen to auth state changes
supabase.auth.onAuthStateChange.listen((data) {
  final AuthChangeEvent event = data.event;
  final Session? session = data.session;
  // Do something when there is an auth event
});
// Select data with filters
final data = await supabase
  .from('cities')
  .select()
  .eq('country_id', 1) // equals filter
  .neq('name', 'The shire'); // does not equal filter

// Insert a new row
await supabase
  .from('cities')
  .insert({'name': 'The Shire', 'country_id': 554});



     /* .from('mesajlar')
      .select()
      .maybeSingle();

  if (response != null) {
    if (response['error'] != null) {

    print('Bağlantı başarısız: ${response['error']!['message']}');
  } else {
    print('Bağlantı başarılı: ${response['data']}');
  }
} else {
    print('Bağlantı başarısız: Yanıt alınamadı');
  }
  */
  

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '$social_lbl_app_Name${!isMobile ? ' ${platformName()}' : ''}',
        home: SocialWalkThrough(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
