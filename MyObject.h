//
//  CategoryObject.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-12.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject{
    
    NSString *name;
    UIImage *userImage;
    BOOL checked;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *userImage;
@property BOOL checked;



@end
