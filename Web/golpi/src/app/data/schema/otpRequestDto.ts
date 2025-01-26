export class OtpRequestDto {
  email?: string;
  otp?: string;

  constructor(init?: Partial<OtpRequestDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}
