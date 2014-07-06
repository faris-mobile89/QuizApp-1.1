//
//  ResultExam1ViewController.m
//  QuizApp
//
//  Created by Faris IOS on 6/15/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import "ResultExam1ViewController.h"
#import "UserInformation.h"


@interface ResultExam1ViewController ()

@end

@implementation ResultExam1ViewController
@synthesize resultTag;
@synthesize myWebView;

- (void)viewDidLoad
{
   // NSLog(@"result %@",resultTag);
    
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
   // NSArray *data =[NSArray arrayWithObjects:user.username,user.phoneNumber,user.birthDate,user.email,user.address,user.gender, nil];
    
    NSArray *userData = [NSArray arrayWithContentsOfFile:path];
     NSLog(@"user data%@",userData);
   /* UserInformation *user = [[UserInformation alloc]init];
    user.username = [userData objectAtIndex:0];
    user.phoneNumber=[userData objectAtIndex:1];
    user.birthDate = [userData objectAtIndex:2];
    user.email= [userData objectAtIndex:3];
    user.gender = [userData objectAtIndex:4];
    */
    myWebView.delegate = self;
    
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:resultTag ofType: @"html"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    [myWebView loadRequest:request];
    

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)printButton:(id)sender {
    
    UIPrintInfo *pi = [UIPrintInfo printInfo];
    pi.outputType = UIPrintInfoOutputGeneral;
    pi.jobName = myWebView.request.URL.absoluteString;
    pi.orientation = UIPrintInfoOrientationPortrait;
    pi.duplex = UIPrintInfoDuplexLongEdge;
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.printInfo = pi;
    pic.showsPageRange = YES;
    pic.printFormatter = myWebView.viewPrintFormatter;
    [pic presentAnimated:YES completionHandler:^(UIPrintInteractionController *pic2, BOOL completed, NSError *error) {
        // indicate done or error
    }];
}
@end
