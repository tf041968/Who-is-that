//
//  TextFieldSubClass.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-31.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "TextFieldSubClass.h"

@implementation TextFieldSubClass

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /* keyboard is visible, move views */
    NSLog(@"tangentbord syns");
    centerPoint = self.superview.center;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.superview.center = CGPointMake(centerPoint.x, centerPoint.y-205);
    [UIView commitAnimations];}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"tangentbord syns INTE");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.superview.center = CGPointMake(centerPoint.x, centerPoint.y);
    [UIView commitAnimations];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
