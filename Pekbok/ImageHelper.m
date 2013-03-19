//
//  Helper.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-27.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "ImageHelper.h"
#import "Cat.h"
#import "Animals.h"
#import "Cat+Create.h"
#import "Obj+Create.h"
#import "Categories.h"
#import "Alphabet.h"
#import "Vehichles.h"
#import "CreateDefaults.h"

@implementation ImageHelper

//Skalar om bilder
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//Räknar ut ratio och sätter storlek
+(CGSize)calculateRatioPickerControll:(UIImage *)imageToCheck imageSize:(NSString *)forUse{
    
    float ratio = imageToCheck.size.width/imageToCheck.size.height; //Ta fram bildratio
    CGSize rect;
    float height = 0;
    float width = 0;
    //Om bilden är liggande
    if (ratio > 1.0)
    {
        if ([forUse isEqualToString:@"Category"]) {
            width =350;
            height = width/ratio;
        }
        else if ([forUse isEqualToString:@"Object"]) {
            width =350;
            height = width/ratio;
        }
        else if ([forUse isEqualToString:@"FinalView"]) {
            width =800;
            height = width/ratio;
        }
        else if ([forUse isEqualToString:@"ThumbNail"]) {
            width =80;
            height = width/ratio;
        }
    }
        else if (ratio < 1.0)
        {
            if ([forUse isEqualToString:@"Category"]) {
                NSLog(@"category");
                height = 262.5;
                width = height*ratio;
            }
            else if ([forUse isEqualToString:@"Object"]) {
                NSLog(@"category");
                width =262.5;
                height = width*ratio;
            }
            else if ([forUse isEqualToString:@"FinalView"]) {
                NSLog(@"category");
                width =600;
                height = width*ratio;
            }
            else if ([forUse isEqualToString:@"ThumbNail"]) {
                width =80;
                height = width/ratio;
            }
        }
        rect = CGSizeMake(width, height);
    
    return rect;
}




+(void)createAnimals:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context{
    //Cat *cat = nil;
    for (int i = 0; i < arrayOfAnimals.count; i++)
    {
        //        [Obj createObjects:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:0]
        //                inCategory:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]
        //                 withImage:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:2] inManagedObjectContext:context
        //            soundForObject:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:3]];
    }
    
}


+(NSMutableArray *)arrayOfBGs{
    NSMutableArray *bgArr = [[NSMutableArray alloc]initWithObjects:
                             [[NSBundle mainBundle] pathForResource:@"BGGreen" ofType:@"png"],
                             [[NSBundle mainBundle] pathForResource:@"BGRed" ofType:@"png"],
                             [[NSBundle mainBundle] pathForResource:@"BGBlue" ofType:@"png"],
                             [[NSBundle mainBundle] pathForResource:@"BGPurple" ofType:@"png"], nil];
    
    return bgArr;
}

+(UIView*)setShadow:(UIView*)setShadowTo{
    
    setShadowTo.layer.shadowColor = [UIColor grayColor].CGColor;
    setShadowTo.layer.shadowOpacity = 0.4;
    setShadowTo.layer.shadowRadius = 5;
    setShadowTo.layer.shadowOffset = CGSizeMake(3.0f,3.0f);
    
    return setShadowTo;
}

+(UIView*)setBorder:(UIView*)setBorderTo{
    
    setBorderTo.layer.borderWidth = 5.0f;
    setBorderTo.layer.borderColor = [UIColor whiteColor].CGColor;
    
    return setBorderTo;
}


+(void)saveImage:(UIImage*)image toPath:(NSString *)path{
    NSLog(@"path %@,", path);
    NSData *webData = UIImagePNGRepresentation(image);
    [webData writeToFile:path atomically:YES];
}

+(NSString *)imagePathInDocumentsDirectory:(NSString *)imageName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[imageName stringByAppendingString:@".png"]];
    
    return imagePath;
}



@end
