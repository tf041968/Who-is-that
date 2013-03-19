//
//  CategoryController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-26.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"

@interface CategoryController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    NSArray *savedCategories;
    NSArray *savedObjects;
    Cat *cat;
    UIImagePickerController *imagePicker;
    UIPopoverController *popoverController;

}


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) int selectedRow;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@end
