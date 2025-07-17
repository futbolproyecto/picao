import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReservationInformationModalComponent } from './reservation-information-modal.component';

describe('ReservaModalComponent', () => {
  let component: ReservationInformationModalComponent;
  let fixture: ComponentFixture<ReservationInformationModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReservationInformationModalComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(ReservationInformationModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
