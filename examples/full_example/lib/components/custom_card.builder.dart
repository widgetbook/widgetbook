// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint

// **************************************************************************
// BuilderGenerator
// **************************************************************************

part of 'custom_card.dart';

Widget defaultCustomCardGenerated(BuildContext context) {
  {
    return const CustomCard(child: Text('This is a custom card'));
  }
}

Widget customBackgroundCustomCardGenerated(BuildContext context) {
  {
    return CustomCard(
      backgroundColor: Colors.green.shade100,
      child: const Text('This is a custom card with a custom background color'),
    );
  }
}
