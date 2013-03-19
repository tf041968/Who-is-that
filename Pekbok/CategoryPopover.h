//
//  EditCategoryController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-24.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopoverDelegate
- (void)PopoverSelectedItem:(NSString *)selectedRowContent;
@end



@interface CategoryPopover : UITableViewController{

    NSMutableArray *_EditOptions;
    __weak id<PopoverDelegate> _delegate;
}

// Declare a property for the delegate
@property (nonatomic, retain) NSMutableArray *EditOptions;
@property (nonatomic, weak) id<PopoverDelegate> delegate;
@end
