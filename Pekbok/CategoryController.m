//
//  CategoryController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-26.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "CategoryController.h"
#import "Cat.h"
#import "Cat+Create.h"
#import "PickerControllerSubClass.h"



@interface CategoryController ()

@end


@implementation CategoryController
@synthesize managedObjectContext;
@synthesize tableView =_tableView;
@synthesize selectedRow;
@synthesize categoryTextField;


- (IBAction)catImageButton:(id)sender {
    
    imagePicker = [[PickerControllerSubClass alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [popoverController presentPopoverFromRect:CGRectMake(00.0, 0.0, 150, 150)
                                       inView:sender
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
}


//Laddar kategorier från databasen. 
-(void)onLoad{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cat"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors =  [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    
    savedCategories = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    
    if(savedCategories == nil){
        NSLog(@"error %@", error);
        
    }
    
    if ([savedCategories count] == 0) {
        NSLog(@"Ingen sparad data");
    }
    
    else
    {
        for (int i = 0; i < savedCategories.count; i++)
        {
            //NSManagedObject *obj = [savedCategories objectAtIndex:i];
            //NSString *test = [obj valueForKey:@"name"];
        }
    }
    
}


- (IBAction)closeButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (IBAction)deleteCategory:(id)sender {
//    [self onLoad];
//    for (int i = 0; i < savedCategories.count; i++) {
//        if (cat.isChecked) {
//        [managedObjectContext deleteObject:cat];
//    [self saveCoreData];
//    [self onLoad];
//    [_tableView reloadData];
//    }
//
//    }
//        
//}



- (IBAction)addCategoryButton:(id)sender {
    
    if (![self checkCategoryExist]) {
       //[Cat createCategory:<#(NSString *)#> categoryImage:<#(UIImage *)#> inManagedContext:<#(NSManagedObjectContext *)#>]
         //[Cat createCategory:categoryTextField.text inManagedContext:self.managedObjectContext];
        [self saveCoreData];
        [self onLoad];
        [_tableView reloadData];
        
    }
}

-(BOOL)checkCategoryExist{

    BOOL result = FALSE;
    for (int i = 0; i < savedCategories.count; i++) {
        cat = [savedCategories objectAtIndex:i];
        if ([cat.name caseInsensitiveCompare:categoryTextField.text] ==NSOrderedSame)
        {
            
                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Kategorin finns redan" message:@"Du har redan en kategori med detta namnet, välj ett nytt namn och försök igen" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok!", nil];
                        [alert show];
            categoryTextField.text = @"";
            result = TRUE;
            break;
        }
        result =false;
    }

    return result;
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
    
    cat = [savedCategories objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    if (cat.isChecked.boolValue == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //NSString *color = [_colors objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.name;
    cell.imageView.image = cat.image;
    return cell;
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     [managedObjectContext deleteObject:cat];
     [self saveCoreData];
     [self onLoad];
     [tableView reloadData];
     
     // Delete the row from the data source
     //[managedObjectContext deleteObject:[loadedObjects objectAtIndex:indexPath.row]];
     NSError *error = nil;
     [managedObjectContext save:&error];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadController" object:nil];
     //[self loadObjects];
     //[tableView reloadData];

 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     cat = [savedCategories objectAtIndex:indexPath.row];
    if (cat.isChecked.boolValue == NO)
    {
        cat.isChecked = [NSNumber numberWithBool:YES];
      
    }
    else{
        cat.isChecked = [NSNumber numberWithBool:NO];
    }
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self onLoad];
    [self.tableView reloadData];
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{



}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
	[self onLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
