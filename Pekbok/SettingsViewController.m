//
//  HelpViewController.m
//  Pekbok
//
//  Created by Johan Persson on 2013-01-15.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController (){

    BOOL isChecked;
    BOOL hideStartUpHelp;
    

}

@end

@implementation SettingsViewController


-(void)startButtonAction:(id)sender{
    
    if (isChecked) {
        [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateSelected];
        [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateHighlighted];
        [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateNormal];
        isChecked = NO;
        hideStartUpHelp = YES;
        
        
    }
    else if (!isChecked){
        NSLog(@"jeööö");
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateSelected];
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateHighlighted];
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateNormal];
        isChecked = YES;
        hideStartUpHelp = NO;
        
    }
        
    //[self saveUserDefaults];
}


-(void)createShowHelpButton{
    
    
    UIView *startupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    startupView.backgroundColor = [UIColor redColor];
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setSelected:YES];
    checkBox.frame = CGRectMake(10, 10, 30, 30);
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateSelected];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateNormal];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateHighlighted];
    
    [checkBox setHighlighted:NO];
    [checkBox addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    isChecked = YES;
    [startupView addSubview:checkBox];
    [self.view addSubview:startupView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createShowHelpButton];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
