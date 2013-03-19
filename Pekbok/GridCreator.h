//
//  GridCreator.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-18.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridCreator : NSObject
@property (nonatomic, retain) NSMutableArray *categoryNameArray;

-(NSMutableArray*)CreateDefaultObjects: (NSMutableArray*)CategoryNameArray;
//-(NSMutableArray*)CreateDefaultCategories;
//-(UIButton*)CreateImageButtons: (BOOL)isCategory;
-(UIButton*)CreateImageButtons:(BOOL)isCategory arrayTofix:(NSMutableArray*)array isLandscape:(BOOL)isLandscape;
@end


