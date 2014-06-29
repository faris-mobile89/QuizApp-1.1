//
//  ResultExam1ViewController.h
//  QuizApp
//
//  Created by Faris IOS on 6/15/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultExam1ViewController : UIViewController<UIWebViewDelegate>
- (IBAction)printButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic,strong) NSString *resultTag;
@end
