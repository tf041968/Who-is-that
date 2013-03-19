//
//  ObjectPresentation.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-18.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"
#import "PopoverMenu.h"

@interface ObjectPresentation : UIViewController<UIGestureRecognizerDelegate, UIScrollViewDelegate>{
   
    //NSArray *loadedObjects;
}
@property (nonatomic, retain) Cat *category;
@property (nonatomic) int CategoryObjects;
@property (nonatomic, retain) NSMutableArray *categoryNameArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Cat *cat;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSArray *loadedObjects;
@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) NSMutableArray *savedMenuButtons;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
