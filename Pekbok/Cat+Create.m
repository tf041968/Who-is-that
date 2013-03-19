//
//  Cat+Create.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-23.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Cat+Create.h"


@implementation Cat (Create)


+(Cat *)createCategory:(NSString *)name categoryImage:(NSString *)catImg catergoryID:(NSNumber*)categoryID isDefault:(BOOL)isDefault inManagedContext:(NSManagedObjectContext *)context
{
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cat"];
//    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    NSError *error = nil;
//    NSArray *matches = [context executeFetchRequest:request error:&error];
//    NSLog(@"antal träffar i array %i", matches.count);
    
    NSError *error;
    Cat *cat = nil;
    
    cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat" inManagedObjectContext:context];
    cat.name = name;
    cat.isDefault = [NSNumber numberWithBool:isDefault];
    cat.categoryID = categoryID;
    cat.imageURL = catImg;
    [context save:&error];
    //[context refreshObject:cat mergeChanges:YES];
    return cat;

}
@end
