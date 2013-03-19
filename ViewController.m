//
//  ViewController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-11.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataHelper.h"
#import "ButtonHelper.h"
#import "ObjectPresentation.h"
#import "Cat.h"
#import "Cat+Create.h"
#import "Obj+Create.h"
#import "EditCategoryController.h"
#import "ImageHelper.h"
#import "Categories.h"
#import "CreateDefaults.h"
#import "TabBarViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){
    int selectedCategory;
    NSMutableArray *buttonArray;
    UILabel *CategoryLabels;
     BOOL isChecked;
    BOOL hideStartUpHelp;
    bool menuIsVisible;
}

@end

@implementation ViewController{}

@synthesize categoryImageButton;
//@synthesize myController;
@synthesize screenSize;
@synthesize managedObjectContext;
@synthesize menuButton;
@synthesize savedMenuButtons;
@synthesize MyImageView;

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CategoryController"]) {
        
        EditCategoryController *catContr = [segue destinationViewController];
        [catContr setManagedObjectContext:self.managedObjectContext];
    }
    
        
    if ([segue.identifier isEqualToString:@"toObjectPresentation"]) {
        ObjectPresentation *objPres = [segue destinationViewController];
        
        objPres.managedObjectContext = self.managedObjectContext;
        Cat *cat = nil;
        //Loopar kategorierna
        for (int i = 0; i < savedCategories.count; i++) {
            cat = [savedCategories objectAtIndex:i];        //Hämtar ut kategorin

            //Om loopad kategorID är lika med vald kategori
            if ([cat.categoryID intValue] == selectedCategory)
            {

                break; //När man hittat kategorin så breakar man fär att spara den.
            }
        }
        [objPres setCat:cat]; //Skickar kategorin vidare.
        
    }
    if ([segue.identifier isEqualToString:@"Help"])
    {
        //TabBarViewController *tabBar = [segue destinationViewController];
        //popoverControll = [(UIStoryboardPopoverSegue *)segue popoverController];
        //        myController = [segue destinationViewController];
        //        [myController setFromCategory:@"Kategorihanterare"];
        //        UIStoryboardPopoverSegue *popoverSegue  = (UIStoryboardPopoverSegue*)segue;
        //        [myController setPopoverController:[popoverSegue popoverController]];
        //        myController.delegate = self;
    }
}

#pragma mark - Core Data
-(void)saveCoreData{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
       
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
}


 


-(void)saveUserDefaults{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    [defaults setBool:YES forKey:@"hideHelp"];
    
    [defaults synchronize];

}

-(BOOL)loadUserDefaults{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    hideStartUpHelp = [defaults boolForKey:@"hideHelp"];
    
    return hideStartUpHelp;
}




- (IBAction)tapit:(id)sender {
      
    NSMutableArray *arrayOfOptions = [ButtonHelper arrayOfMenuButtons];
    float center = 1024/2;
    float imgWidth = ([UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:0]].size.height/2);
    float pos = (imgWidth*arrayOfOptions.count)/2;
    float startpos = center-pos;
    
    //OM ARRAY INTE HAR NÅGRA KNAPPAR
    if (savedMenuButtons.count == 0) {
        
        //VARJE SYNLIG KNAPP TAS BORT
        for (id object in [self.view subviews]) {
            if ([object isKindOfClass:[UIButton class]]) {
                [object removeFromSuperview];
            }
        }
        
        //LOOPAR ALLA KNAPPAR I ARRAY
        for (int i = 0; i < arrayOfOptions.count; i++)
        {
            //Knappens position
            CGRect frame = CGRectMake((startpos+i*(imgWidth+25)), 768, [UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:i]].size.height/2, [UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:i]].size.height/2);
            
            //Skapar knappen
            menuButton = [ButtonHelper menuButton:[arrayOfOptions objectAtIndex:i] withTitel:@"titel" inRect:frame inClass:self];
            menuButton.tag = i;
            //Lägger till knapper i en arr och viewn. 
            [savedMenuButtons addObject:menuButton];
            [self.view addSubview:menuButton];
            [self showMenuButtons:menuButton];
            
        }
          
    }
    
    //OM ARRAY INNEHÅLLER KNAPPAR - DVS KNAPPARNA ÄR SYNLIGA
    else
    {
        
        for (int i = 0; i < savedMenuButtons.count; i++) {
            [self hideMenuButtons:[savedMenuButtons objectAtIndex:i]];
            
        }
        [savedMenuButtons removeAllObjects];
        
        
    }
    
    
}


-(void)showMenuButtons:(UIButton*)menuBtn{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    menuBtn.frame = CGRectMake(menuBtn.frame.origin.x, 668, [UIImage imageNamed:@"folder.png"].size.height/2, [UIImage imageNamed:@"folder.png"].size.height/2);
    //[textField setFrame:frame];
    menuIsVisible = true;
    [UIView commitAnimations];
}

-(void)hideMenuButtons:(UIButton*)menuBtn{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    menuBtn.frame = CGRectMake(menuBtn.frame.origin.x, 768, [UIImage imageNamed:@"folder.png"].size.height/2, [UIImage imageNamed:@"folder.png"].size.height/2);
    //[textField setFrame:frame];
    menuIsVisible = false;
    [UIView commitAnimations];
}



-(IBAction)menuButtonSelector:(id)sender{

    UIButton *knapp = sender;
    if (knapp.tag == 0) {
        [self performSegueWithIdentifier:@"CategoryController" sender:self];
       
        
    }
    else if (knapp.tag ==1){
        [self performSegueWithIdentifier:@"Help" sender:self];
        
    }
    
    for (UIButton *button in savedMenuButtons){
        [self hideMenuButtons:button];
    }
    
    [savedMenuButtons removeAllObjects];
}



#pragma mark - Button creation
//Placerar ut bildknapparna
-(void)PlaceButtonsOnScreen{
    
    float imageHeight = 290;
    float imageWidth = imageHeight*1.25;
    
    int upperRowXCord = 80;
    int lowerRowXCord = 80;
    int upperRowYCord = 50;
    int lowerRowYCord = 400;
    
    for (int i = 0; i < savedCategories.count; i++) {
       
        Cat *cat = [savedCategories objectAtIndex:i]; //Hämtar kategorin
        categoryImageButton = [UIButton buttonWithType:UIButtonTypeCustom]; //Allokerar knappen.
        
        UIImage *bild = [UIImage imageWithContentsOfFile: cat.imageURL];      //Hämtar kategoribild
        double ratio = bild.size.width/bild.size.height;//Räknar ut bildförhållande
        imageHeight = 250.0;                            //Bildens höjd. Const
        imageWidth = imageHeight*ratio;                 //Bildens bredd. Beror på höjd.
        if (i%2 == 0)
        {
            categoryImageButton = [ButtonHelper createButtonWithImage:bild tag:[cat.categoryID intValue] xCoord:upperRowXCord yCoord:upperRowYCord imageWidth:imageWidth imageHeight:imageHeight];
            upperRowXCord = upperRowXCord + imageWidth + 100;
        }
        
        if (i%2 == 1)
        {
            categoryImageButton = [ButtonHelper createButtonWithImage:bild tag:[cat.categoryID intValue] xCoord:lowerRowXCord yCoord:lowerRowYCord imageWidth:imageWidth imageHeight:imageHeight];
            lowerRowXCord = lowerRowXCord + categoryImageButton.frame.size.width + 100;
        }

        [ImageHelper setBorder:categoryImageButton];
        [categoryImageButton addTarget:self action:@selector(objectButtonAction:) forControlEvents:UIControlEventTouchUpInside]; //Kopplar action som ska köras när man klickar på knappen/bilden.
        [ImageHelper setShadow:categoryImageButton];
        
        [self.scrollView addSubview:categoryImageButton]; //Lägger till knapp/bild till scrollViewn
        
        // SKAPAR TAPELABEL
        UILabel *tapelabel = [ButtonHelper createTapeLabel:cat.name fontSize:50 forImageButton:categoryImageButton]; //Skapar tejplabel m objektnamn och fontstorlek
        
        [ImageHelper setShadow:tapelabel];
        [self.scrollView addSubview:tapelabel]; //Lägger till tejplabel till scrollviewn.
        
        
        //Padding efter sista knappen och skapar en scrollview efter den storleken.
        UIButton *lastButton = (UIButton*)[self.view viewWithTag:savedCategories.count-1]; //Sista knappen
        UIButton *secondLastButton = (UIButton*)[self.view viewWithTag:savedCategories.count-2]; //Näst sista knappen
        if (savedCategories.count > 2)
        {
            
            //Om sista knappens x-pos + bildbredd är mindre än den näst sista
            if (lastButton.frame.origin.x + lastButton.frame.size.width < secondLastButton.frame.origin.x + secondLastButton.frame.size.width)
            {
                //Padding efter den näst sista bilden (Övre raden)
                self.scrollView.contentSize = CGSizeMake((secondLastButton.frame.origin.x + secondLastButton.frame.size.width) +100, screenSize);
                
            }
            else
            {   //Padding efter den sista bilden (Nedre raden)
                self.scrollView.contentSize = CGSizeMake((lastButton.frame.origin.x + lastButton.frame.size.width) +100, screenSize);
            }
        }
    }
}

-(void)objectButtonAction:(id)sender{
    selectedCategory = [sender tag];
    //NSLog(@"sender tag %i", [sender tag]);
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"toObjectPresentation" sender:self];
}


-(void)showStartupHelp{
    
    float viewSize = 450;
    UIView *startupView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.height/2)-(viewSize/2), (self.view.frame.size.width/2)-(viewSize/2), viewSize, viewSize)];
    startupView.backgroundColor = [UIColor blackColor];
    startupView.alpha = 0.7;
    startupView.layer.cornerRadius = 5;
    startupView.layer.masksToBounds = YES;
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setSelected:YES];
    checkBox.frame = CGRectMake(10, 10, 30, 30);
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateSelected];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateNormal];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateHighlighted];

    [checkBox setHighlighted:NO];
    [checkBox addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    isChecked = YES;
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(30, 30, 100, 75);
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setTitle:@"Stäng" forState:UIControlStateNormal];
    [startupView addSubview:closeButton];
    [startupView addSubview:checkBox];
    [self.view addSubview:startupView];
}

-(void)startButtonAction:(id)sender{

    if (isChecked) {
         [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateSelected];
        [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateHighlighted];
             [sender setBackgroundImage:[UIImage imageNamed:@"un_checked.png"] forState:UIControlStateNormal];
        isChecked = NO;
        hideStartUpHelp = YES;
        
        
    }
    else if (!isChecked){
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateSelected];
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateHighlighted];
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_checked.png"] forState:UIControlStateNormal];
        isChecked = YES;
        hideStartUpHelp = NO;
        
    }
    
    [self saveUserDefaults];
}

-(void)changeUserDefaults:(NSNotification *)notification{

    NSDictionary* userInfo = [notification userInfo];
    int messageTotal = [[userInfo objectForKey:@"message"] intValue];
    hideStartUpHelp = messageTotal;
                           
}



#pragma mark - Load functions
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSData *data = [NSData dataWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    

    
    
    //    UIImage *bgs = [UIImage imageWithContentsOfFile:[[Helper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    MyImageView.image = [UIImage imageWithData:data];
    
    if (![self loadUserDefaults]) {
        [self showStartupHelp];
    }
    
    savedCategories = [CoreDataHelper loadCategory:self.managedObjectContext];
    savedMenuButtons = [[NSMutableArray alloc]init];
    if (savedCategories.count == 0) {
        
        [CreateDefaults CreateDefaultCategories:self.managedObjectContext];
        [CreateDefaults CreateDefaultObjects:self.managedObjectContext];
    }
    [self PlaceButtonsOnScreen];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadLoadedCategories:)
                                                 name:@"ReloadCategoryController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeUserDefaults:)
                                                 name:@"UserDefaults" object:nil];

    screenSize = self.view.frame.size.width;
    if (screenSize != 768) {
        screenSize = 768;
    }
    
  
}

-(void)viewWillAppear:(BOOL)animated{

    savedCategories = [CoreDataHelper loadCategory:self.managedObjectContext];
    NSData *data = [NSData dataWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    MyImageView.image = [UIImage imageWithData:data];
    
}


-(void)viewWillDisappear:(BOOL)animated{



}
-(void)viewDidDisappear:(BOOL)animated{   }


-(void)reloadLoadedCategories:(NSNotification *)note{
    for (UIView *subview in self.scrollView.subviews)
    {
        [subview removeFromSuperview]; //Tar bort alla subviews
    }
    savedCategories = nil;
    savedCategories = [CoreDataHelper loadCategory:self.managedObjectContext];
        [self PlaceButtonsOnScreen];
}

#pragma mark - Rotation controll
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    NSLog(@"ViewController getting dealloced");
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setMyImageView:nil];
    savedCategories = nil;
    [super viewDidUnload];
}
@end
