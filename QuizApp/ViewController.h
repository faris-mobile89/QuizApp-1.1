//
//  ViewController.h
//  QuizApp
//
//  Created by Faris IOS on 6/10/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam1ViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *birthDay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *nationality;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) NSArray *nationlaitesNames;
- (IBAction)exam1:(id)sender;

@end
