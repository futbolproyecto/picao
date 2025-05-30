import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ScheduleSettingsComponent } from './schedule-settings.component';

describe('ScheduleSettingsComponent', () => {
  let component: ScheduleSettingsComponent;
  let fixture: ComponentFixture<ScheduleSettingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ScheduleSettingsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ScheduleSettingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
