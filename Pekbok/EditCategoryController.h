//
//  CategoryController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-26.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"
#import "ImageHelper.h"

@interface EditCategoryController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate>{

    NSArray *savedCategories;
    NSArray *savedObjects;
    Cat *cat;
    UIImagePickerController *imagePicker;
    UIPopoverController *popoverController;
    //UIImage *imageFromCameraOrRoll;
    CGPoint centerPoint;
}


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) int selectedRow;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryImageButton;
@property (strong, nonatomic) IBOutlet UIImageView *BGImageView;
@property (strong, nonatomic) UIImage *imageFromCameraOrRoll;
@end
