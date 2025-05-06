import { ComponentFixture, TestBed } from '@angular/core/testing';
import { UpdateDataComponent } from './update-data.component';

describe('UpdateDataComponent', () => {
  let component: UpdateDataComponent;
  let fixture: ComponentFixture<UpdateDataComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UpdateDataComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(UpdateDataComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
