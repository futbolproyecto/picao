import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LockSettingsComponent } from './lock-settings.component';

describe('LockSettingsComponent', () => {
  let component: LockSettingsComponent;
  let fixture: ComponentFixture<LockSettingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LockSettingsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LockSettingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
