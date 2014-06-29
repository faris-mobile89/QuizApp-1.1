//
//  ExamTowViewController.h
//  QuizApp
//
//  Created by Faris IOS on 6/17/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

@interface ExamTowViewController : UIViewController<RadioButtonDelegate>{

}
@property (weak, nonatomic) IBOutlet UILabel *OptionThree;
@property (weak, nonatomic) IBOutlet UILabel *OptionTow;
@property (weak, nonatomic) IBOutlet UILabel *OptionOne;
@property (weak, nonatomic) IBOutlet UILabel *QuestionNumber;
@property (weak, nonatomic) IBOutlet UILabel *thankMessage;
@property (weak, nonatomic) IBOutlet UIButton *BtnNext;
- (IBAction)nextQuestion:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *radioView;
@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;
@end
