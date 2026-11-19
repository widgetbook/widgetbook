import 'package:widgetbook/widgetbook.dart';

import 'pages/account.stories.dart' as account;
import 'pages/auth.stories.dart' as auth;

final signInFailed = AtlasPage(
  auth.$SignIn,
  id: 'sign-in-failed',
  label: 'Sign In · failed',
  args: auth.ExamplePageArgs.fixed(title: 'Sign In failed'),
);

const terms = AtlasTerminal(
  label: 'Terms of Service',
  url: 'https://example.com/terms',
  description: 'Opens the terms in the browser',
);

final authentication = AtlasFlow(
  name: 'Authentication',
  links: {
    auth.$Welcome: [auth.$SignIn, auth.$SignUp],
    auth.$SignIn: [account.$Home, signInFailed, auth.$SignUp],
    signInFailed: [auth.$SignIn],
    auth.$SignUp: [account.$Home, auth.$SignIn, terms],
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
