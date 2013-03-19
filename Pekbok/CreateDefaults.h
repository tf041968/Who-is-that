//
//  CreateDefaults.h
//  Pekbok
//
//  Created by Johan Persson on 2012-12-22.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateDefaults : NSObject

+(void)CreateDefaultCategories:(NSManagedObjectContext*)context;
+(void)CreateDefaultObjects:(NSManagedObjectContext*)context;

@end
