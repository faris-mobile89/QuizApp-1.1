//
//  ResultExamTowViewController.h
//  QuizApp
//
//  Created by Faris IOS on 6/18/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultExamTowViewController : UIViewController<UIWebViewDelegate>
- (IBAction)printButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic,strong) NSString *resultTag;
@end
