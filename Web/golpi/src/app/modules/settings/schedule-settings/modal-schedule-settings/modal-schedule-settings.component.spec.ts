import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModalScheduleSettingsComponent } from './modal-schedule-settings.component';

describe('ModalScheduleSettingsComponent', () => {
  let component: ModalScheduleSettingsComponent;
  let fixture: ComponentFixture<ModalScheduleSettingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModalScheduleSettingsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModalScheduleSettingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
