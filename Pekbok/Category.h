//
//  Category.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-11.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject{
    
    NSString *categoryName;
    BOOL checked;
}

@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) UIImage *categoryImage;
@property BOOL checked;




@end
