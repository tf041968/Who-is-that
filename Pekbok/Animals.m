//
//  Creator.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-28.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Animals.h"
#import "Obj+Create.h"
@implementation Animals



//Skapar array med alla  i kategorin djur
+(NSMutableArray *)allAnimals{
    
    //NSURL *catURL = [[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"];
    //NSString *catSound = [catURL absoluteString];
    NSArray *cat = [[NSArray alloc]initWithObjects:@"Katt",
                    [NSNumber numberWithInt:0],
                    [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"],
                    [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                    nil];
    
    
    
    NSArray *fish = [[NSArray alloc]initWithObjects:@"Fisk",
                     [NSNumber numberWithInt:0],
                     [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"],
                     [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                     nil];
    
    
    
    
    
    NSMutableArray *allAnimals = [[NSMutableArray alloc]init];
    
    [allAnimals addObject:cat];
    [allAnimals addObject:fish];
    
    return allAnimals;
    
}

+(void)createAnimals:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context{

    for (int i = 0; i < arrayOfAnimals.count; i++) {
        NSLog(@"skapas i kat-nr: %@",[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]);
//        [Obj createObjects:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:0]
//                inCategory:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]
//                 withImage:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:2]
//    inManagedObjectContext:context
//            soundForObject:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:3]];
    }

}


@end
