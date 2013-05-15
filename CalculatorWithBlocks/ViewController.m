//
//  ViewController.m
//  CalculatorWithBlocks
//
//  Created by Natasha Murashev on 5/14/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "ViewController.h"
#import "ColorsViewController.h"

typedef CGFloat (^MathBloc)(NSInteger, NSInteger);

@interface ViewController ()

@property (copy, nonatomic) MathBloc add;
@property (copy, nonatomic) MathBloc subtract;
@property (copy, nonatomic) MathBloc multiply;
@property (copy, nonatomic) MathBloc divide;

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
    [self setAllBlocs];
}

- (void)setAllBlocs
{
    self.add = ^(NSInteger x, NSInteger y){ return (CGFloat)x + (CGFloat)y; };
    self.subtract = ^(NSInteger x, NSInteger y){ return (CGFloat)x - (CGFloat)y; };
    self.multiply = ^(NSInteger x, NSInteger y){ return (CGFloat)x * (CGFloat)y; };
    self.divide = ^(NSInteger x, NSInteger y){ return (CGFloat)x / (CGFloat)y; };
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
        MathBloc mathBloc;
        
        if ([self.operatorClicked isEqualToString:@"+"]) {
            mathBloc = self.add;
        } else if ([self.operatorClicked isEqualToString:@"-"]) {
            mathBloc = self.subtract;
        } else if ([self.operatorClicked isEqualToString:@"*"]) {
            mathBloc = self.multiply;
        } else if ([self.operatorClicked isEqualToString:@"/"]) {
            mathBloc = self.divide;
        }
        
        CGFloat answer = mathBloc([self.numbersClicked[0] integerValue], [self.numbersClicked[1] integerValue]);
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
