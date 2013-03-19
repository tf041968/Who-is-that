//
//  ObjectController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-27.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "ObjectController.h"

@interface ObjectController ()

@end

@implementation ObjectController
@synthesize categoryTable,objectTable;

@synthesize managedObjectContext;

-(void)loadCategoryObjects:(int)selrow{
NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSError *error = nil;
    cat = [savedCategories objectAtIndex:selrow];
    NSFetchRequest *objectRequest = [NSFetchRequest fetchRequestWithEntityName:@"Obj"];
    objectRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    objectRequest.predicate = [NSPredicate predicateWithFormat:@"belongsTo = %@",cat.categoryID];
    savedObjects = [self.managedObjectContext executeFetchRequest:objectRequest error:&error];


}

-(void)onLoad{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cat"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors =  [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    savedCategories = [self.managedObjectContext executeFetchRequest:request error:&error];

    cat = [savedCategories objectAtIndex:0];
        NSFetchRequest *objectRequest = [NSFetchRequest fetchRequestWithEntityName:@"Obj"];
    objectRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    objectRequest.predicate = [NSPredicate predicateWithFormat:@"belongsTo = %@",cat.categoryID];
    savedObjects = [self.managedObjectContext executeFetchRequest:objectRequest error:&error];
    
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
            //NSLog(@"nummer %i %@",i,test);
        }
    }
    
    if(savedObjects == nil){
        NSLog(@"error %@", error);
        
    }
    
    if ([savedObjects count] == 0) {
        NSLog(@"Ingen sparad data");
            }
    else
    {
        for (int i = 0; i < savedObjects.count; i++)
        {
//            NSManagedObject *obj = [savedObjects objectAtIndex:i];
//            NSString *test = [obj valueForKey:@"name"];
//            NSLog(@"object %i %@",i,test);
        }
    }
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return [savedCategories count];
    if (tableView == categoryTable) {
        NSLog(@"Categorytable");
       return [savedCategories count];
    }
    else if (tableView == objectTable){
        NSLog(@"ObjectTable");
        return [savedObjects count];
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    if (tableView == categoryTable)
    {
        Cat *currentCategory = [savedCategories objectAtIndex:indexPath.row];
        cell.textLabel.text = currentCategory.name;
        //        if (currentCategory.checked == TRUE)
        //        {
        //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        }
        //        else
        //        {
        //            cell.accessoryType = UITableViewCellAccessoryNone;
        //        }
        //cell.imageView.image = currentTweet.userImage;
        return cell;
    }
    
    if (tableView == objectTable)
    {
        Obj *currentObject = [savedObjects objectAtIndex:[indexPath row]];
        
        cell.textLabel.text = currentObject.name;
        //        if (currentObject.checked == TRUE)
        //        {
        //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        }
        //        else
        //        {
        //            cell.accessoryType = UITableViewCellAccessoryNone;
        //        }
        //cell.imageView.image = currentTweet.userImage;
        return cell;
    }
    return cell; /////EV väck
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
    if (tableView == categoryTable) {
        [self loadCategoryObjects:indexPath.row];
        [objectTable reloadData];
    }
    
//    cat = [savedCategories objectAtIndex:indexPath.row];
//    if (cat.isChecked.boolValue == NO)
//    {
//        cat.isChecked = [NSNumber numberWithBool:YES];
//        
//    }
//    else{
//        cat.isChecked = [NSNumber numberWithBool:NO];
//    }
//    NSError *error = nil;
//    if (![self.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//    [self onLoad];
//    [self.tableView reloadData];
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
