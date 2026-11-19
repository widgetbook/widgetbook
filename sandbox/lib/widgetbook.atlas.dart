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
  groups: [
    AtlasGroup(name: 'Entry', pages: [auth.$Welcome]),
    AtlasGroup(
      name: 'Credentials',
      pages: [auth.$SignIn, signInFailed, auth.$SignUp],
    ),
  ],
  links: {
    auth.$Welcome: [
      AtlasLink(to: auth.$SignIn, label: 'Sign in'),
      AtlasLink(to: auth.$SignUp, label: 'Create account'),
    ],
    auth.$SignIn: [
      AtlasLink(to: account.$Home, label: 'Valid credentials'),
      AtlasLink(to: signInFailed, label: 'Wrong password'),
      AtlasLink(to: auth.$SignUp, label: 'No account yet'),
    ],
    signInFailed: [
      AtlasLink(
        to: auth.$SignIn,
        label: 'Try again',
        description: 'Clears the password field',
      ),
    ],
    auth.$SignUp: [
      account.$Home,
      AtlasLink(to: auth.$SignIn, label: 'Has an account'),
      const AtlasLink(to: terms, label: 'Terms'),
    ],
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
