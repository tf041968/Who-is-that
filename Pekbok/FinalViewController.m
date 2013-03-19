//
//  FinalViewController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-19.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "FinalViewController.h"
#import "CoreDataHelper.h"
#import "ButtonHelper.h"
#import "Obj.h"
#import "ImageHelper.h"
#import "AudioPlayer.h"

@interface FinalViewController ()

@end

@implementation FinalViewController
@synthesize selectedCategory,selectedObject,selectedObjectArr;
@synthesize scrollView;
@synthesize context;
@synthesize tapIt;
@synthesize cat;
@synthesize loadedObjects;
@synthesize imageView =_imageView;

//När man klickar på en bild.
- (IBAction)tappedScreen:(id)sender {
    obj = [loadedObjects objectAtIndex:[sender tag]]; //Hämtar objekt som klickas
    
    [audio playSound:obj.sound]; //Spelar ljudet
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [audio stopSound];
    
}


//Skapar en scrollview med knappar
-(void)objectImageSlider{
    loadedObjects = [CoreDataHelper loadObject:self.context inCategory:cat]; //Hämtar objekt i cat
    
    //Loopar alla objekt i cat
    for (int i = 0; i < loadedObjects.count; i++)
    {
        obj = [loadedObjects objectAtIndex:i]; //Hämtar objekt på i:s position
        
        CGRect frame; //Skapar en ram
        frame.origin.x = self.scrollView.frame.size.width * i; //Sätter x-kord till scrollvyns bredd * i:s nummer
        frame.origin.y = 0; //Y ska alltid vara =
        //Skapar en rect med x&y-kord samt storlek
        frame = CGRectMake(
                           (self.scrollView.frame.size.width*i)+((self.scrollView.frame.size.width-self.scrollView.frame.size.width*0.8)/2),
                           ((self.scrollView.frame.size.height-self.scrollView.frame.size.height*0.8)/2)-50,
                           self.scrollView.frame.size.width*0.8,
                           self.scrollView.frame.size.height*0.8);
        
        //frame.size = self.scrollView.frame.size;
        
        //Skapar knapp
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageView setFrame:frame]; //Sätter knappens storlek.
        imageView.tag = i; //Ger knappen ett tag-ID
        imageView.adjustsImageWhenHighlighted = NO; //För att knappen inte ska blinka
        [imageView addTarget:self action:@selector(tappedScreen:) forControlEvents:UIControlEventTouchDown]; //Event som körs vid klick.
        [imageView setBackgroundImage:[UIImage imageWithContentsOfFile:obj.imageFullUrl] forState:UIControlStateNormal]; //BG-bild
        
        
        [ImageHelper setBorder:imageView];
        [ImageHelper setShadow:imageView];
        
        //Om kategorinamnet inte är "Alfabetet"
        if (![cat.name isEqualToString:@"Alfabetet"])
        {
            [self.scrollView addSubview:[ButtonHelper createTapeLabel:obj.name fontSize:100 forImageButton:imageView]]; //Skapar en label med namn och lägger till den till knappvyn
        }
        
        //Flyttar scrollview så att klickad knapp är i fokus.
        [self.scrollView setContentOffset:CGPointMake((self.scrollView.frame.size.width * selectedObject), 0) animated:NO]; //Frame size * position i arr. Kan animeras
        
        
        [self.scrollView addSubview:imageView]; //Lägger till knapp
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * loadedObjects.count, self.scrollView.frame.size.height); //Sätter storlek på scrollvyn
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [audio stopSound];
}

//iOS 5.1 Hindrar rotation vid kategorivisning.
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgs = [UIImage imageWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    _imageView.image = bgs;
    CGRect tet = CGRectMake(0, 0, 1024, 768);
    self.scrollView.frame = tet; //Sätter scrollvyns storlek som skärmens.
    [self objectImageSlider];
    [self.view addSubview:scrollView];
    [self.view addSubview:[ButtonHelper createBackButton:self]]; //Skapar en knapp och lägger till den till vyn.
    
    audio = [[AudioPlayer alloc]init];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButton {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}
@end
