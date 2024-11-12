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
    const Toast = Swal.mixin({
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
      confirmButtonColor: '#4CAF50',
      cancelButtonColor: '#f44336',
    }).then((result) => {
      if (result.isConfirmed) {
        myCallBack();
      }
    });
  }
}
