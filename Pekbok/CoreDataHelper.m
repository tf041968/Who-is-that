//
//  CoreDataHelper.m
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import "CoreDataHelper.h"
#import "Alphabet.h"
#import "Animals.h"
#import "Vehichles.h"
#import "CreateDefaults.h"
@implementation CoreDataHelper

//Laddar kategorier från core data
+(NSArray *)loadCategory:(NSManagedObjectContext *)context{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"categoryID" ascending:YES];
    NSError *error = nil;
    
    NSFetchRequest *objectRequest = [NSFetchRequest fetchRequestWithEntityName:@"Cat"];
    objectRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray *loadedCategories = [context executeFetchRequest:objectRequest error:&error];
    
    if(loadedCategories == nil){
        NSLog(@"error %@", error);
        
    }
    
    if ([loadedCategories count] == 0) {
        NSLog(@"Ingen sparad data");
        
        [self saveCoreData:context];
    }
    else
    {
        
    }
    
    return loadedCategories;
    
}

//Laddar objekt från core data
+(NSArray *)loadObject:(NSManagedObjectContext *)context inCategory:(Cat *)categoryID{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"imageThumbUrl" ascending:YES];
    NSError *error = nil;
    
    NSFetchRequest *objectRequest = [NSFetchRequest fetchRequestWithEntityName:@"Obj"];
    objectRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    objectRequest.predicate = [NSPredicate predicateWithFormat:@"belongsTo = %@",categoryID];
    
    NSArray *savedObjects = [context executeFetchRequest:objectRequest error:&error];
    
    return savedObjects;
}

//Skapar objekt
+(void)createObjects:(int)categoryID fromContext:(NSManagedObjectContext *)context {
    
    NSMutableArray *arrayOfAllObjects = [[NSMutableArray alloc]initWithObjects:[Animals allAnimals], [Vehichles allAnimals],[Alphabet AllLetters], nil];
    
    for (int i = 0 ; i < arrayOfAllObjects.count; i++) {
        if (i == categoryID) {
            NSMutableArray *temp_arr = [arrayOfAllObjects objectAtIndex:i];
            NSLog(@"antal objek i temp_arr %i", temp_arr.count);
            
            [Obj CreateObjectsFromArray:temp_arr fromContext:context];
            
        }
    }
}

//Sparar till core data
+(void)saveCoreData:(NSManagedObjectContext *)context{
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}





@end
