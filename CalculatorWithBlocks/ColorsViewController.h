//
//  ColorsViewController.h
//  CalculatorWithBlocks
//
//  Created by Natasha Murashev on 5/14/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorDelegate.h"

@interface ColorsViewController : UIViewController

@property (strong, nonatomic) id<ColorDelegate> delegate;

@end
