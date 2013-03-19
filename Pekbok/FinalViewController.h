//
//  FinalViewController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-19.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"
#import "AudioPlayer.h"

@interface FinalViewController : UIViewController <UIGestureRecognizerDelegate,UIScrollViewDelegate>{
    NSArray *loadedObjects;
    double xCord;
    Cat *cat;
    AudioPlayer *audio;
    BOOL pageControlUsed;
    Obj *obj;
    int kNumberOfPages;

}
@property (nonatomic) NSMutableArray *selectedObjectArr;
@property int selectedCategory;
@property int selectedObject;
@property (nonatomic) NSManagedObjectContext *context;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapIt;
@property (nonatomic) Cat *cat;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) NSArray *loadedObjects;
@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;


@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@end
