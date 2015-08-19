//
//  MusicListManage.m
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListManage.h"

@interface MusicListManage()




@end

@implementation MusicListManage

singleton_implementation(MusicListManage);


//+ (instancetype)searchSingleHandle{
//    static MusicListManage * musicListMange = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        musicListMange = [[MusicListManage alloc]init];
//    });
//    return musicListMange;
//}

- (void)requestAllDataWithUrl:(NSString *)url Result:(void (^)(NSMutableArray * dataArray))result{
    NSURL * url1 = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * array = [NSArray arrayWithContentsOfURL:url1];
        
        for (NSDictionary * dic in array) {
             MusicModel * musicModel = [[MusicModel alloc]init];
            
            [musicModel setValuesForKeysWithDictionary:dic];
            
            [self.allModelsArray addObject:musicModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            result(_allModelsArray);
        });
        
        
    });
 
}

- (NSMutableArray *)allModelsArray{
    if (!_allModelsArray) {
        _allModelsArray = [NSMutableArray array];
    }
    return _allModelsArray;
}

- (MusicModel *)returenModelWithIndex:(NSInteger)index{
    MusicModel * musicMldel = self.allModelsArray[index];
    return musicMldel;
}





















@end
