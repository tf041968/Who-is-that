//
//  CategoryInfoMenu.m
//  Pekbok
//
//  Created by Johan Persson on 2012-12-16.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "CategoryInfoMenu.h"
#import "CategoryController.h"

@interface CategoryInfoMenu (){
    NSMutableArray *arr;
    UIPopoverController *popoverController;

}

@end

@implementation CategoryInfoMenu
@synthesize checkBtnOutlet;
@synthesize infoTextView;
@synthesize delegate;
@synthesize popoverController;

	
- (IBAction)checkButton:(id)sender {
    [self btnSelected:sender];
    if (checkBtnOutlet.selected == YES) {
        NSLog(@"selected");
    }
else if (checkBtnOutlet.selected == NO){
    NSLog(@"inte selected");
}
}
- (void) btnSelected:(UIButton*)button{
    checkBtnOutlet.selected = !checkBtnOutlet.selected;
}

-(void)loadTextFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    if (filePath) {
        NSString *contentOfFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        infoTextView.text = contentOfFile;
    }

}

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
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    
    //cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_background.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //        Cat *currentCategory = [savedCategories objectAtIndex:indexPath.row];
    //        cell.textLabel.text = currentCategory.name;
    //
    //
    //        Obj *currentObject = [savedObjects objectAtIndex:[indexPath row]];
    //
            cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    return cell; /////EV väck
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        NSLog(@"klasse");
        
    }
    else if (indexPath.row == 1){
        NSLog(@"bosse");
    }
    
    [delegate selectionFromPopover:indexPath.row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTextFile];
    NSLog(@"%f", self.view.frame.size.height);
    NSLog(@"%f", self.view.frame.size.width);
    arr = [[NSMutableArray alloc]initWithObjects:@"Lägg till kategori",@"Hjälp", nil];
       	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
