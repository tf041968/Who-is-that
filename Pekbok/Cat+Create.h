//
//  Cat+Create.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-23.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Cat.h"

@interface Cat (Create)
+(Cat *)createCategory:(NSString *)name categoryImage:(NSString *)catImg catergoryID:(NSNumber*)categoryID isDefault:(BOOL)isDefault inManagedContext:(NSManagedObjectContext *)context;
@end
