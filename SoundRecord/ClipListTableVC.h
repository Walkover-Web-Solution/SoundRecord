//
//  ClipListTableVC.h
//  SoundRecord
//
//  Created by Kadamb on 7/6/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ClipListTableVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AVAudioPlayer *player;
}
@property (strong, nonatomic) NSMutableArray *arrTableData;
@property (strong, nonatomic) NSString *tempName;

@end
