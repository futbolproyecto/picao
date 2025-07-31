import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SoccerFieldComponent } from './soccer-field.component';

describe('SoccerFieldComponent', () => {
  let component: SoccerFieldComponent;
  let fixture: ComponentFixture<SoccerFieldComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SoccerFieldComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SoccerFieldComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
