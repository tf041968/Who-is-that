//
//  Categories.m
//  Pekbok
//
//  Created by Johan Persson on 2012-11-03.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Categories.h"
#import "Cat+Create.h"
@implementation Categories

+(NSMutableArray *)allCategories{
    
    NSArray *djur = [[NSArray alloc]initWithObjects:@"Djur",
                     [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                     [NSNumber numberWithInt:0],
                     nil];
    
    NSArray *fordon = [[NSArray alloc]initWithObjects:@"Fordon",
                       [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                       [NSNumber numberWithInt:1],
                       nil];
    
    NSArray *alphabet = [[NSArray alloc]initWithObjects:@"Alfabetet",
                         [[NSBundle mainBundle] pathForResource:@"user" ofType:@"jpg"],
                         [NSNumber numberWithInt:2],
                         nil];
    
//    NSArray *numbers = [[NSArray alloc]initWithObjects:@"Siffror",
//                        [[NSBundle mainBundle] pathForResource:@"CatImgNumbers" ofType:@"jpg"],
//                        [NSNumber numberWithInt:3],
//                        nil];
    
    NSMutableArray *allCategories = [[NSMutableArray alloc]init];
    
    [allCategories addObject:djur];
    [allCategories addObject:fordon];
    [allCategories addObject:alphabet];
    //[allCategories addObject:numbers];
    return allCategories;
    
}


@end
