//
//  ButtonHelper.h
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonHelper : NSObject

+(UILabel *)createTapeLabel:(NSString *)nameOnLabel fontSize:(float)fontSize forImageButton:(UIButton *)imageButton;
+(UIButton *)createButtonWithImage:(UIImage *)image tag:(int)tag xCoord:(float)xCoord yCoord:(float)yCoord imageWidth:(float)imageWidth imageHeight:(float)imageHeight;
+(UIButton *)createBackButton:(id)inClass;

+(NSMutableArray*)arrayOfMenuButtons;
+(UIButton*)menuButton:(NSString*)imageUrl withTitel:(NSString*)title inRect:(CGRect)newFrame inClass:(id)fromClass;

@end
