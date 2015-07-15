//
//  ViewController.m
//  SoundRecord
//
//  Created by Admin on 01/07/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "ClipListTableVC.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button

@end

@implementation ViewController
@synthesize recorder;

- (void)viewDidLoad
{
    arrTimeSlot = [[NSMutableArray alloc] init];
    arrAudioPath = [[NSMutableArray alloc] init];
    arrFinalSlots = [[NSMutableArray alloc] init];
    arrCurrentSlotTime = [[NSMutableArray alloc] init];
    arrLowerLimit = [[NSMutableArray alloc] init];
    arrUpperLimit = [[NSMutableArray alloc] init];
    slotCounter = 0;
    
    //disable buttons
    _stopButton.enabled = NO;
    _recordButton.enabled = YES;
    btnPlay.enabled = NO;
    btnLapReset.enabled = NO;
    
    /*
    [super viewDidLoad];
    _playButton.enabled = NO;
    _stopButton.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
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
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL settings:recordSettings error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
    }
     */
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [audioSession setActive:YES error:nil];
    
    [recorder setDelegate:self];
    
    [super viewDidLoad];
}
/*
- (IBAction)recordAudio:(id)sender {
    if (!_audioRecorder.recording)
    {
        _playButton.enabled = NO;
        _stopButton.enabled = YES;
        [_audioRecorder record];
    }
}

- (IBAction)playAudio:(id)sender {
    if (!_audioRecorder.recording)
    {
        _stopButton.enabled = YES;
        _recordButton.enabled = NO;
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioRecorder.url error:&error];
        
        _audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [_audioPlayer play];
    }
}

- (IBAction)stopAudio:(id)sender {
    _stopButton.enabled = NO;
    _playButton.enabled = YES;
    _recordButton.enabled = YES;
    
    if (_audioRecorder.recording)
    {
        [_audioRecorder stop];
    } else if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}

*/
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
//    _recordButton.enabled = YES;
//    _stopButton.enabled = NO;
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark Save Last Recorded File
- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

- (BOOL) startAudioSession
{
    // Prepare the audio session
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if (![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
    {
        NSLog(@"Error setting session category: %@", error.localizedFailureReason);
        return NO;
    }
    
    
    if (![session setActive:YES error:&error])
    {
        NSLog(@"Error activating audio session: %@", error.localizedFailureReason);
        return NO;
    }
    
    return session.inputIsAvailable;
}


- (BOOL) record
{
    NSError *error;
    
    // Recording settings
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:  [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    
    // File URL
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
    
    // Create recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (!recorder)
    {
        NSLog(@"Error establishing recorder: %@", error.localizedFailureReason);
        return NO;
    }
    
    // Initialize degate, metering, etc.
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    //self.title = @"0:00";
    
    if (![recorder prepareToRecord])
    {
        NSLog(@"Error: Prepare to record failed");
        //[self say:@"Error while preparing recording"];
        return NO;
    }
    
    if (![recorder record])
    {
        NSLog(@"Error: Record failed");
        //  [self say:@"Error while attempting to record audio"];
        return NO;
    }
    
    // Set a timer to monitor levels, current time
    //timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    
    return YES;
}

-(void)play
{
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[self recordingFolder]])
    {
        
        arrayListOfRecordSound=[[NSMutableArray alloc]initWithArray:[fileManager  contentsOfDirectoryAtPath:documentPath_ error:nil]];
        
        NSLog(@"====%@",arrayListOfRecordSound);
        
    }
    
    NSString  *selectedSound =  [documentPath_ stringByAppendingPathComponent:[arrayListOfRecordSound objectAtIndex:0]];
    
    NSURL   *url =[NSURL fileURLWithPath:selectedSound];
    
    //Start playback
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!player)
    {
        NSLog(@"Error establishing player for %@: %@", recorder.url, error.localizedFailureReason);
        return;
    }
    
    player.delegate = self;
    
    // Change audio session for playback
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error])
    {
        NSLog(@"Error updating audio session: %@", error.localizedFailureReason);
        return;
    }
    
    self.title = @"Playing back recording...";
    
    [player prepareToPlay];
    [player play];
    
    
}
*/

#pragma mark Updated Code
- (IBAction) record
{
    if (recordFlag)
    {
        [self onStopPressed:nil];
        [self stopAudio:nil];
    }
    else
    {
        [self onStartPressed:nil];
        _stopButton.enabled = YES;
        btnLapReset.enabled = YES;
        _playButton.enabled = NO;
        //_recordButton.enabled = NO;
        
        //clear array data
        [arrTimeSlot removeAllObjects];
        [arrLowerLimit removeAllObjects];
        [arrUpperLimit removeAllObjects];
        [arrAudioPath removeAllObjects];
        
        //change button image
        [_recordButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        
        NSError *error;
        //Try saving in .m4a format
        
        //get recording Start Date
        recordFlag = true;
        recordStartTime = [NSDate date];
        NSLog(@"record start date = %@",recordStartTime);
        
        // Recording settings
        /*
         NSMutableDictionary *settings = [NSMutableDictionary dictionary];
         
         [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
         [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
         [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
         [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
         [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
         [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
         [settings setValue: [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
         */
        
        NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                        [NSNumber numberWithFloat:16000.0], AVSampleRateKey,
                                        [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                        nil];
        NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath_ = [searchPaths objectAtIndex: 0];
        
        NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
        
        // File URL
        NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
        
        
        //Save recording path to preferences
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        
        [prefs setURL:url forKey:@"Test1"];
        [prefs synchronize];
        
        
        // Create recorder
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
        
        [recorder prepareToRecord];
        
        [recorder record];
    }
   
}

-(IBAction)playBack
{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [audioSession setActive:YES error:nil];
    
    
    //Load recording path from preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    temporaryRecFile = [prefs URLForKey:@"Test1"];
    
    //get audio details
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:temporaryRecFile options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    NSLog(@"duration sec = %f",audioDurationSeconds);
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:temporaryRecFile error:nil];
    
    
    
    player.delegate = self;
    
    [player setNumberOfLoops:0];
    player.volume = 1;
    
    [player prepareToPlay];
    
    [player play];
}


- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".m4a"]; //.aif
}

- (IBAction)stopAudio:(id)sender
{
    //new 2 button conditions
    [_recordButton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    recordFlag = false;
    
    _stopButton.enabled = NO;
    _playButton.enabled = YES;
    _recordButton.enabled = YES;
    btnPlay.enabled = YES;
    
    if (!stopFlag)
    {
        //get stop timestamp
        recordFlag = false;
        recordStopTime = [NSDate date];
        NSLog(@"record stop time = %@",recordStopTime);
        
        //calculate total time duration of audio clip
        NSTimeInterval totalDuration = [recordStopTime timeIntervalSinceDate:recordStartTime];
        NSLog(@"Total Time in Seconds = %f",totalDuration);
        
        //calculate number of clips to be saved according to save this duration button
        NSLog(@"Number of clips = %lu",(unsigned long)[arrTimeSlot count]);
        
        
        
        if (recorder.recording)
        {
            [recorder stop];
        } else if (player.playing) {
            [player stop];
        }
    }
   
    
    //define clip time limit variables
   // float lowerLimit = 0.0,upperLimit = 0.0,timeDiff;
    float timeDiff;
   // NSMutableArray *tempArrTimeSlot = [arrTimeSlot mutableCopy];
    //trim audio for all the time slots
    int i;
    for (i=0; i < arrTimeSlot.count; i++)
    {
        //set lowerlimit
        //get time difference between recording start and 1st lap time
        //lowerLimit = [arrTimeSlot[i] timeIntervalSinceDate:recordStartTime];'
        int intCount = arrTimeSlot.count - 1;
        if (i == intCount)
        {
            timeDiff = [recordStopTime timeIntervalSinceDate:arrTimeSlot[i]];
        }
        else
        {
            timeDiff = [arrTimeSlot[i+1] timeIntervalSinceDate:arrTimeSlot[i]];
        }
        //apply condition for last lap
        if (i == intCount)
        {
            [self addLimitInArray:slotCounter];
            i=0;
            slotCounter = 0;
            stopFlag = true;
            trimFlag = false;
            //return;
        }
        else
        {
            if (timeDiff < 5)
            {
                slotCounter++;
                //[arrCurrentSlotTime addObject:[NSNumber numberWithFloat:timeDiff]];
            }
            else
            {
                //add clip data in array
                [self addLimitInArray:slotCounter];
                i=0;
                slotCounter = 0;
                stopFlag = true;
                trimFlag = false;
                [self stopAudio:nil];
                
                //break;
                return;
            }
            NSLog(@"counter = %d",slotCounter);
        }
        
        //set upperlimit
        trimFlag = true;
    }
    
    //call trim method
    if (trimFlag)
    {
        [self trimAudio:arrLowerLimit :arrUpperLimit];
    }
    
    
}

-(void)addLimitInArray:(int)count
{
    float newClipStart = [arrTimeSlot[0] timeIntervalSinceDate:recordStartTime] - 5;
    if (newClipStart < 0)
    {
        newClipStart = 0;
    }
    float newClipEnd = [arrTimeSlot[count] timeIntervalSinceDate:recordStartTime] + 5;
    
    //compare end time and totaltime
    NSTimeInterval totalDuration = [recordStopTime timeIntervalSinceDate:recordStartTime];
    if (newClipEnd > totalDuration)
    {
        newClipEnd = totalDuration;
    }
    [arrLowerLimit addObject:[NSNumber numberWithFloat:newClipStart]];
    [arrUpperLimit addObject:[NSNumber numberWithFloat:newClipEnd]];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int k =0; k<=slotCounter; k++)
    {
        [tempArr addObject:arrTimeSlot[k]];
    }
    [arrTimeSlot removeObjectsInArray:tempArr];
}

- (IBAction)trimAudio:(id)sender
{
//    BOOL flag = [self trimAudio];
//    if (flag)
//    {
//        NSLog(@"Trim Success");
//    }
}

- (IBAction)saveDurationAction:(id)sender
{
    if (!stopFlag)
    {
        NSDate *currentTimestamp = [NSDate date];
        NSLog(@"Clip time = %@",currentTimestamp);
        [arrTimeSlot addObject:currentTimestamp];
    }
}

- (IBAction)showClipList:(id)sender
{
    
}

//- (BOOL)trimAudio : (float)lowerLimit :(float)UpperLimit : (int)serialNumber
- (BOOL)trimAudio : (NSArray *)lowerArray :(NSArray *)UpperArray
{
    for (int i = 0 ; i < lowerArray.count; i++)
    {
        float vocalStartMarker = [lowerArray[i] floatValue];
        float vocalEndMarker = [UpperArray[i] floatValue];
        //get recordeed file from local DB
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        temporaryRecFile = [prefs URLForKey:@"Test1"];
        
        NSURL *audioFileInput = temporaryRecFile;
        
        //set trimmed file URL
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"ddMMMYY_hhmmssa"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryCachesDirectory = [paths objectAtIndex:0];
        NSString *OutputFilePath = [libraryCachesDirectory stringByAppendingFormat:@"/output_%@(%d).m4a", [dateFormatter stringFromDate:[NSDate date]],i+1];
        NSURL *audioFileOutput = [NSURL fileURLWithPath:OutputFilePath];
        
        NSLog(@"location of clip %d = %@",i,audioFileOutput);
        [arrAudioPath addObject:audioFileOutput];
        
        trimFilePath = audioFileOutput;
        
        if (!audioFileInput || !audioFileOutput)
        {
            return NO;
        }
        
        [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
        AVAsset *asset = [AVAsset assetWithURL:audioFileInput];
        
        AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
        
        if (exportSession == nil)
        {
            return NO;
        }
        
        CMTime startTime = CMTimeMake((int)(floor(vocalStartMarker * 100)), 100);
        CMTime stopTime = CMTimeMake((int)(ceil(vocalEndMarker * 100)), 100);
        CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(startTime, stopTime);
        
        exportSession.outputURL = audioFileOutput;
        exportSession.outputFileType = AVFileTypeAppleM4A;
        exportSession.timeRange = exportTimeRange;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^
         {
             if (AVAssetExportSessionStatusCompleted == exportSession.status)
             {
                 // It worked!
             }
             else if (AVAssetExportSessionStatusFailed == exportSession.status)
             {
                 // It failed...
             }
         }];
    }
    
    

    
    return YES;
}


- (IBAction)playTrimmedAudio:(id)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    //Load recording path from preferences
    
    //get audio details
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:trimFilePath options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    NSLog(@"duration sec = %f",audioDurationSeconds);
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:trimFilePath error:nil];
    
    player.delegate = self;
    
    [player setNumberOfLoops:0];
    player.volume = 1;
    
    [player prepareToPlay];
    
    [player play];
}


#pragma mark Stop Watch Methods


- (IBAction)onStartPressed:(id)sender
{
    self.startDate = [NSDate date];
    
    //change lap button title
    //btnLapReset.titleLabel.text = @" LAP ";
    //[btnLapReset setTitle:@"LAP" forState:UIControlStateNormal];
    [btnLapReset setImage:[UIImage imageNamed:@"lap.png"] forState:UIControlStateNormal];
    
    // Create the stop watch timer that fires every 10 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    stopwatchLabel.text = timeString;
}

- (IBAction)onStopPressed:(id)sender
{
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    
    [self updateTimer];
    
    //change lap button title
    
    //CGSize stringsize = [@"RESET" sizeWithFont:[UIFont systemFontOfSize:15]];
    //[btnLapReset setFrame:CGRectMake(10,0,stringsize.width, stringsize.height)];
    //[btnLapReset setTitle:@"RESET" forState:UIControlStateNormal];
    [btnLapReset setImage:[UIImage imageNamed:@"reset.png"] forState:UIControlStateNormal];
    //btnLapReset.titleLabel.text = @"RESET";
    //[btnLapReset sizeToFit];
}

- (IBAction)onLapPressed:(id)sender
{
//    if (!arrLaps) {
//        arrLaps = [NSMutableArray array];
//    }
//    [arrLaps addObject:[NSDate date]];
//    [self updateTimer];
    
    // if we have a timer, we want to take a lap
    if (self.stopWatchTimer)
    {
        if (!arrLaps)
        {
            arrLaps = [NSMutableArray array];
        }
        [arrLaps addObject:[NSDate date]];
        
        [self updateTimer];
        
        
    }
    
    // there is no timer, so we want to reset
    else {
        //reset timer label
        stopwatchLabel.text = @"00:00:00.000";
        
        //disable buttons
        _stopButton.enabled = NO;
        _playButton.enabled = NO;
        _recordButton.enabled = YES;
        btnPlay.enabled = NO;
        btnLapReset.enabled = NO;
        
        self.startDate = nil;
        //[self updateTimer];
        
        // delete all laps
        arrLaps = nil;
        stopFlag = false;
    }
    //change lap button title
    //btnLapReset.titleLabel.text = @"LAP";
    [btnLapReset setImage:[UIImage imageNamed:@"lap.png"] forState:UIControlStateNormal];
    //CGSize stringsize = [@"LAP" sizeWithFont:[UIFont systemFontOfSize:15]];
    //[btnLapReset setFrame:CGRectMake(10,0,stringsize.width, stringsize.height)];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ClipListIdentifier"])
    {
        ClipListTableVC *vc = [segue destinationViewController];
        vc.arrTableData = arrAudioPath;
        vc.tempName = @"abs";
    }
}
@end
