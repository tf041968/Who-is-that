//
//  Obj.h
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cat;

@interface Obj : NSManagedObject

@property (nonatomic, retain) NSString * imageFullUrl;
@property (nonatomic, retain) NSString * imageThumbUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id sound;
@property (nonatomic, retain) NSNumber * isDefault;
@property (nonatomic, retain) Cat *belongsTo;

@end
