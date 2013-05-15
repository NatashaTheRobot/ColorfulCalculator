//
//  ColorsViewController.m
//  CalculatorWithBlocks
//
//  Created by Natasha Murashev on 5/14/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@property (strong, nonatomic) UIColor *tappedViewColor;

- (void)addGesturesToColorViews;
- (void)changeColor:(UITapGestureRecognizer *)recognizer;

@end

@implementation ColorsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addGesturesToColorViews];
}

- (void)addGesturesToColorViews
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == 1) {
            UITapGestureRecognizer *singleFingeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
            [view addGestureRecognizer:singleFingeTap];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.tappedViewColor = touch.view.backgroundColor;
}

- (void)changeColor:(UITapGestureRecognizer *)recognizer
{
    [self.delegate changeColor:self.tappedViewColor];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
