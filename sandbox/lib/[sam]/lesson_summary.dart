import 'package:material_ui/material_ui.dart';

class LessonSummary extends StatelessWidget {
  const LessonSummary({
    super.key,
    this.title = 'Make an appointment',
    this.phraseCount = 20,
  });

  final String title;
  final int phraseCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close),
        title: const Text('Lesson complete'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: phraseCount + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _Header(title: title);
                return PhraseCard(index: index);
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Next lesson'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  static const _topics = [
    'Greetings',
    'Numbers',
    'Weekdays',
    'Time',
    'Places',
    'Food',
    'Travel',
    'Family',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('You practised', style: theme.textTheme.headlineSmall),
        Text('Lesson: $title', style: theme.textTheme.titleMedium),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _topics.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) => Chip(label: Text(_topics[index])),
          ),
        ),
        const SizedBox(height: 16),
        Text('Phrases to keep', style: theme.textTheme.titleSmall),
      ],
    );
  }
}

class PhraseCard extends StatelessWidget {
  const PhraseCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Phrase $index'),
        subtitle: Text('Translation of phrase $index'),
        trailing: const Icon(Icons.volume_up_outlined),
      ),
    );
  }
}
