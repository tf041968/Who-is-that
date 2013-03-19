//
//  PickerControllerSubClass.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-20.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "PickerControllerSubClass.h"

@interface PickerControllerSubClass ()

@end

@implementation PickerControllerSubClass
//Hindrar från autorotate när man väljer bild. 
- (BOOL)shouldAutorotate
{
    return NO;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
