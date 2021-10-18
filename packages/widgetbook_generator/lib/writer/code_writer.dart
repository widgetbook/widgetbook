// TODO in general code writer should be improved so properties are set instead of the full code
// this would improve readability and also makes it easier to generate trailing commata
abstract class CodeWriter<WriteType> {
  String write(WriteType type);
}
