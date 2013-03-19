//
//  AudioPlayer.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-29.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer
@synthesize audioPlayer;


static AudioPlayer *audioPlayerClass = nil;


+(AudioPlayer*)audioPlayerClass{
    
    if (!audioPlayerClass) {
        audioPlayerClass = [[super allocWithZone:NULL] init];
    }
    return audioPlayerClass;
}

+(id)allocWithZone:(NSZone *)zone{
    
    return [self audioPlayerClass];
}

-(id)init{
    if (audioPlayerClass)
        return audioPlayerClass;
    self =[super init];
    setVolume = 0.5;
    return self;
}


-(void)stopSound{
    if (audioPlayer.play) {
    [audioPlayer stop];
    }

}


-(void)playSound:(NSString *)sound{
    if (audioPlayer.playing) {
        [self stopSound];
    }
    else if (!sound == 0) {
        
        NSLog(@"tttt%@",sound);
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:sound] error:NULL];
    audioPlayer.volume = 1;
    //audioPlayer.numberOfLoops = -1;
        [audioPlayer prepareToPlay];
        [audioPlayer play];}



}

@end
