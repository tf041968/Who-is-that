//
//  testing.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-16.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "testing.h"
#import "ViewController.h"
@implementation testing
@synthesize point;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // If not dragging, send event to next responder
    if (!self.dragging){
        [self.nextResponder touchesBegan: touches withEvent:event];
    }
    else{
        [super touchesEnded: touches withEvent: event];
    }
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 987654321) {
            [subview removeFromSuperview];
        }
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // If not dragging, send event to next responder
    if (!self.dragging){
        [self.nextResponder touchesBegan: touches withEvent:event];
    }
    else{
        [super touchesEnded: touches withEvent: event];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // If not dragging, send event to next responder
    if (!self.dragging){
        [self.nextResponder touchesBegan: touches withEvent:event];
    }
    else{
        [super touchesEnded: touches withEvent: event];
    }
    point=[[touches anyObject] locationInView:self];
    
    NSLog(@"x %f y %f",point.x,point.y);
     label = [[UILabel alloc]initWithFrame:CGRectMake
                      (point.x,
                       point.y,
                       1,
                       1)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tape.png"]];
    label.tag = 987654321;
    [self addSubview:label];

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
