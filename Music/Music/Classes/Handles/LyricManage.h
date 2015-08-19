//
//  LyricManage.h
//  Music
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricManage : NSObject

+ (instancetype)shareInstrace;


- (void)formatLyricModelWithLyric:(NSString *)lyric;//格式化歌词 创建歌词模型 并存放进数组


- (NSString *)lyricAtIndex:(NSInteger)index; //格式化歌词

#pragma mark 根据时间返回下标
- (NSInteger)indexOfTime:(CGFloat)time;

#pragma mark 根据下标返回播放时间
-(CGFloat)progressAtIndex:(NSInteger)index;


#pragma mark 返回数组个数
-(NSInteger)countOfAllLyricModelsArray;

@end
