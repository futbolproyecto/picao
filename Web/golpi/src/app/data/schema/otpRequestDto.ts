export class OtpRequestDto {
  email?: string;
  otp?: string;

  mobile_number?: string;
  is_reserve?: boolean;

  constructor(init?: Partial<OtpRequestDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}
