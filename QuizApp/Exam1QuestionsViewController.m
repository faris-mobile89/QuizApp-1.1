//
//  Exam1QuestionsViewController.m
//  QuizApp
//
//  Created by Faris IOS on 6/10/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import "Exam1QuestionsViewController.h"
#import "ResultExam1ViewController.h"
@interface Exam1QuestionsViewController (){
    NSMutableArray *arrayOfdata;
    


}
@property (nonatomic,strong) NSString *Question1Tag,*Question2Tag,*userAnswerTag;
@property (assign, nonatomic) BOOL transitionInProgress;
@property  (nonatomic,strong)  NSString *result;
@property (weak,nonatomic) NSMutableArray *userAnswerArray;
@end

@implementation Exam1QuestionsViewController
@synthesize radioView;
@synthesize Question2Tag,Question1Tag,userAnswerTag;
@synthesize result;
@synthesize QestionOneLable,QuesrionTowLable;
@synthesize QuestionNumber;
@synthesize userAnswerArray;

UILabel *label1;
UILabel *label2;

NSInteger QuestionCounter=0;

NSInteger groupE=0;
NSInteger groupI=0;

NSInteger groupS=0;
NSInteger groupN=0;

NSInteger groupT=0;
NSInteger groupF=0;

NSInteger groupJ=0;
NSInteger groupP=0;

int flag_back=0;
NSString *lastAnswerTag;


- (void)viewDidLoad
{
    [self firstLaod];
    [_fbtnBack setEnabled:FALSE];

    
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
 [self firstLaod];
}

-(void)clearData{
    
QuestionCounter = 0;
groupE=0;
groupI=0;
    
groupS=0;
groupN=0;
    
groupT=0;
groupF=0;
groupJ=0;
groupP=0;
result=@"";

}

-(void)firstLaod{
    
    [self clearData];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 400)];
    [container removeFromSuperview];
    arrayOfdata = [self LoadData];
    
    [radioView addSubview:container];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    
    rb1.frame = CGRectMake(5,10,22,22);
    rb2.frame = CGRectMake(5,130,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    
    QestionOneLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q1"];
    QuesrionTowLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q2"];
    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
    Question1Tag = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q1Tag"];
    Question2Tag = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q2Tag"];
    QuestionCounter++;
    QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter,@"من اصل 38"];
    userAnswerTag=nil;
}
-(NSMutableArray*)LoadData{

    NSString *listPath = [[NSBundle mainBundle]pathForResource:@"Questions1" ofType:@"plist"];
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithContentsOfFile:listPath];
    
   //NSLog(@"before%@",arr);
    
    NSInteger count = [arr count];
    NSInteger firstObject=0;
    for (NSInteger i=0; i<count-1; i++) {
        NSInteger swipe = random() % (count-1)+i;
         NSInteger randomIndex = 0 + arc4random() % (count-0);
        if(swipe < count)
        [arr exchangeObjectAtIndex:swipe withObjectAtIndex:randomIndex];
        firstObject++;
    }
   // NSLog(@"after%@",arr);
    return arr;
}


-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    
    switch (index) {
        case 0:
            userAnswerTag = Question1Tag;
            break;
            case 1:
            userAnswerTag = Question2Tag;
            break;
        default:
            userAnswerTag=Nil;
            break;
    }
    lastAnswerTag = userAnswerTag;
}

-(void)addRadio{


    [[radioView subviews ]makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 400)];
    [container removeFromSuperview];
    
    [radioView addSubview:container];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
  
    QestionOneLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q1"];
    QuesrionTowLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q2"];
    
    rb1.frame = CGRectMake(5,10,22,22);
    rb2.frame = CGRectMake(5,130,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    
    
    [RadioButton addObserverForGroupId:@"first group" observer:self];


}

- (IBAction)nextQuestion:(id)sender {
 
    
    NSLog(@"QustionCounter:%li",(long)QuestionCounter);
    
    if (QuestionCounter >= 1 && flag_back != 0) {
        [_fbtnBack setEnabled:TRUE];
        NSLog(@"must enable");
    }
    else{
        
        [_fbtnBack setEnabled:FALSE];
    }
    
    
    if (userAnswerTag==nil) {
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"يرجى اختيار اجابة من الخيارات ! " delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
        [alert show];
    }else
    
    if(QuestionCounter < [arrayOfdata count]){
        
        [self addRadio];
        
        label1.text = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q1"];
        label2.text = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q2"];
        
        Question1Tag = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q1Tag"];
        Question2Tag = [[arrayOfdata objectAtIndex:QuestionCounter]valueForKey:@"Q2Tag"];
        
      //  NSLog(@"tag1:%@ , tag3:%@",Question1Tag,Question2Tag);
        [self setResults:userAnswerTag];

        userAnswerTag=nil;
        QuestionCounter++;
        QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter,@"من اصل 38"];
        [_fbtnBack setEnabled:TRUE];

       
        
    }else if(QuestionCounter == [arrayOfdata count]){
        QestionOneLable.text =@"";
        QuesrionTowLable.text =  @"";
         [self setResults:userAnswerTag];
        [[radioView subviews ]makeObjectsPerformSelector:@selector(removeFromSuperview)];
        QuestionCounter++;
        [self.BtnNext setTitle:@"ُعرض النتيجة" forState:UIControlStateNormal];
        self.thankMessage.text=@"شكرا لكم لاستكمال الاختبار ،نتمنى لكم نتيجة موفقة .";
        _label.text=@"";
         QuestionNumber.text=@"";
    }else if(QuestionCounter > [arrayOfdata count]) {
        [self showResult];
    }
    
}

- (IBAction)btnBack:(id)sender {
    
    NSLog(@"Qustion counter %li",(long)QuestionCounter);
    flag_back =1;
    [_fbtnBack setEnabled:FALSE];
    [self ChangeResults:lastAnswerTag];

    if (QuestionCounter!=0 && QuestionCounter>1)

      QuestionCounter = QuestionCounter-1;
    if(QuestionCounter < [arrayOfdata count] && QuestionCounter >= 0){
        
        
        [self addRadio];
        
        label1.text = [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q1"];
        label2.text = [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q2"];
        
        QestionOneLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q1"];
        QuesrionTowLable.text =  [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q2"];
        
        Question1Tag = [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q1Tag"];
        Question2Tag = [[arrayOfdata objectAtIndex:QuestionCounter-1]valueForKey:@"Q2Tag"];
        
        //  NSLog(@"tag1:%@ , tag3:%@",Question1Tag,Question2Tag);
        [self setResults:userAnswerTag];
        
        userAnswerTag=nil;
        QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter,@"من اصل 38"];
    }
    

}

-(void)setResults:(NSString*) str{

    if ([str isEqualToString:@"E"])
        groupE++;
    else if ([str isEqualToString:@"F"])
        groupF++;
    else if ([str isEqualToString:@"I"])
        groupI++;
    else if ([str isEqualToString:@"T"])
        groupT++;
    else if ([str isEqualToString:@"S"])
        groupS++;
    else if ([str isEqualToString:@"P"])
        groupP++;
    else if ([str isEqualToString:@"J"])
        groupJ++;
    else if ([str isEqualToString:@"N"])
        groupN++;
    
    lastAnswerTag = str;

    
    
}

-(void)ChangeResults:(NSString*) str{
    
    NSLog(@"Change answer Tag : %@",str);

    
    if ([str isEqualToString:@"E"])
        groupE--;
    else if ([str isEqualToString:@"F"])
        groupF--;
    else if ([str isEqualToString:@"I"])
        groupI--;
    else if ([str isEqualToString:@"T"])
        groupT--;
    else if ([str isEqualToString:@"S"])
        groupS--;
    else if ([str isEqualToString:@"P"])
        groupP--;
    else if ([str isEqualToString:@"J"])
        groupJ--;
    else if ([str isEqualToString:@"N"])
        groupN--;
    
}
-(void)showResult{
    
    NSString *str1,*str2,*str3,*str4;
    
    if(groupI > groupE)
        str1=@"I";
    else
        str1 =@"E";
    
    if(groupS > groupN)
        str2=@"S";
    else
        str2 =@"N";
    
    if(groupT > groupF)
        str3=@"T";
    else
        str3 =@"F";
    
    if(groupJ > groupP)
        str4=@"J";
    else
        str4 =@"P";
    
     result =[[NSString alloc]initWithFormat:@"%@%@%@%@",str1,str2,str3,str4 ];
    
     //NSLog(@"Result:%@",result);
    
    [self performSegueWithIdentifier:@"result_exam1" sender:nil];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        if ([segue.identifier isEqualToString:@"result_exam1"]) {
       
            ResultExam1ViewController *r = segue.destinationViewController;
             r.resultTag = result;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
