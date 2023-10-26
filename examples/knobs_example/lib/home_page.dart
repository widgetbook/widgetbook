import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    this.incrementBy = 1,
    this.countLabel,
    this.iconData,
    this.showToolTip = true,
    this.duration = Duration.zero,
    this.dateTime,
    this.color = Colors.black,
  });

  final String title;
  final int incrementBy;
  final String? countLabel;
  final IconData? iconData;
  final bool showToolTip;
  final Duration duration;
  final DateTime? dateTime;
  final Color color;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.countLabel ??
                  'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${widget.duration}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.dateTime?.toSimpleFormat() ?? '-',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.color.value.toRadixString(16),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: widget.color,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter += widget.incrementBy;
          });
        },
        tooltip: widget.showToolTip ? 'Increment' : null,
        child: Icon(
          widget.iconData ?? Icons.add,
        ),
      ),
    );
  }
}
