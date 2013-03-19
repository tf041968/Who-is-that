//
//  ObjectController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-27.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"
#import "Obj.h"
@interface ObjectController : UIViewController <UITableViewDataSource, UITableViewDelegate>{

    NSArray *savedCategories;
    NSArray *savedObjects;
    Cat *cat;
    Obj *obj;

}

@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
@property (weak, nonatomic) IBOutlet UITableView *objectTable;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
