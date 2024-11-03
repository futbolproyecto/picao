import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TeamController extends GetxController {
  TeamController();

  var formTeamRegistrer = FormGroup({
    'team_name': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
    'representative_name': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'contact_number': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'city': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'area': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
  }, validators: []);
}
