//
//  ButtonHelper.m
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import "ButtonHelper.h"

@implementation ButtonHelper

//Skapar en textlabel med tape-bakgrund.
//Tar emot text, storlek, och vilken bild den ska tillhöra. Detta enbart för att kunna positionera den korrekt i förhållande till bilden det åsyftar.
+(UILabel *)createTapeLabel:(NSString *)nameOnLabel fontSize:(float)fontSize forImageButton:(UIButton *)imageButton {
    
    CGSize labelSize = [nameOnLabel sizeWithFont:[UIFont fontWithName:@"LHF Anna Banana" size:fontSize]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake
                      ((imageButton.frame.origin.x+(imageButton.frame.size.width - labelSize.width-(fontSize*2))/2),
                       (imageButton.frame.origin.y + imageButton.frame.size.height),
                       labelSize.width+(fontSize*2),
                       labelSize.height)];
    
    [label setFont:[UIFont fontWithName:@"LHF Anna Banana" size:fontSize]];
    //label.userInteractionEnabled = YES;
    label.tag = imageButton.tag;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tape.png"]];
    label.text = nameOnLabel;
    [label setTextAlignment:NSTextAlignmentCenter];
    
    return label;
}

+(UIButton *)createButtonWithImage:(UIImage *)image tag:(int)tag xCoord:(float)xCoord yCoord:(float)yCoord imageWidth:(float)imageWidth imageHeight:(float)imageHeight{
    
    UIButton *categoryImageButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    categoryImageButton.tag = tag;
    //[categoryImageButton addTarget:self action:@selector(objectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    categoryImageButton.frame = CGRectMake(xCoord,yCoord,imageWidth,imageHeight);
    [categoryImageButton setBackgroundImage:image forState:UIControlStateNormal];
    
    return categoryImageButton;
}

//Skapar bakåtknapp
+(UIButton *)createBackButton:(id)inClass{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.titleLabel.font = [UIFont fontWithName:@"LHF Anna Banana" size:30];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[backButton setBackgroundImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"Tillbaka" forState:UIControlStateNormal];
    backButton.alpha = 0.7;
    backButton.frame = CGRectMake(10, 658, 100, 100);
    [backButton addTarget:inClass action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    return backButton;
}


//MENYKNAPPAR
+(NSMutableArray*)arrayOfMenuButtons{
    
    NSMutableArray *arrayOfOptions = [[NSMutableArray alloc]initWithObjects:
                                      [[NSBundle mainBundle] pathForResource:@"folder" ofType:@"png"],
                                      [[NSBundle mainBundle] pathForResource:@"info" ofType:@"png"],
                                      nil];
    return arrayOfOptions;
    
}


+(UIButton*)menuButton:(NSString*)imageUrl withTitel:(NSString*)title inRect:(CGRect)newFrame inClass:(id)fromClass{
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageWithContentsOfFile:imageUrl] forState:UIControlStateNormal];
    menuButton.frame = newFrame;
    
    [menuButton setTitle:@"Johan" forState:UIControlStateNormal];
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    menuButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    menuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //menuButton.tag = i;
    [menuButton addTarget:fromClass action:@selector(menuButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setAlpha:0.7];
    
    return menuButton;
    
}





@end
