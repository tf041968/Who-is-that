//
//  Alphabet.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-22.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Alphabet.h"

@implementation Alphabet


+(NSMutableArray *)AllLetters{
    
    
    
    //NSURL *catURL = [[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"];
    //NSString *catSound = [catURL absoluteString];
    NSArray *Aa = [[NSArray alloc]initWithObjects:@"Aa",
                   [NSNumber numberWithInt:2],
                   [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"],
                   [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                   nil];
    
    NSArray *Bb = [[NSArray alloc]initWithObjects:@"Bb",
                   [NSNumber numberWithInt:2],
                   [[NSBundle mainBundle] pathForResource:@"b" ofType:@"jpg"],
                   [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                   nil];
    
    NSArray *Cc = [[NSArray alloc]initWithObjects:@"Cc",
                   [NSNumber numberWithInt:2],
                   [[NSBundle mainBundle] pathForResource:@"c" ofType:@"jpg"],
                   [[[NSBundle mainBundle] URLForResource: @"music" withExtension:@"mp3"]absoluteString],
                   nil];
    
    
    
    
    NSMutableArray *allLetters = [[NSMutableArray alloc]init];
    
    [allLetters addObject:Aa];
    [allLetters addObject:Bb];
    [allLetters addObject:Cc];
    
    return allLetters;
    
}

//+(void)createFullAlphabet:(NSMutableArray *)arrayOfletters fromContext:(NSManagedObjectContext *)context{
//    
//    for (int i = 0; i < arrayOfAnimals.count; i++) {
//        NSLog(@"skapas i kat-nr: %@",[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]);
//        [Obj createObjects:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:0]
//                inCategory:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]
//                 withImage:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:2]
//    inManagedObjectContext:context
//            soundForObject:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:3]];
//    }
//    
//}





@end
