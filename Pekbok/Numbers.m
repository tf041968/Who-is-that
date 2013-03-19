//
//  Numbers.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-30.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Numbers.h"

@implementation Numbers

+(NSMutableArray *)AllNumbers{
    
    
    
    //NSURL *catURL = [[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"];
    //NSString *catSound = [catURL absoluteString];
    NSArray *one = [[NSArray alloc]initWithObjects:@"Ett",
                    [NSNumber numberWithInt:3],
                    [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"],
                    [[[NSBundle mainBundle] URLForResource: @"Ett" withExtension:@"m4a"]absoluteString],
                    nil];
    
    NSArray *two = [[NSArray alloc]initWithObjects:@"Två",
                    [NSNumber numberWithInt:3],
                    [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                    [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                    nil];
    
    NSArray *three = [[NSArray alloc]initWithObjects:@"Tre",
                      [NSNumber numberWithInt:3],
                      [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                      [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                      nil];
    
    
    
    
    NSMutableArray *allNumbers = [[NSMutableArray alloc]init];
    
    [allNumbers addObject:one];
    [allNumbers addObject:two];
    [allNumbers addObject:three];
    
    return allNumbers;
    
}





@end
