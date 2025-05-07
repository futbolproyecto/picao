// Core
import { Injectable } from '@angular/core';

// Data
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';

// Librerias
import Swal, { SweetAlertIcon } from 'sweetalert2';

@Injectable({
  providedIn: 'root',
})
export class AlertsService {
  toast(icon: SweetAlertIcon, title: string, timer: number = 3000) {
    const screenWidth = window.innerWidth;

    const calculateWidth = (title: string): string => {
      const baseCharWidth = 15;
      const padding = 50;
      const maxWidth =
        screenWidth < 768 ? screenWidth * 0.9 : screenWidth * 0.4;
      const minWidth = 200;
      const calculated = title.length * baseCharWidth + padding;

      return Math.min(Math.max(calculated, minWidth), maxWidth) + 'px';
    };

    const toastWidth = calculateWidth(title);

    const Toast = Swal.mixin({
      width: toastWidth,
      toast: true,
      position: 'bottom-end',
      showConfirmButton: false,
      timer: timer,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
      },
    });

    Toast.fire({
      icon: icon,
      title: title,
    });
  }

  fireError(errorDto: MessageExceptionDto) {
    Swal.fire({
      title: `Error [${errorDto.status}]`,
      html: `<b>Descripción:</b> ${errorDto.error}   </br>  <b>Recomendaciones:</b> ${errorDto.recommendation} `,
      icon: 'error',
      showClass: {
        popup: 'animate__animated animate__fadeInDown',
      },
      hideClass: {
        popup: 'animate__animated animate__fadeOutUp',
      },
    });
  }

  fireError2(errorDto: MessageExceptionDto, retryCallback: () => void) {
    Swal.fire({
      title: `Error [${errorDto.status}]`,
      html: `<b>Descripción:</b> ${errorDto.error}   </br>  <b>Recomendaciones:</b> ${errorDto.recommendation} `,
      icon: 'error',
      showClass: {
        popup: 'animate__animated animate__fadeInDown',
      },
      hideClass: {
        popup: 'animate__animated animate__fadeOutUp',
      },
      willClose: () => {
        retryCallback();
      },
    });
  }

  fireConfirm(
    icon: SweetAlertIcon,
    title: string,
    text: string,
    myCallBack: any
  ) {
    Swal.fire({
      title: title,
      text: text,
      icon: icon,
      reverseButtons: true,
      showCancelButton: true,
      confirmButtonText: 'Si',
      cancelButtonText: 'No',
      confirmButtonColor: '#725187',
      cancelButtonColor: '#306a42',
    }).then((result) => {
      if (result.isConfirmed) {
        myCallBack();
      }
    });
  }

  emailConfirm(
    icon: SweetAlertIcon,
    title: string,
    text: string,
    myCallBack: any
  ) {
    Swal.fire({
      title: title,
      text: text,
      icon: icon,
      reverseButtons: true,
      showCancelButton: false,
      confirmButtonText: 'Aceptar',
      confirmButtonColor: '#725187',
    }).then((result) => {
      if (result.isConfirmed) {
        myCallBack();
      }
    });
  }

  fireConfirmMail(
    icon: SweetAlertIcon,
    title: string,
    text: string,
    myCallBack: (correo: string) => void
  ) {
    Swal.fire({
      title: title,
      text: text,
      icon: icon,
      input: 'text',
      inputPlaceholder: 'Ingrese correo electrónico',
      reverseButtons: true,
      showCancelButton: true,
      confirmButtonText: 'Validar',
      cancelButtonText: 'Cancelar',
      confirmButtonColor: '#725187',
      cancelButtonColor: '#306a42',
      preConfirm: (correo) => {
        if (!correo) {
          Swal.showValidationMessage('Debe ingresar un correo electrónico');
          return false;
        }
        return new Promise((resolve) => {
          myCallBack(correo);
          resolve(correo);
        });
      },
      customClass: {
        popup: 'custom-popup',
      },
    });
  }

  fireConfirmCode(
    icon: SweetAlertIcon,
    title: string,
    text: string,
    correo: string,
    callback: (correo: string, otp: string) => void
  ) {
    Swal.fire({
      title: title,
      text: text,
      icon: icon,
      input: 'text',
      inputPlaceholder: 'Ingrese el código recibido',
      reverseButtons: true,
      showCancelButton: true,
      confirmButtonText: 'Verificar',
      cancelButtonText: 'Cancelar',
      confirmButtonColor: '#725187',
      cancelButtonColor: '#306a42',
      preConfirm: (otp) => {
        if (!otp) {
          Swal.showValidationMessage('Debe ingresar el código');
          return false;
        }
        callback(correo, otp);
        return { correo, otp };
      },
      customClass: {
        popup: 'custom-popup',
      },
    });
  }

  fireChangePassword(
    correo: string,
    otp: string,
    callback: (email: string, password: string, otp: string) => void
  ) {
    Swal.fire({
      title: 'Ingrese su nueva contraseña',
      text: 'Por favor ingrese su nueva contraseña y confirme',
      icon: 'warning',
      html: `
        <input type="password" id="password" class="swal2-input" placeholder="Nueva contraseña" required>
        <input type="password" id="confirmPassword" class="swal2-input" placeholder="Confirmar contraseña" required>
      `,
      reverseButtons: true,
      showCancelButton: true,
      confirmButtonText: 'Cambiar contraseña',
      cancelButtonText: 'Cancelar',
      confirmButtonColor: '#725187',
      cancelButtonColor: '#306a42',
      preConfirm: () => {
        const popup = Swal.getPopup();
        const password = (popup?.querySelector('#password') as HTMLInputElement)
          ?.value;
        const confirmPassword = (
          popup?.querySelector('#confirmPassword') as HTMLInputElement
        )?.value;

        if (!password || !confirmPassword) {
          Swal.showValidationMessage(
            'Debe ingresar y confirmar la nueva contraseña'
          );
          return false;
        }

        if (password !== confirmPassword) {
          Swal.showValidationMessage('Las contraseñas no coinciden');
          return false;
        }

        callback(correo, password, otp);
        return { password, confirmPassword };
      },
      customClass: {
        popup: 'custom-popup',
      },
    });
  }
}
