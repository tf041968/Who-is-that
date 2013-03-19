//
//  EditObjectControllerViewController.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-28.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageHelper.h"
#import "Cat.h"
@interface EditObjectController : UIViewController<UIPickerViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSArray *loadedObjects;
    UIImagePickerController *imagePicker;
    UIPopoverController *popoverController;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSURL *tempRecFile;
    UIImage *imageFromCameraOrRoll;
    NSURL *soundFileURL;
    NSString *saveFilePath;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Cat *cat;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (retain, nonatomic) IBOutlet UIButton *record;
@property (retain, nonatomic) IBOutlet UIButton *stop;
@property (retain, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UITextField *objectNameField;
@property (strong, nonatomic) IBOutlet UIImageView *BGImageView;
@property (strong, nonatomic) IBOutlet UIButton *recButton;

@property (strong, nonatomic) IBOutlet UIButton *listenButton;
@end
