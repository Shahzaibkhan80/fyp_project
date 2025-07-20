import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';

import 'package:provider/provider.dart';

final multiAppProviders = [
  ChangeNotifierProvider(create: (_) => GeneralProvider()),
  // ChangeNotifierProvider(create: (_) => ReportProvider()),
];
