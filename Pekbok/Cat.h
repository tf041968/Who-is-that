//
//  Cat.h
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Obj;

@interface Cat : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * isDefault;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *holds;
@end

@interface Cat (CoreDataGeneratedAccessors)

- (void)addHoldsObject:(Obj *)value;
- (void)removeHoldsObject:(Obj *)value;
- (void)addHolds:(NSSet *)values;
- (void)removeHolds:(NSSet *)values;

@end
