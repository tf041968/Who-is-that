//
//  Helper.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-27.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
@interface ImageHelper : NSObject

//+(void)tapit:(UINavigationController *)navCtrl;
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
+(CGSize)calculateRatioPickerControll:(UIImage *)imageToCheck imageSize:(NSString *)forUse;

+(void)createAnimals:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context;

+(NSMutableArray *)arrayOfBGs;
+(UIView*)setShadow:(UIView*)setShadowTo;
+(UIView*)setBorder:(UIView*)setBorderTo;
+(NSString *)imagePathInDocumentsDirectory:(NSString *)imageName;
+(void)saveImage:(UIImage*)image toPath:(NSString *)path;


@end
