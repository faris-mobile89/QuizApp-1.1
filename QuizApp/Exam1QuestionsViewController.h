//
//  Exam1QuestionsViewController.h
//  QuizApp
//
//  Created by Faris IOS on 6/10/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInformation.h"
#import "RadioButton.h"

@interface Exam1QuestionsViewController : UIViewController<RadioButtonDelegate>{

}
@property (weak, nonatomic) IBOutlet UIButton *fbtnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *thankMessage;
@property (weak, nonatomic) IBOutlet UIButton *BtnNext;
- (IBAction)nextQuestion:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *radioView;
@property (weak, nonatomic) IBOutlet UILabel *QestionOneLable;
@property (weak, nonatomic) IBOutlet UILabel *QuesrionTowLable;
@property (weak, nonatomic) IBOutlet UILabel *QuestionNumber;
@end
