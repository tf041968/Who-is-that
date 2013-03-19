//
//  Vehichles.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-22.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Vehichles.h"

@implementation Vehichles
+(NSMutableArray *)allAnimals{
    
    //NSURL *catURL = [[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"];
    //NSString *catSound = [catURL absoluteString];
    NSArray *car = [[NSArray alloc]initWithObjects:@"Bil",
                    [NSNumber numberWithInt:1],
                    [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"],
                    [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                    nil];
    
    NSArray *train = [[NSArray alloc]initWithObjects:@"Tåg",
                      [NSNumber numberWithInt:1],
                      [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                      [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                      nil];
    
    NSArray *boat = [[NSArray alloc]initWithObjects:@"Båt",
                     [NSNumber numberWithInt:1],
                     [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"],
                     [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                     nil];
    
    NSArray *bike = [[NSArray alloc]initWithObjects:@"Cykel",
                     [NSNumber numberWithInt:1],
                     [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                     [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                     nil];
    
    NSArray *motorcycle = [[NSArray alloc]initWithObjects:@"Motorcykel",
                           [NSNumber numberWithInt:1],
                           [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"],
                           [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                           nil];
    
    NSArray *airplane = [[NSArray alloc]initWithObjects:@"Flyg",
                         [NSNumber numberWithInt:1],
                         [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                         [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                         nil];
    
    NSMutableArray *allAnimals = [[NSMutableArray alloc]init];
    
    [allAnimals addObject:car];
    [allAnimals addObject:train];
    [allAnimals addObject:boat];
    [allAnimals addObject:bike];
    [allAnimals addObject:motorcycle];
    [allAnimals addObject:airplane];
    
    return allAnimals;
    
}

@end
