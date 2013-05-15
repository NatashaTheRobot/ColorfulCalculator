//
//  Math.m
//  CalculatorWithBlocks
//
//  Created by Natasha Murashev on 5/15/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "Math.h"

typedef CGFloat (^MathBloc)(NSInteger, NSInteger);

@interface Math()

@property (copy, nonatomic) MathBloc add;
@property (copy, nonatomic) MathBloc subtract;
@property (copy, nonatomic) MathBloc multiply;
@property (copy, nonatomic) MathBloc divide;

@end

@implementation Math

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setAllBlocs];
    }
    
    return self;
}

- (void)setAllBlocs
{
    self.add = ^(NSInteger x, NSInteger y){ return (CGFloat)x + (CGFloat)y; };
    self.subtract = ^(NSInteger x, NSInteger y){ return (CGFloat)x - (CGFloat)y; };
    self.multiply = ^(NSInteger x, NSInteger y){ return (CGFloat)x * (CGFloat)y; };
    self.divide = ^(NSInteger x, NSInteger y){ return (CGFloat)x / (CGFloat)y; };
}

- (CGFloat)calculateWithNumber:(NSInteger)x andNumber:(NSInteger)y andOperator:(NSString *)operator
{
    MathBloc mathBloc;
    
    if ([operator isEqualToString:@"+"]) {
        mathBloc = self.add;
    } else if ([operator isEqualToString:@"-"]) {
        mathBloc = self.subtract;
    } else if ([operator isEqualToString:@"*"]) {
        mathBloc = self.multiply;
    } else if ([operator isEqualToString:@"/"]) {
        mathBloc = self.divide;
    }
    
    CGFloat answer = mathBloc(x, y);
    
    return answer;
}

@end
