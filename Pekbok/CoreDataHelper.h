//
//  CoreDataHelper.h
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
@interface CoreDataHelper : NSObject
+(NSArray *)loadCategory:(NSManagedObjectContext *)context;
+(NSArray *)loadObject:(NSManagedObjectContext *)context inCategory:(Cat *)categoryID;
+(void)createObjects:(int)categoryID fromContext:(NSManagedObjectContext *)context;

@end
