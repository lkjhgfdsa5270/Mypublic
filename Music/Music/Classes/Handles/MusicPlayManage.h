//
//  MusicPlayManage.h
//  Music
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MusicPlayDelegate <NSObject>

- (void)playingWithProgress:(CGFloat)progress;//播放中

- (void)playDidToEnd;//歌曲结束

@end






@interface MusicPlayManage : NSObject

+ (instancetype)shareInstrace;

- (void)setAVPlayerWithUrl:(NSString *)url;

@property(nonatomic,assign)id<MusicPlayDelegate>musicPlayDelegate;

-(void)pauseMusic;

-(BOOL)playOrPauseMusic;

-(void)seekToTimePlay:(CGFloat)time;


//- (CGFloat)setVolume;

- (void)setVolumeWithValue:(CGFloat)value;



@end
