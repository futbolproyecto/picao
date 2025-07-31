export class MessageExceptionDto {
  status?: number;
  error?: string;
  recommendation?: string;

  constructor(init?: Partial<MessageExceptionDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}
