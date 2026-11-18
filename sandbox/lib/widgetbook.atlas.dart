import 'package:widgetbook/widgetbook.dart';

import 'pages/account.stories.dart' as account;
import 'pages/auth.stories.dart' as auth;

final authentication = AtlasFlow(
  name: 'Authentication',
  links: {
    auth.$Welcome: [auth.$SignIn, auth.$SignUp],
    auth.$SignIn: [account.$Home, auth.$SignUp],
    auth.$SignUp: [account.$Home, auth.$SignIn],
  },
);

final accountManagement = AtlasFlow(
  name: 'Account',
  links: {
    account.$Home: [account.$Profile, account.$Settings],
    account.$Profile: [account.$Settings, account.$Home],
    account.$Settings: [account.$Home],
  },
);
