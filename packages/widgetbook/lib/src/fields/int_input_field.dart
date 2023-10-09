import 'field_codec.dart';
import 'field_type.dart';
import 'num_input_field.dart';

class IntInputField extends NumInputField<int> {
  IntInputField({
    required super.name,
    super.initialValue = 0,
    super.onChanged,
  }) : super(
          type: FieldType.intInput,
          codec: FieldCodec<int>(
            toParam: (value) => value.toString(),
            toValue: (param) => int.tryParse(param ?? ''),
          ),
        );
}
