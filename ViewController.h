//
//  ViewController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-11.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ScrollViewSubClass.h"
#import "Cat+Create.h"
#import "Categories.h"

@interface ViewController : UIViewController<NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>{
    UIButton * categoryImageButton;
    NSArray *savedCategories;
    Cat *category;
    
}
@property (nonatomic, weak) UIImage *bild;
@property (nonatomic, retain) UIButton *categoryImageButton;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *MyImageView;


@property (nonatomic) float screenSize;
@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) NSMutableArray *savedMenuButtons;

@end
