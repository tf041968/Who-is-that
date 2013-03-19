//
//  AudioPlayer.h
//  Pekbok
//
//  Created by Johan Persson on 2012-10-29.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : AVAudioPlayer <AVAudioPlayerDelegate, AVAudioRecorderDelegate>{

    AVAudioPlayer *audioPlayer;
    double setVolume;
}
-(void)playSound:(NSString *)sound;
-(void)stopSound;


@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
+(AudioPlayer*)audioPlayerClass;

@end
