//
//  ViewController.m
//  CalculatorWithBlocks
//
//  Created by Natasha Murashev on 5/14/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "ViewController.h"
#import "ColorsViewController.h"
#import "Math.h"

@interface ViewController ()

@property (strong, nonatomic) Math *math;

@property (strong, nonatomic) IBOutlet UILabel *number0Label;
@property (strong, nonatomic) IBOutlet UILabel *number1Label;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorLabel;

@property (strong, nonatomic) NSMutableArray *numbersClicked;
@property (strong, nonatomic) NSString *operatorClicked;

- (IBAction)clickedNumberButton:(id)sender;
- (IBAction)clickedOperatorButton:(id)sender;
- (IBAction)clickedEqualsButton:(id)sender;
- (IBAction)clearWithButton:(id)sender;

- (void)clearAll;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self clearAll];
    self.math = [[Math alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedNumberButton:(id)sender
{
    if (!self.numbersClicked) {
        self.numbersClicked = [NSMutableArray array];
    }
    
    if (self.numbersClicked.count > 1){
        [self clearAll];
    }
    
    NSInteger number = [((UIButton *)sender).currentTitle integerValue];
    
    [self.numbersClicked addObject:[NSNumber numberWithInteger:number]];
    
    if (!self.number0Label.text) {
        self.number0Label.text = [NSString stringWithFormat:@"%i", number];
    } else if (!self.number1Label.text) {
        self.number1Label.text = [NSString stringWithFormat:@"%i", number];
    }
    
}

- (IBAction)clickedOperatorButton:(id)sender
{
    self.operatorClicked = ((UIButton *)sender).currentTitle;
    self.operatorLabel.text = self.operatorClicked;
    
}

- (IBAction)clickedEqualsButton:(id)sender
{
    if (self.numbersClicked.count == 2 && self.operatorClicked) {        
        CGFloat answer = [self.math calculateWithNumber:[self.numbersClicked[0] integerValue] andNumber:[self.numbersClicked[1] integerValue] andOperator:self.operatorClicked];
        
        self.totalLabel.text = [NSString stringWithFormat:@"%.2f", answer];
    }
}

- (IBAction)clearWithButton:(id)sender
{
    [self clearAll];
}

- (void)clearAll
{
    [self.numbersClicked removeAllObjects];
    self.number0Label.text = nil;
    self.number1Label.text = nil;
    self.totalLabel.text = nil;
    self.operatorLabel.text = nil;
    self.operatorClicked = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((ColorsViewController *)segue.destinationViewController).delegate = self;
}

- (void)changeColor:(UIColor *)color
{
    self.view.backgroundColor = color;
}

@end
