//
//  ViewController.h
//  SoundRecord
//
//  Created by Admin on 01/07/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    NSURL *temporaryRecFile,*trimFilePath;
    
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    
    //time duration
    NSDate *recordStartTime,*recordStopTime;
    BOOL recordFlag,lowerFlag,upperFlag,stopFlag,trimFlag;
    NSMutableArray *arrTimeSlot,*arrAudioPath,*arrFinalSlots,*arrCurrentSlotTime,*arrLowerLimit,*arrUpperLimit,*arrLaps;
    int slotCounter;
    IBOutlet UILabel *stopwatchLabel;
    IBOutlet UIButton *btnLapReset;
    IBOutlet UIButton *btnPlay;
}

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
- (IBAction)playTrimmedAudio:(id)sender;
- (IBAction)stopAudio:(id)sender;
- (IBAction)trimAudio:(id)sender;
- (IBAction)saveDurationAction:(id)sender;
- (IBAction)showClipList:(id)sender;
- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
- (IBAction)onLapPressed:(id)sender;


@end