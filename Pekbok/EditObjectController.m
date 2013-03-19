//
//  EditObjectControllerViewController.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-28.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "EditObjectController.h"
#import "CoreDataHelper.h"
#import "AlertHelper.h"
#import "Obj+Create.h"
#import "Obj.h"
#import "PickerControllerSubClass.h"

@interface NonRotatingUIImagePickerController : UIImagePickerController
@end
//Fixar så att man inte behöver ha portrait-mode
@implementation NonRotatingUIImagePickerController

- (BOOL)shouldAutorotate
{
    return NO;
}

@end

@interface EditObjectController (){

    CGPoint centerPoint;


}


@end

@implementation EditObjectController
@synthesize tableView = _tableView;
@synthesize managedObjectContext;
@synthesize cat;
@synthesize imageButton;
@synthesize record,stop,play;
@synthesize objectNameField;
@synthesize BGImageView;
@synthesize recButton;
@synthesize listenButton;

//iOS 5.1 Hindrar rotation vid kategorivisning.
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}


- (IBAction)saveObject:(id)sender {
    UIAlertView *alert;
    //Om man bild, ljud och namn inte är tomt eller nil
    if (!(imageFromCameraOrRoll == nil) && !(recorder.url == nil) && !(objectNameField.text == nil))
    {
        alert = [AlertHelper getAlertMessagefor:@"addedObject"];
        //LJUD
        NSURL *urlOfRecording = recorder.url; //Urlen till ljudfilen
        NSString *urla = [urlOfRecording absoluteString]; //Gör om urlen till en absolute sträng
        
        //RESIZEAR VALD BILD TILL OBJEKTSTORLEK
        CGSize thumbNailSize = [ImageHelper calculateRatioPickerControll:imageFromCameraOrRoll imageSize:@"Object"];
        UIImage *thumbNail = [ImageHelper imageWithImage:imageFromCameraOrRoll scaledToSize:thumbNailSize];
        
        //HÄMTAR DOCDIR OCH SPARAR BILD TILL DISK
        NSString *thumbSizeImagePath = [ImageHelper imagePathInDocumentsDirectory:[objectNameField.text stringByAppendingString:@"thumb"]];
        [ImageHelper saveImage:thumbNail toPath:thumbSizeImagePath];
        
        //RESIZEAR VALD BILD TILL FINALVIEW-STORLEK
        CGSize fullSize = [ImageHelper calculateRatioPickerControll:imageFromCameraOrRoll imageSize:@"FinalView"];
        UIImage *fullImage = [ImageHelper imageWithImage:imageFromCameraOrRoll scaledToSize:fullSize];
        
        //SPARAR FULLSIZE TILL DISK
        NSString *fullSizeImagePath = [ImageHelper imagePathInDocumentsDirectory:[objectNameField.text stringByAppendingString:@"full"]];
        [ImageHelper saveImage:fullImage toPath:fullSizeImagePath];
        
        //SKAPAR OBJEKT
        [Obj createObjects:objectNameField.text
                inCategory:cat.categoryID
              withThumbURL:thumbSizeImagePath
           withFullSizeURL:fullSizeImagePath
                 isDefault:NO
    inManagedObjectContext:managedObjectContext
            soundForObject:urla];
        
        //SPARAR OBJEKTET
        NSError *error = nil;
        if (![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [imageButton setBackgroundImage:nil forState:UIControlStateNormal]; //Tar bort bakgrundsbilden
        [self loadObjects]; //Laddar om objekten
        [_tableView reloadData]; //Laddar om tableviewn
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadController" object:nil]; //Skickar en notifiering
    }
    //Om bild,ljud eller namn är tom
    else
    {
        //Felmeddelande
        alert = [AlertHelper getAlertMessagefor:@"addedObjectError"];
    }
    [alert show];
}

- (IBAction)textFieldAction:(id)sender {
    record.enabled = YES;
}

#pragma mark - Audio Player


//Ljudinspedaren har spelat klart
-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [listenButton setBackgroundImage:[UIImage imageNamed:@"headphones.png"] forState:UIControlStateNormal];
    record.enabled = YES; //Gör inspelning möjlig
    stop.enabled = NO; //Gör stopp omöjlig
}

//Felhanterare
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

//Inspelning slutförd
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
    NSLog(@"Lyckades spela in");
}
//Felhanterare
-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

//Stoppar inspelningen
- (IBAction)stop:(id)sender {
    
    if (recorder.recording)
    {
        [recorder stop];
    } else if (player.playing) {
        [player stop];
    }
}


//Spelar upp inspelat ljud
- (IBAction)play:(id)sender {
    
    
    [player prepareToPlay];
    if (recorder.url == Nil) {
        UIAlertView *alert = [AlertHelper getAlertMessagefor:@"noAudioRecorded"];
        [alert show];
    }
    else
    {
        if (!recorder.recording)
        {
            [listenButton setBackgroundImage:[UIImage imageNamed:@"rec_headphones.png"] forState:UIControlStateNormal];
            stop.enabled = YES;
            record.enabled = NO;
            
            
            NSError *error;
            
            player = [[AVAudioPlayer alloc]
                      initWithContentsOfURL:recorder.url
                      error:&error];
            
            player.delegate = self;
            Obj *obj = nil;
            obj.sound = recorder.url;
            if (error)
                NSLog(@"Error: %@",
                      [error localizedDescription]);
            else
                [player play];
        }
        
    }
}

-(void)setListenState{
    
    
    
    [listenButton setBackgroundImage:[UIImage imageNamed:@"headphones.png"] forState:UIControlStateNormal];
    
    
    
}

//Startar inspelning
- (IBAction)record:(id)sender {
    
    
    if (recorder.recording) {
        NSLog(@"spelar in %c",recorder.recording);
        [record setTitle:@"Spela in" forState:UIControlStateNormal];
        [recorder stop];
        [recButton setBackgroundImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
    }
    else
    {
        [recButton setBackgroundImage:[UIImage imageNamed:@"rec_microphone.png"] forState:UIControlStateNormal];
        //SÖKVÄG TILL DOCDIR
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(
                                                                NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *soundFilePath = [docsDir
                                   stringByAppendingPathComponent:[objectNameField.text stringByAppendingString:@".caf"]];
        soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        //INST. FÖR LJUDFIL
        NSDictionary *recordSettings = [NSDictionary
                                        dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                        AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16],
                                        AVEncoderBitRateKey,
                                        [NSNumber numberWithInt: 2],
                                        AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0],
                                        AVSampleRateKey,
                                        nil];
        
        //SPELAR IN
        NSError *error = nil;
        recorder = [[AVAudioRecorder alloc]
                    initWithURL:soundFileURL
                    settings:recordSettings
                    error:&error];
        recorder.delegate = self;
        [record setTitle:@"Stop" forState:UIControlStateNormal];
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
        }
        else
        {
            [recorder prepareToRecord];
        }
        [recorder record];
    }
    
    
}

//Knapp för objektbild
- (IBAction)objectImageButton:(id)sender {
    imagePicker = [[PickerControllerSubClass alloc] init];
    //[myPopoverController setContentViewController:imagePicker animated:YES];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [popoverController presentPopoverFromRect:CGRectMake(0.0, 200.0, 150, 150)
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
        
        
        //CGSize size = CGSizeMake(300, 250);
        CGSize size = [ImageHelper calculateRatioPickerControll:imageFromCameraOrRoll imageSize:@"Category"];
        
        UIImage *resizedImage = [ImageHelper imageWithImage:imageFromCameraOrRoll scaledToSize:size];
        imageButton.frame = CGRectMake(400, 26, resizedImage.size.width, resizedImage.size.height);
        [imageButton setBackgroundImage:resizedImage forState:UIControlStateNormal];
        [self.view addSubview:imageButton]; //Lägger till knappen med bakgrundsbild.
    }
    [popoverController dismissPopoverAnimated:YES];
    //[imageButton setBackgroundImage:imageFromCameraOrRoll forState:UIControlStateNormal];
    
    
}



//Tells the delegate that the user cancelled the pick operation.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
}

- (IBAction)closeTabButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    // [self dismissViewControllerAnimated:YES completion:nil];
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
    return loadedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Obj *obj = [loadedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = obj.name;
    cell.imageView.image = [UIImage imageWithContentsOfFile:obj.imageThumbUrl];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_background.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell; /////EV väck
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Obj *objToDel = [loadedObjects objectAtIndex:indexPath.row];
    if ([objToDel.isDefault boolValue] == YES) {
        NSLog(@"får inte ta bort");
        UIAlertView *alert = [AlertHelper getAlertMessagefor:@"deleteDefaultObject"];
        [alert show];
    }
    else{
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            NSError *error = nil;
            // Delete the row from the data source
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:objToDel.imageThumbUrl error:&error];
            [fileManager removeItemAtPath:objToDel.imageFullUrl error:&error];
            [managedObjectContext deleteObject:objToDel];
            
            [managedObjectContext save:&error];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadController" object:nil];
            [self loadObjects];
            [tableView reloadData];
        }
        else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }}
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cat = [loadedObjects objectAtIndex:indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"Ta bort";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadObjects
{
    loadedObjects = [CoreDataHelper loadObject:self.managedObjectContext inCategory:cat];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgs = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BGBlue" ofType:@"png"]]; //[[ImageHelper arrayOfBGs] objectAtIndex:arc4random() % 4]];
    BGImageView.image = bgs;
    [self loadObjects];
    [self setBGImageView:nil];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidBegin:(UITextField *)sender { centerPoint = self.view.center;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(centerPoint.x, centerPoint.y-305);
    [UIView commitAnimations];
}
- (IBAction)textFieldDidEnd:(UITextField *)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(centerPoint.x, centerPoint.y);
    [UIView commitAnimations];


}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /* keyboard is visible, move views */
   }

-(void)textFieldDidEndEditing:(UITextField *)textField{
    

}



- (void)viewDidUnload {
    [self setBGImageView:nil];
    [self setListenButton:nil];
    [self setRecButton:nil];
    [super viewDidUnload];
}
@end
