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

@interface ViewController (){
    UserInformation *user ;
    //// faris
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    
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
    self.nationality.delegate=self;
    self.phoneNumber.delegate=self;
    
    user = [[UserInformation alloc]init];
    
    _nationlaitesNames = sortedCountryArray;
    
    _nationality =_nationlaitesNames[0];
    
    
    [super viewDidLoad];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.username resignFirstResponder];
    [self.email resignFirstResponder];
    [self.nationality resignFirstResponder];
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
    /*
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
     [self performSegueWithIdentifier:@"examType" sender:nil];
     */
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
    
    if ([user.username length ] > 0 && [user.email length ] > 0  ) {
        
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
        //[self performSegueWithIdentifier:@"examType" sender:nil];
        
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"يرجى تعبئه جميع الحقول" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _nationlaitesNames[row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _nationality = _nationlaitesNames[row];
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
