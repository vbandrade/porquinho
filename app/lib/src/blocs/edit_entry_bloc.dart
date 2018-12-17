import 'package:app/src/blocs/create_entry_bloc.dart';

class EditEntryBloc extends CreateEntryBloc with AmountValidator {
  final String id;

  EditEntryBloc(this.id);
}
