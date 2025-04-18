import { ElementRef } from '@angular/core';
import {
  AbstractControl,
  FormControl,
  FormGroup,
  ValidationErrors,
  ValidatorFn,
} from '@angular/forms';

export class ValidatorsCustom {
  static validarSiHayEspacios: ValidatorFn = (
    control: AbstractControl
  ): ValidationErrors | null => {
    const campo = control.value as string;
    if (campo && campo.includes(' ')) {
      return { hayEspacios: true };
    }
    return null;
  };

  static validarQueSeanIguales(
    formGroup: AbstractControl
  ): ValidationErrors | null {
    const password = formGroup.get('passwordNew')?.value;
    const confirmPassword = formGroup.get('passwordConfirm')?.value;

    if (password !== confirmPassword) {
      formGroup.get('passwordConfirm')?.setErrors({ noSonIguales: true });
      return { noSonIguales: true };
    } else {
      const errors = formGroup.get('passwordConfirm')?.errors;
      if (errors) {
        delete errors['noSonIguales'];
        if (Object.keys(errors).length === 0) {
          formGroup.get('passwordConfirm')?.setErrors(null);
        } else {
          formGroup.get('passwordConfirm')?.setErrors(errors);
        }
      }
      return null;
    }
  }

  static validarFechaMayorMax(fechaValida: Date): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      if (!control.value) return null;

      const fecha = new Date(control.value);
      return fechaValida > fecha ? null : { fechaMayorMax: true };
    };
  }

  static validateAllFormFields(formGroup: FormGroup, element: ElementRef) {
    formGroup.markAllAsTouched();

    Object.keys(formGroup.controls).forEach((field) => {
      const control = formGroup.get(field);
      if (control instanceof FormControl) {
        control.markAsDirty();
      } else if (control instanceof FormGroup) {
        this.validateAllFormFields(control, element); // Sigue validando recursivamente
      }
    });

    const invalidControl = element.nativeElement.querySelector(
      '[formControlName]:invalid'
    );
    if (invalidControl) {
      invalidControl.focus();
    }
  }
}
