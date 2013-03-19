//
//  CategoryController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-26.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//
#import "ButtonHelper.h"
#import "CoreDataHelper.h"
#import "AlertHelper.h"
#import "EditCategoryController.h"
#import "Cat.h"
#import "Cat+Create.h"
#import "PickerControllerSubClass.h"



@interface EditCategoryController ()

@end


@implementation EditCategoryController
@synthesize managedObjectContext;
@synthesize tableView =_tableView;
@synthesize selectedRow;
@synthesize categoryTextField;
@synthesize categoryImageButton;
@synthesize BGImageView;
@synthesize imageFromCameraOrRoll;

//iOS 5.1 Hindrar rotation vid kategorivisning.
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

//När man klickar på add image knappen.
- (IBAction)catImageButton:(id)sender {
    
    imagePicker = [[PickerControllerSubClass alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [popoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 150, 150)
                                       inView:sender
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    picker = nil;
    imageFromCameraOrRoll = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        
        CGSize size = [ImageHelper calculateRatioPickerControll:imageFromCameraOrRoll imageSize:@"Category"];
        
        UIImage *resizedImage = [ImageHelper imageWithImage:imageFromCameraOrRoll scaledToSize:size];
        categoryImageButton.frame = CGRectMake(95, 20, resizedImage.size.width, resizedImage.size.height);
        [categoryImageButton setBackgroundImage:resizedImage forState:UIControlStateNormal];
        [self.view addSubview:categoryImageButton];                     //Lägger till knappen med bakgrundsbild.
    }
    
    [popoverController dismissPopoverAnimated:YES];
}

-(void)createImageButton{
    UIImage *photoHolder = [UIImage imageNamed:@"photoHolder.png"];     //Ramen som ligger ovanpå bilden.
    categoryImageButton = [UIButton buttonWithType:UIButtonTypeCustom]; //Initierar knappen som custom
    categoryImageButton.frame = CGRectMake(95,20, 350, 262.5);          //Storlek på knappen som håller ramen.
    [categoryImageButton setBackgroundImage:[UIImage imageNamed:@"photo_camera_blue.png"]forState:UIControlStateNormal];
    [categoryImageButton setImage:photoHolder forState:UIControlStateNormal]; //Sätter bild på knappen.
    
    //Metod som körs när man klickar på knappen.
    [categoryImageButton addTarget:self action:@selector(catImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryImageButton];                         //Lägger till knappen till vyn.
}

///<summary>
/// Laddar kategorier från databasen. 
///</summary>
///<param name></param name>
///<returns> </returns>
-(void)onLoad{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cat"];                      //Hämtar entitet CAT
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]; //Sorterar på namn
    request.sortDescriptors =  [NSArray arrayWithObject:sortDescriptor];                               //Kopplar hämtningsförfrågan till sorteringen
    
    NSError *error = nil;
    
    savedCategories = [self.managedObjectContext executeFetchRequest:request error:&error]; //Hämtar requesten och sparar i en arr.
    
    //Om resultatet är nil
    if(savedCategories == nil){
        NSLog(@"error %@", error);
    }
    
    //Om resultatet är noll
    if ([savedCategories count] == 0) {
        NSLog(@"Ingen sparad data");
    }
    //Om man får tillbaka ett resultat.
    //Behöver inte göra något eftersom jag redan har resultatet i en arr.
    else
    {
        for (int i = 0; i < savedCategories.count; i++)
        {
            //NSManagedObject *obj = [savedCategories objectAtIndex:i];
            //NSString *test = [obj valueForKey:@"name"];
        }
    }
}

//Stänger fönstret.
- (IBAction)closeButton:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Knapp för att lägga till kategorier
- (IBAction)addCategoryButton:(id)sender {
    
    //Kollar om kategorin finns sedan tidigare.
    if (![self checkCategoryExist]) //Om kategorin inte finns.
    {
        int cat_id = 0; //KategoriID
        int cat_temp = 0; //Högsta kategoriID
        //Loopar kategorier
        for (int i = 0; i < savedCategories.count; i++)
        {
            cat = [savedCategories objectAtIndex:i]; //Hämtar kategori
            cat_id = [cat.categoryID intValue]; //Sparar kategorins ID
            if (cat_id > cat_temp) //Om kategorins ID är större än temp_id
            {
                cat_temp = cat_id; //Sätt kategoriID som ny högsta kategoriID
            }
        }
        cat_temp++; //Öka högsta ID med 1
        
        
        
        NSString *imagePath = [ImageHelper imagePathInDocumentsDirectory:categoryTextField.text];
        
        //extracting image from the picker and saving it
        CGSize size = [ImageHelper calculateRatioPickerControll:imageFromCameraOrRoll imageSize:@"Category"];
        UIImage *categoryImage = [ImageHelper imageWithImage:imageFromCameraOrRoll scaledToSize:size];
        imageFromCameraOrRoll = nil;
        [ImageHelper saveImage:categoryImage toPath:imagePath];
        
        //Skapar kategori
        [Cat createCategory:categoryTextField.text
              categoryImage:imagePath
                catergoryID:[NSNumber numberWithInt:cat_temp]
                  isDefault:NO
           inManagedContext:self.managedObjectContext];
        
        [self saveCoreData]; //Sparar till databasen.
        [self onLoad]; //Laddar om databasen
        [_tableView reloadData]; //Laddar om tableviewn.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCategoryController" object:nil]; //Skickar en notifiering
    }
}


///<summary>
/// Kontrollerar om kategorin finns sedan tidigare.
/// Om den finns returneras true annars false.
///</summary>
///<param name></param name>
///<returns> Returnerar true eller false </returns>
-(BOOL)checkCategoryExist{
    
    BOOL result = FALSE;
    //Loopar alla laddade kategorier.
    for (int i = 0; i < savedCategories.count; i++) {
        cat = [savedCategories objectAtIndex:i]; //Hämtar ut specifik kategori
        //Om textfältet är identiskt med kategorin så visas en alert.
        if ([cat.name caseInsensitiveCompare:categoryTextField.text] ==NSOrderedSame)
        {
            UIAlertView *alert = [AlertHelper getAlertMessagefor:@"categoryExist"];            [alert show];
            categoryTextField.text = @""; //Nollställer textfältet.
            result = TRUE; //Sätter bool till true. CheckedCategoryExist.
            break; //Avbryter loopen
        }
        result =false; //Kategorin finns inte sedan tidigare.
    }
    
    return result; //returnerar resultatet.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [savedCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cat = [savedCategories objectAtIndex:indexPath.row]; //Kategorin för vald rad.
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = cat.name;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cat = [savedCategories objectAtIndex:indexPath.row];
    
if ([cat.isDefault boolValue] == YES) {
        UIAlertView *alert = [AlertHelper getAlertMessagefor:@"deleteDefaultCategory"];
        [alert show];
    }
    else{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        cat = [savedCategories objectAtIndex:indexPath.row];
        //Ladda in object och se om några är kopplade till kategorin.
        NSArray *objectsInCategory = [CoreDataHelper loadObject:self.managedObjectContext inCategory:cat];
        if (objectsInCategory.count > 0) {
            UIAlertView *alert = [AlertHelper getAlertMessagefor:@"deleteCategoryWithObjects"];
            [alert show];
            
        }
        else
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            [fileManager removeItemAtPath:cat.imageURL error:&error];
            [managedObjectContext deleteObject:cat]; //Tar bort kategori
            [self saveCoreData]; //Sparar ändringen till databasen
            
            
            [self onLoad]; //Laddar om databasen
            [tableView reloadData]; //Laddar om tableviewn.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCategoryController" object:nil];
            
        }
        // Delete the row from the data source
        //[managedObjectContext deleteObject:[loadedObjects objectAtIndex:indexPath.row]];
        //NSError *error = nil;
        //[managedObjectContext save:&error];
        //Skickar ett meddelande om att man gjort ändringar och att bakgrunden bör laddas om.
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCategoryController" object:nil];
        //[self loadObjects];
        //[tableView reloadData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //Alertview.tag 0 = Du försöker ta bort kategori
    //              1 = Kategorin finns redan.
    if (alertView.tag == 0)
    {
        
        if (buttonIndex == YES)
        {
            // Any action can be performed here
            [managedObjectContext deleteObject:cat]; //Tar bort kategori
            [self saveCoreData]; //Sparar ändringen till databasen
            [self onLoad]; //Laddar om databasen
            [_tableView reloadData]; //Laddar om tableviewn.
            
            // Delete the row from the data source
            //[managedObjectContext deleteObject:[loadedObjects objectAtIndex:indexPath.row]];
            //NSError *error = nil;
            //[managedObjectContext save:&error];
            //Skickar ett meddelande om att man gjort ändringar och att bakgrunden bör laddas om.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCategoryController" object:nil];
            //[self loadObjects];
            //[tableView reloadData];
        }
        else
        {
            // Any action can be performed here
        }
    }
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cat = [savedCategories objectAtIndex:indexPath.row];
    //[categoryImageButton setBackgroundImage:cat.image forState:UIControlStateNormal];
    categoryTextField.text = cat.name;
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"Ta bort";
}


-(void)saveCoreData{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /* keyboard is visible, move views */
    centerPoint = self.view.center;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(centerPoint.x, centerPoint.y-205);
    [UIView commitAnimations];}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(centerPoint.x, centerPoint.y);
    [UIView commitAnimations];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    imageFromCameraOrRoll = nil;
    imagePicker = nil;
    popoverController =nil;
    self.categoryImageButton = nil;
    self.categoryTextField = nil;
    
    //[managedObjectContext reset];
    
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
    _tableView.backgroundView =nil;
    UIImage *bgs = [UIImage imageWithContentsOfFile:[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    BGImageView.image = bgs;
	[self onLoad];
    [self createImageButton];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categoryImageButton:(id)sender {
}
- (void)viewDidUnload {
    [self setBGImageView:nil];
    [super viewDidUnload];
}
@end
