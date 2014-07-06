//
//  ExamTowViewController.m
//  QuizApp
//
//  Created by Faris IOS on 6/17/14.
//  Copyright (c) 2014 Faris Abu Saleem. All rights reserved.
//

#import "ExamTowViewController.h"
#import "ResultExamTowViewController.h"

@interface ExamTowViewController (){
    NSMutableArray *arrayOfdata;
}
@property (nonatomic,strong) NSString *Question1Tag,*QuestionPart,*checkedValue;
@property (assign, nonatomic) BOOL transitionInProgress;
@property  (nonatomic,strong)  NSString *result;
@end

@implementation ExamTowViewController
@synthesize radioView;
@synthesize QuestionPart,checkedValue;
@synthesize result;
@synthesize QuestionLabel;
@synthesize QuestionNumber;
@synthesize OptionOne,OptionThree,OptionTow;

int mflag_back=0;
NSString *lastAnswerTag;

NSInteger answer_A0=0;
NSInteger answer_B0=0;
NSInteger answer_C0=0;
NSInteger answer_D0=0;

NSInteger answer_A1=0;
NSInteger answer_B1=0;
NSInteger answer_C1=0;
NSInteger answer_D1=0;

NSInteger answer_A3=0;
NSInteger answer_B3=0;
NSInteger answer_C3=0;
NSInteger answer_D3=0;


NSInteger QuestionCounter1=0;

- (void)viewDidLoad
{
    [self firstLaod];
    [super viewDidLoad];
}

-(void)firstLaod{
    
    [self clearData];
    
    [_fbtnBack setEnabled:FALSE];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 400)];
    [container removeFromSuperview];
    arrayOfdata = [self LoadData];
    
    [radioView addSubview:container];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    RadioButton *rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    
    rb1.frame = CGRectMake(0,0,22,22);
    rb2.frame = CGRectMake(0,50,22,22);
    rb3.frame = CGRectMake(0,100,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    [container addSubview:rb3];
   // NSLog(@"data%@",arrayOfdata);
    
    QuestionLabel.text = [[arrayOfdata objectAtIndex:QuestionCounter1]valueForKey:@"Question"];
    QuestionPart = [[arrayOfdata objectAtIndex:QuestionCounter1]valueForKey:@"Part"];

    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
    
    QuestionCounter1++;
    checkedValue=nil;
    mflag_back =1;
    QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter1,@"من اصل 48"];
}

-(NSMutableArray*)LoadData{
    
    NSString *listPath = [[NSBundle mainBundle]pathForResource:@"QuestionTow" ofType:@"plist"];
    
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
            checkedValue = [[NSString alloc]initWithFormat:@"%@%i",QuestionPart,1];
            break;
        case 1:
            checkedValue = [[NSString alloc]initWithFormat:@"%@%i",QuestionPart,3];
            break;
        case 2:
            checkedValue = [[NSString alloc]initWithFormat:@"%@%i",QuestionPart,0];
            break;
        default:
            checkedValue=Nil;
            break;
    }
    lastAnswerTag = checkedValue;
    NSLog(@"Checked Value %@",checkedValue);
}


-(void)addRadio{
    
    
    [[radioView subviews ]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 400)];
    [container removeFromSuperview];
    
    [radioView addSubview:container];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    RadioButton *rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    
    rb1.frame = CGRectMake(0,0,22,22);
    rb2.frame = CGRectMake(0,50,22,22);
    rb3.frame = CGRectMake(0,100,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    [container addSubview:rb3];
    
    QuestionLabel.text = [[arrayOfdata objectAtIndex:QuestionCounter1]valueForKey:@"Question"];
    QuestionPart = [[arrayOfdata objectAtIndex:QuestionCounter1]valueForKey:@"Part"];

    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
    
}
-(void)ChangeResults:(NSString*) str{
    
    NSLog(@"Change answer Tag : %@",str);
    
    
    if([str isEqual:@"A1"])
        answer_A1--;
    if([str isEqual:@"B1"])
        answer_B1--;
    if([str isEqual:@"C1"])
        answer_C1--;
    if([str isEqual:@"D1"])
        answer_D1--;
    
    if([str isEqual:@"A3"])
        answer_A3-=3;
    if([str isEqual:@"B3"])
        answer_B3-=3;
    if([str isEqual:@"C3"])
        answer_C3-=3;
    if([str isEqual:@"D3"])
        answer_D3-=3;
    
}
- (IBAction)btnBack:(id)sender {
    
    mflag_back =1;
    [_fbtnBack setEnabled:FALSE];
    [self ChangeResults:lastAnswerTag];
    
    if (QuestionCounter1!=0 && QuestionCounter1>1){
        
        QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter1-1,@"من اصل 48"];

        QuestionCounter1 = QuestionCounter1-2;
    
       NSLog(@"Last Qustion counter %li",(long)QuestionCounter1);

    
    if(QuestionCounter1 < [arrayOfdata count] && QuestionCounter1 >= 0){
        
        
        [self addRadio];
        QuestionCounter1++;

      }
    }
}
- (IBAction)nextQuestion:(id)sender {
    
    
    NSLog(@"QustionCounter:%li",(long)QuestionCounter1);
    
    if (QuestionCounter1 >= 1 && mflag_back != 0) {
        [_fbtnBack setEnabled:TRUE];
    }
    else{
        
        [_fbtnBack setEnabled:FALSE];
    }
    
    if (mflag_back == 0) {
        [_fbtnBack setEnabled:FALSE];
    }else{
        [_fbtnBack setEnabled:TRUE];
        mflag_back =1;
    }
    
    
    if (checkedValue==nil) {
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"يرجى اختيار اجابة من الخيارات ! " delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
        [alert show];
        return;
        
    }else
        
        if(QuestionCounter1 < [arrayOfdata count]){
            
            
            [self addRadio];
            
            QuestionLabel.text = [[arrayOfdata objectAtIndex:QuestionCounter1]valueForKey:@"Question"];
            
            [self setResults:checkedValue];
            
            checkedValue=nil;
            QuestionCounter1++;
            QuestionNumber.text = [[NSString alloc]initWithFormat:@"%li %@",(long)QuestionCounter1,@"من اصل 48"];
        }else if(QuestionCounter1 == [arrayOfdata count]){
            [[radioView subviews ]makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self setResults:checkedValue];
            QuestionCounter1++;
            [self.BtnNext setTitle:@"ُعرض النتيجة" forState:UIControlStateNormal];
             self.thankMessage.text=@"شكرا لكم لاستكمال الاختبار ،نتمنى لكم نتيجة موفقة .";
            _label1.text=@"";
            
            OptionOne.text=@"";
            OptionTow.text=@"";
            OptionThree.text=@"";
            QuestionLabel.text=@"";
             QuestionNumber.text=@"";
            
        }else if(QuestionCounter1 > [arrayOfdata count]) {
        [self showResult];
        }
}

-(void)clearData{
    
    QuestionCounter1 = 0;
    answer_A0=0;
    answer_B0=0;
    
    answer_C0=0;
    answer_D0=0;
    
    answer_A1=0;
    answer_B1=0;
    answer_C1=0;
    answer_D1=0;
    answer_A3=0;
    answer_B3=0;
    answer_C3=0;
    answer_D3=0;
    result=@"";
    
}

-(void)setResults:(NSString*) str{
    
    if([str isEqual:@"A1"])
        answer_A1++;
    if([str isEqual:@"B1"])
        answer_B1++;
    if([str isEqual:@"C1"])
        answer_C1++;
    if([str isEqual:@"D1"])
        answer_D1++;
    
    if([str isEqual:@"A3"])
        answer_A3+=3;
    if([str isEqual:@"B3"])
        answer_B3+=3;
    if([str isEqual:@"C3"])
        answer_C3+=3;
    if([str isEqual:@"D3"])
        answer_D3+=3;
   
}
-(void)showResult{
    
    NSLog(@"Result loaded..");
    
    NSInteger sumA =  answer_A0+answer_A1+answer_A3;
    NSInteger sumB =  answer_B0+answer_B1+answer_B3;
    NSInteger sumC = answer_C0+answer_C1+answer_C3;
    NSInteger sumD = answer_D0+answer_D1+answer_D3;
    
   // NSLog(@"Sum A: %i",sumA);
    //NSLog(@"Sum B: %i",sumB);
    //NSLog(@"Sum C: %i",sumC);
    //NSLog(@"Sum D: %i",sumD);

    
    NSNumber  *A = [[NSNumber alloc]initWithInt:sumA];
    NSNumber  *B = [[NSNumber alloc]initWithInt:sumB];
    NSNumber  *C = [[NSNumber alloc]initWithInt:sumC];
    NSNumber  *D = [[NSNumber alloc]initWithInt:sumD];
    
     NSNumber  *A3 = [[NSNumber alloc]initWithInt:answer_A3];
     NSNumber  *B3 = [[NSNumber alloc]initWithInt:answer_B3];
     NSNumber  *C3 = [[NSNumber alloc]initWithInt:answer_C3];
     NSNumber  *D3 = [[NSNumber alloc]initWithInt:answer_D3];

    
    NSArray *groupArray =[[NSArray alloc]initWithObjects:A,B,C,D, nil];
    
    NSArray *arrOf3 =[[NSArray alloc]initWithObjects:A3,B3,C3,D3, nil];

    NSLog(@"arrayOf3%@",arrOf3);
    NSInteger max= [[groupArray objectAtIndex:0]integerValue];
    
    NSInteger maxIndex=0;
    NSInteger  value ;
    
    for (NSInteger i =0 ; i < [groupArray count]; ) {
        value =[[groupArray objectAtIndex:i]integerValue];
   
        if(value > max){
            maxIndex = i;
            max = value;
        }else
            if(value==max && maxIndex!= i){
               
                NSInteger x = [arrOf3[maxIndex]integerValue];
                NSInteger y= [[arrOf3 objectAtIndex: i]integerValue];
 
                if(y>x){
                    maxIndex=i;
                    max = value;
                }
            }
        i++;
    }
    NSLog(@"Max number %li",(long)max);

    
    if(maxIndex==0)
        result = [[NSString alloc ]initWithFormat:@"A"];
    else if(maxIndex==1)
        result =[[NSString alloc ]initWithFormat:@"B"];
    
    else  if(maxIndex==2)
        
        result =[[NSString alloc ]initWithFormat:@"C"];
    
    else if(maxIndex==3)
       result =[[NSString alloc ]initWithFormat:@"D"];
    
    NSLog(@"result:%@",result);
    
    
    [self performSegueWithIdentifier:@"result_exam2" sender:nil];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"result_exam2"]) {
        
         ResultExamTowViewController *r = segue.destinationViewController;
         r.resultTag = result;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
