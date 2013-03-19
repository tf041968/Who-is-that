//
//  Creator.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-28.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Obj+Create.h"
@interface Animals : NSObject{


    Obj *obj;

}

+(NSMutableArray *)allAnimals;
+(void)createAnimals:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context;

@end
