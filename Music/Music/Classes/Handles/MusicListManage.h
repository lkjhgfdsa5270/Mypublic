//
//  MusicListManage.h
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListManage : NSObject

//+ (instancetype)searchSingleHandle;

@property(nonatomic, strong)NSMutableArray * allModelsArray;

- (void)requestAllDataWithUrl:(NSString *)url Result:(void(^)(NSMutableArray * dataArray))result;


- (MusicModel *)returenModelWithIndex:(NSInteger)index;


singleton_interface(MusicListManage);


@end
