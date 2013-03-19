//
//  Obj+Create.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-23.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Obj.h"

@interface Obj (Create)



+(Obj *)createObjects:(NSString*)name inCategory:(NSNumber *)categoryID withThumbURL:(NSString *)imageURL  withFullSizeURL:(NSString *)fullImage isDefault:(BOOL)isDefault inManagedObjectContext:(NSManagedObjectContext *)context soundForObject:(NSString *)soundURL;
+(void)CreateObjectsFromArray:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context;

@end
