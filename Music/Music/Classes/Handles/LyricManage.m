//
//  LyricManage.m
//  Music
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LyricManage.h"

@interface LyricManage ()

//存放一首歌的歌词模型
@property(nonatomic, strong) NSMutableArray *allLyricModelsArray;

@end


@implementation LyricManage

+ (instancetype)shareInstrace{
    static LyricManage * lyricManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lyricManage = [[LyricManage alloc]init];
        
        //初始化数组
        lyricManage.allLyricModelsArray = [NSMutableArray array];

    });
    return lyricManage;
}

- (void)formatLyricModelWithLyric:(NSString *)lyric{
    
    [self.allLyricModelsArray removeAllObjects];
    
    NSArray * conentArray = [lyric componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i<conentArray.count -1; i++) {
        NSString * sourceStr = conentArray[i];
        
        NSArray * lyricArray = [sourceStr componentsSeparatedByString:@"]"];
        
        if ([lyricArray.firstObject length]< 1) {
            break;
        }
        
        NSString * timeStr = [lyricArray.firstObject substringFromIndex:1];
        
        NSArray * timeArray = [timeStr componentsSeparatedByString:@":"];
        
        CGFloat timeTotal = [timeArray.firstObject floatValue]* 60 + [timeArray.lastObject floatValue];
        
        NSString * lyricStr = lyricArray.lastObject;
        
        LyricModel * lyricModel = [[LyricModel alloc]init];
        
        lyricModel.time = timeTotal;
        
        lyricModel.lytric = lyricStr;
        
        [self.allLyricModelsArray addObject:lyricModel];
        
    }
}
#pragma mark 根据下标返回歌词
- (NSString *)lyricAtIndex:(NSInteger)index{
    LyricModel * lyricModel = [self.allLyricModelsArray objectAtIndex:index];
    return lyricModel.lytric;
}

#pragma mark 根据时间返回下标
- (NSInteger)indexOfTime:(CGFloat)time{
    NSInteger index = 0;
    for (int i = 0; i<self.allLyricModelsArray.count-1; i++) {
        LyricModel * lyricModel = self.allLyricModelsArray[i];
        if (lyricModel.time>time) {
            index = i-1>0?i-1:0;
            break;
        }
    }
    return index;
}

#pragma mark 根据下标返回播放时间
-(CGFloat)progressAtIndex:(NSInteger)index{
    LyricModel * lyricModel = self.allLyricModelsArray[index];
    
    CGFloat time = lyricModel.time;
    
    return time;
    
}


#pragma mark 返回数组个数
-(NSInteger)countOfAllLyricModelsArray{
    return self.allLyricModelsArray.count;
}









@end
