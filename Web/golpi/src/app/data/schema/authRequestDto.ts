export class AuthRequestDto {
  id?: number;
  mobileNumber?: string;
  token?: string;
  roles?: string[];

  nombre_usuario?: string;

  constructor(init?: Partial<AuthRequestDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}
