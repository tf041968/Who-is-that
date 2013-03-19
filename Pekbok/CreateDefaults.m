//
//  CreateDefaults.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-22.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "CreateDefaults.h"
#import "Categories.h"
#import "Cat+Create.h"
#import "Obj+Create.h"
#import "Animals.h"
#import "Alphabet.h"
#import "Vehichles.h"
#import "Numbers.h"

@implementation CreateDefaults


+(void)CreateDefaultCategories:(NSManagedObjectContext*)context{
    NSArray *arrayOfDefaultCategories = [Categories allCategories]; //Hämtar array med alla kategorier
    
    //Loopar array med kategorier
    for (int i = 0; i < arrayOfDefaultCategories.count; i++)
    {
        
        //Skapar kategori
        [Cat createCategory:[[arrayOfDefaultCategories objectAtIndex:i]objectAtIndex:0] categoryImage:[[arrayOfDefaultCategories objectAtIndex:i]objectAtIndex:1] catergoryID:[[arrayOfDefaultCategories objectAtIndex:i]objectAtIndex:2]
            isDefault:YES
           inManagedContext:context];
        //[self saveCoreData:context];
        //[Helper createObjects:i fromContext:context];
        
        // [Cat createCategory:[[arrayOfDefaultCategories objectAtIndex:i]objectAtIndex:0]
        //     categoryImage:[[arrayOfDefaultCategories objectAtIndex:i]objectAtIndex:1]
        //inManagedContext:context];
        
    }
}

+(void)saveCoreData:(NSManagedObjectContext *)context{
    NSError *error = nil;
    if (![context save:&error])
    {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}




+(void)CreateDefaultObjects:(NSManagedObjectContext*)context{
    NSMutableArray *arrayOfAllObjects = [[NSMutableArray alloc]initWithObjects:
                                         [Animals allAnimals],
                                         [Vehichles allAnimals],
                                         [Alphabet AllLetters],
                                         //[Numbers AllNumbers],
                                         nil];
    
    for (int i = 0; i < arrayOfAllObjects.count; i++) {
        NSMutableArray *temp = [arrayOfAllObjects objectAtIndex:i];
        NSLog(@"första %i", temp.count );
        for (int j = 0; j < [[arrayOfAllObjects objectAtIndex:i]count]; j++) {
            NSMutableArray *tempar = [arrayOfAllObjects objectAtIndex:i];
            NSLog(@"andra %i", tempar.count);
            NSLog(@"%@", [[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]);
            [Obj createObjects:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:0]
                    inCategory:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:1]
                  withThumbURL:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:2]
              withFullSizeURL:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:2]
             isDefault:YES
        inManagedObjectContext:context soundForObject:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:3]];
        }
         //[Obj CreateObjectsFromArray:[arrayOfAllObjects objectAtIndex:i] fromContext:context];
    }
  
    //    for (int i = 0 ; i < arrayOfAllObjects.count; i++) {
    //        if (i == categoryID) {
    //            NSMutableArray *temp_arr = [arrayOfAllObjects objectAtIndex:i];
    //            NSLog(@"antal objek i temp_arr %i", temp_arr.count);
    //
    //            [Obj CreateObjectsFromArray:temp_arr fromContext:context];
    //
    //            //            NSLog(@"test %@", [arrayOfAllObjects objectAtIndex:i]);
    //            //            for (int j = 0; j < [[arrayOfAllObjects objectAtIndex:i]count]; j++) {
    //            //                NSLog(@"test %@", [[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]);
    //            //                NSLog(@"test %@", [[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]);
    //            //                [[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:0]
    //            //
    //            //            }
    //            //
    //            //NSLog(@"jojoj %@", )
    //            //            for (int j = 0; j < [[arrayOfAllObjects objectAtIndex:i]count]; j++) {
    //            //                [Obj createObjects:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:0]
    //            //                        inCategory:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:1]
    //            //                         withImage:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:2] inManagedObjectContext:context
    //            //                    soundForObject:[[[arrayOfAllObjects objectAtIndex:i]objectAtIndex:j]objectAtIndex:3]];
    //            //            }
    //
    //            //[arrayOfAllObjects objectAtIndex:i];
    //        }
    //    }
    //
    
}

@end
