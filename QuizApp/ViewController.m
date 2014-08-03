//
//  ViewController.m
//  QuizApp
//
//  Created by Faris IOS on 6/10/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import "ViewController.h"
#import "UserInformation.h"
#import "ExamTypeViewController.h"

#define IS_IPAD [[UIScreen mainScreen ] bounds].size.height

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController (){
    UserInformation *user ;
    //// faris
    
}

@end

@implementation ViewController
UIButton *doneButton;
- (void)viewDidLoad
{
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton:)],
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           nil];

    [_phoneNumber sizeToFit];
    _phoneNumber.inputAccessoryView = numberToolbar;
    
    
    if (self.view.bounds.size.height < 1000) {
        
        _birthDay.transform = CGAffineTransformMakeScale(0.8, 0.6);
        _picker_nationality.transform = CGAffineTransformMakeScale(.5, 0.5);
        
    }

    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    for (NSString *countryCode in countryArray) {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
    }
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    self.username.delegate=self;
    self.email.delegate=self;
    [self.username resignFirstResponder];
    self.phoneNumber.delegate=self;
    
    user = [[UserInformation alloc]init];
    
    _nationlaitesNames = sortedCountryArray;
    
    
    
    [super viewDidLoad];
}

 /*
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _phoneNumber) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)note {
   
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"doneButtonNormal.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"doneButtonPressed.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *keyboardView = [[[[[UIApplication sharedApplication] windows] lastObject] subviews] firstObject];
            [doneButton setFrame:CGRectMake(0, keyboardView.frame.size.height - 53, 106, 53)];
            [keyboardView addSubview:doneButton];
            [keyboardView bringSubviewToFront:doneButton];
            
            [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]-.02
                                  delay:.0
                                options:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                             animations:^{
                                 self.view.frame = CGRectOffset(self.view.frame, 0, 0);
                             } completion:nil];
        });
    }else {
        // locate keyboard view
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            UIView* keyboard;
            for(int i=0; i<[tempWindow.subviews count]; i++) {
                keyboard = [tempWindow.subviews objectAtIndex:i];
                // keyboard view found; add the custom button to it
                if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
                    [keyboard addSubview:doneButton];
            }
        });
    }
     

}
*/
    
-(void)doneButton:(id)sender{
    
    [self.phoneNumber resignFirstResponder];

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.username resignFirstResponder];
    [self.email resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneNumber) {
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 14) ? NO : YES;
    }
    else return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    
     NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentFolder = [path objectAtIndex:0];
     NSString *filePath = [documentFolder stringByAppendingFormat:@"myfile.plist"];
     
     NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
     
     if (array!=Nil && [array count] > 0) {
     //    NSArray *data =[NSArray arrayWithObjects:user.username,user.phoneNumber,user.birthDate,user.email,user.address,user.gender, nil];
     
     
     user.username = [array objectAtIndex:0];
     user.phoneNumber = [array objectAtIndex:1];
     user.birthDate = [array objectAtIndex:2];
     user.email = [array objectAtIndex:3];
     user.address = [array objectAtIndex:4];
     user.gender = [array objectAtIndex:5];
     [self performSegueWithIdentifier:@"examType" sender:nil];

     }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)exam1:(id)sender {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    
    NSDate *date = self.birthDay.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    //NSLog(@"BirthDay%@",dateString);
    
    user.username = self.username.text;
    user.phoneNumber = self.phoneNumber.text;
    user.birthDate = dateString;
    user.email= self.email.text;
    
    NSInteger genderIndex = self.gender.selectedSegmentIndex;
    if (genderIndex==0) {
        user.gender=@"Female";
    }else{
        user.gender=@"Male";
    }
    
    if ([user.email length ] > 0  ) {
        
        if([self NSStringIsValidEmail:user.email]){
            
            NSArray *data =[NSArray arrayWithObjects:user.username,user.phoneNumber,user.birthDate,user.email,user.gender, nil];
            
            [data writeToFile:path atomically:YES];
            
            NSLog(@"user data%@",[NSArray arrayWithContentsOfFile:path]);
            NSLog(@"%@",path);
            
            [self performSegueWithIdentifier:@"examType" sender:nil];
        }else{
            UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"يرجى كتابه بريد الكتروني صحيح" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
            [alert show];
        }
        
    }else{
        [self performSegueWithIdentifier:@"examType" sender:nil];
        
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"البريد الالكتروني الزامي" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
        [alert show];
        
    }
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_nationlaitesNames count];
}
/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _nationlaitesNames[row];
}
*/
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* label = (UILabel*)view;
    if (!label){
        label = [[UILabel alloc] init];
        [label setFont:[UIFont  boldSystemFontOfSize:30]];
        [label setText:_nationlaitesNames[row]];
    }
    return label;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //_nationality = _nationlaitesNames[row];
    NSLog(@"%@",_nationlaitesNames[row]);
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end
