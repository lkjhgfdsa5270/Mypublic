//
//  MusicPlayManage.m
//  Music
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayManage.h"

@interface MusicPlayManage ()
{
    BOOL isPlaying;
}
@property(nonatomic,weak)NSTimer * timer;


@end


static AVPlayer * avPlayer = nil;
@implementation MusicPlayManage

+ (instancetype)shareInstrace{
    static MusicPlayManage * musicPlayManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayManage = [[MusicPlayManage alloc]init];
        avPlayer = [[AVPlayer alloc]init];
    });
    return musicPlayManage;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(musicDidFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}


- (void)setAVPlayerWithUrl:(NSString *)url{
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
    [avPlayer replaceCurrentItemWithPlayerItem:item];
    
   
    [self playMusic];
}

//- (CGFloat)setVolume{
//    
//    return  avPlayer.volume;
//}

- (void)setVolumeWithValue:(CGFloat)value{
    
    avPlayer.volume = value;
}




-(void)playMusic{
    [self.timer invalidate];
     isPlaying = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(playing) userInfo:nil repeats:YES];
   
    isPlaying = YES;
    [avPlayer play];
}


-(void)pauseMusic{
    isPlaying = NO;
    [avPlayer pause];
    [self.timer invalidate];
    self.timer = nil;
}

-(BOOL)playOrPauseMusic{
    if (isPlaying) {
        [self pauseMusic];
        return NO;
    }else
    {
        [self playMusic];
        return YES;
    }

}

-(void)seekToTimePlay:(CGFloat)time{
    [self pauseMusic];

    [avPlayer seekToTime:CMTimeMakeWithSeconds(time, avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            [self playMusic];
        }
    }];
  
}

#pragma mark - 私有方法

#pragma mark 播放过程中执行
- (void)playing{
    
    CGFloat time = avPlayer.currentTime.value/avPlayer.currentTime.timescale;
    
    if (self.musicPlayDelegate && [self.musicPlayDelegate performSelector:@selector(playingWithProgress:)]) {
        [self.musicPlayDelegate playingWithProgress:time];
    }
}


#pragma mark 播放结束执行
-(void)musicDidFinished
{
    if (self.musicPlayDelegate && [self.musicPlayDelegate performSelector:@selector(playDidToEnd)]) {
            [self.musicPlayDelegate playDidToEnd];

    }
}















@end
