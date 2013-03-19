//
//  CategoryInfoMenu.h
//  Pekbok
//
//  Created by Johan Persson on 2012-12-16.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyPopoverDelegate
-(void) selectionFromPopover:(int)number;
@end


@interface CategoryInfoMenu : UITableViewController{
    
    __weak id <MyPopoverDelegate> delegate;
    NSMutableArray *languageData;
    
}
@property (nonatomic, weak) id <MyPopoverDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *checkBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (retain, nonatomic) UIPopoverController *popoverController;
@end
