//
//  ObjectPresentation.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-18.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "ObjectPresentation.h"
#import "FinalViewController.h"
#import "CoreDataHelper.h"
#import "ButtonHelper.h"
#import "ImageHelper.h"
#import "Cat.h"
#import "Obj.h"
#import "EditObjectController.h"
#import "TabBarViewController.h"
@interface ObjectPresentation (){


    int selectedObject;

}


@end

@implementation ObjectPresentation
@synthesize CategoryObjects;
@synthesize categoryNameArray;
@synthesize managedObjectContext;
@synthesize cat;

@synthesize loadedObjects;
@synthesize category;
@synthesize menuButton;
@synthesize savedMenuButtons;
@synthesize imageView;

-(void)PresentObjects{
    
    int upperRowXCord = 80;
    int lowerRowXCord = 80;
    int upperRowYCord = 60;
    int lowerRowYCord = 380;
    double imageHeight = 250.0;
    double imageWidth = imageHeight* 1.2;
    //Loopar alla laddade objekt.
    for (int i = 0; i < loadedObjects.count; i++)
    {
        @autoreleasepool {
            
            
            Obj *object = [loadedObjects objectAtIndex:i];  //Hämtar objektet ur arrayn
            UIImage *bild = [UIImage imageWithContentsOfFile: object.imageThumbUrl]; //Hämtar objektets bild
            double ratio = bild.size.width/bild.size.height;//Räknar ut bildförhållande
            imageHeight = 250.0;                            //Bildens höjd. Const
            imageWidth = imageHeight*ratio;                 //Bildens bredd. Beror på höjd.
            UIButton *knapp = [UIButton buttonWithType:UIButtonTypeCustom]; //Skapar en UIButton
            //Om modolu av arraypositionen = 0. Övre raden.
            if (i%2 == 0)
            {
                knapp = [ButtonHelper createButtonWithImage:bild tag:i xCoord:upperRowXCord yCoord:upperRowYCord imageWidth:imageWidth imageHeight:imageHeight]; //Skapar en knapp med bild och ger den koordinater
                upperRowXCord = upperRowXCord + knapp.frame.size.width + 100; //Ändrar x-coord för att flytta startposition för nästa
            }
            
            //Om modolu av arraypositionen = 1. Nedre raden.
            if (i%2 == 1)
            {
                knapp = [ButtonHelper createButtonWithImage:bild tag:i xCoord:lowerRowXCord yCoord:lowerRowYCord imageWidth:imageWidth imageHeight:imageHeight];
                lowerRowXCord = lowerRowXCord + knapp.frame.size.width + 100;
            }
            [ImageHelper setBorder:knapp];
            
            [knapp addTarget:self action:@selector(objectButtonAction:) forControlEvents:UIControlEventTouchUpInside]; //Kopplar action som ska köras när man klickar på knappen/bilden.
            
            [ImageHelper setShadow:knapp];
            
            [self.scrollView addSubview:knapp]; //Lägger till knapp/bild till scrollViewn
            
            if (![cat.name isEqualToString:@"Alfabetet"]) {
                UILabel *tapelabel = [ButtonHelper createTapeLabel:object.name fontSize:50 forImageButton:knapp]; //Skapar tejplabel m objektnamn och fontstorlek
                
                [self.scrollView addSubview:tapelabel]; //Lägger till tejplabel till scrollviewn.
            }
            //Padding efter sista knappen och skapar en scrollview efter den storleken.
            UIButton *lastButton = (UIButton*)[self.view viewWithTag:loadedObjects.count-1]; //Sista knappen
            UIButton *secondLastButton = (UIButton*)[self.view viewWithTag:loadedObjects.count-2]; //Näst sista knappen
            if (loadedObjects.count > 3) {
                
                
                //Om sista knappens x-pos + bildbredd är mindre än den näst sista
                if (((UIButton*)[self.view viewWithTag:loadedObjects.count-1]).frame.origin.x + ((UIButton*)[self.view viewWithTag:loadedObjects.count-1]).frame.size.width < secondLastButton.frame.origin.x + secondLastButton.frame.size.width)
                {
                    //Padding efter den näst sista bilden (Övre raden)
                    self.scrollView.contentSize = CGSizeMake((secondLastButton.frame.origin.x + secondLastButton.frame.size.height) +100, self.view.frame.size.width);
                }
                else
                {   //Padding efter den sista bilden (Nedre raden)
                    self.scrollView.contentSize = CGSizeMake((lastButton.frame.origin.x + lastButton.frame.size.height) +100, self.view.frame.size.width);
                }
            }
        }
    }
}

//Körs när man 4-klickar
- (IBAction)tapit:(id)sender {
    
    NSMutableArray *arrayOfOptions = [ButtonHelper arrayOfMenuButtons];
    float center = self.view.frame.size.height/2;
    float imgWidth = ([UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:0]].size.height/2);
    float pos = (imgWidth*arrayOfOptions.count)/2;
    float startpos = center-pos;
    
    //OM KNAPPARNA ÄR I ARRAY ÄR NOLL
    if (savedMenuButtons.count == 0) {
        
        //VARJE SYNLIG KNAPP TAS BORT
        for (id object in [self.view subviews]) {
            if ([object isKindOfClass:[UIButton class]]) {
                UIButton *btn = object;
                if (![btn.currentTitle isEqualToString:@"Tillbaka"]) {
                    [object removeFromSuperview];
                }
                
                
            }
        }
        
        //LOOPAR ALLA KNAPPAR I ARRAY
        for (int i = 0; i < arrayOfOptions.count; i++)
        {
            //Knappens position
            CGRect frame = CGRectMake((startpos+i*(imgWidth+25)), 768, [UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:i]].size.height/2, [UIImage imageWithContentsOfFile:[arrayOfOptions objectAtIndex:i]].size.height/2);
            
            //Skapar knappen
            menuButton = [ButtonHelper menuButton:[arrayOfOptions objectAtIndex:i] withTitel:@"titel" inRect:frame inClass:self];
            
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
    [UIView commitAnimations];
}

-(void)hideMenuButtons:(UIButton*)menuBtn{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    menuBtn.frame = CGRectMake(menuBtn.frame.origin.x, 768, [UIImage imageNamed:@"folder.png"].size.height/2, [UIImage imageNamed:@"folder.png"].size.height/2);
    //[textField setFrame:frame];
    [UIView commitAnimations];
}

-(IBAction)menuButtonSelector:(id)sender{
    
    UIButton *knapp = sender;
    if (knapp.tag == 0) {
        [self performSegueWithIdentifier:@"Create Object" sender:self];
    }
    else if (knapp.tag ==1){
    }
    
    for (UIButton *button in savedMenuButtons){
        [self hideMenuButtons:button];
    }
    
    [savedMenuButtons removeAllObjects];
}

//Körs när man klickar på en bild
-(void)objectButtonAction:(id)sender{
    
    selectedObject = [sender tag]; //Sätter klickade knappens tag som selectedObject för att veta vilken bild som ska visas 
    [self performSegueWithIdentifier:@"toFinalPresentation" sender:self]; //Kör segue
}

//Kör segues beroende på input. 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toFinalPresentation"])
    {
        FinalViewController *FP = [segue destinationViewController];
        [FP setSelectedObjectArr:categoryNameArray];
        [FP setCat:cat];
        [FP setSelectedObject:selectedObject];
        [FP setContext:self.managedObjectContext];
        //[FP setFinalObjects:loadedObjects];
    }
    
    if ([segue.identifier isEqualToString:@"Create Object"])
    {
        EditObjectController *editObjCtrl = [segue destinationViewController];
        [editObjCtrl setManagedObjectContext:self.managedObjectContext];
        [editObjCtrl setCat:cat];
        
    }
    
   
    if ([segue.identifier isEqualToString:@"TabBar"])
    {
        TabBarViewController *tabBar = [segue destinationViewController];
        //[editObjCtrl setManagedObjectContext:self.managedObjectContext];
        //[editObjCtrl setCat:cat];
        
    }
    
}

    

- (void)viewDidLoad
{
    [super viewDidLoad];
    savedMenuButtons = [[NSMutableArray alloc]init];
    
    UIImage *bgs = [UIImage imageWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    imageView.image = bgs;
    
    loadedObjects = [CoreDataHelper loadObject:self.managedObjectContext inCategory:cat]; //Laddar kategorins objekt.
    //NotCenter som kör ladda-om-funktion
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadLoadedObjects:)
                                                 name:@"ReloadController" object:nil];
    
    
    //self.scrollView.frame = self.view.frame; //Sätter scrollviewns storlek till fullscreen.
    [self.view addSubview:[ButtonHelper createBackButton:self]]; //Skapar en knapp och lägger till den till vyn.
    [self PresentObjects]; //Placerar ut knapparna
}

-(void)viewWillAppear:(BOOL)animated{

    UIImage *bgs = [UIImage imageWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    imageView.image = bgs;


}



//NotificationCenter - Laddar om objekten när man sparat eller tagit bort ett objekt. 
- (void)reloadLoadedObjects:(NSNotification *)note {
    
    //För varje uiview i scrollvyn
    for (UIView *subview in self.scrollView.subviews)
    {
        [subview removeFromSuperview]; //Tar bort alla subviews
    }
    
    NSLog(@"Received Notification - Someone seems to have logged in");
    loadedObjects = [CoreDataHelper loadObject:self.managedObjectContext inCategory:cat]; //Laddar om alla objekt
    [self PresentObjects]; //Placerar ut objecten efter att ngt tagits bort el. blivit tillagt. 
}

//iOS 5.1 Hindrar rotation vid kategorivisning.
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning
{
   
    [super didReceiveMemoryWarning];

}

- (NSUInteger) supportedInterfaceOrientations
{
    //Because your app is only landscape, your view controller for the view in your
    // popover needs to support only landscape
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}


//KOPIERAR 
//-(BOOL)ko{
//BOOL copySucceeded = NO;
//    
//    // Get our document path.
//    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath = [searchPaths objectAtIndex:0];
//    
//    // Get the full path to our file.
//    NSString *filePath = [documentPath stringByAppendingPathComponent:@"cat.png"];
//    
//    NSLog(@"copyFromBundle - checking for presence of ...");
//    
//    // Get a file manager
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    // Does the database already exist? (If not, copy it from our bundle)
//    if(![fileManager fileExistsAtPath:filePath]) {
//        
//        // Get the bundle location
//        NSString *bundleDBPath = [[NSBundle mainBundle] pathForResource:@"cat.png" ofType:nil];
//        
//        // Copy the DB to our document directory.
//        copySucceeded = [fileManager copyItemAtPath:bundleDBPath
//                                             toPath:filePath
//                                              error:nil];
//        
//        if(!copySucceeded) {
//            NSLog(@"copyFromBundle - Unable to copy  to document directory." );
//        }
//        else {
//            NSLog(@"copyFromBundle - Succesfully copied to document directory." );
//        }
//        
//    }
//    else {
//        NSLog(@"copyFromBundle -  already exists in document directory - ignoring.");
//    }
//    
//    return copySucceeded;
//
//}
//



- (void)backButton {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
