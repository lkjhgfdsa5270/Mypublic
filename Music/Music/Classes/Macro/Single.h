//
//  Single.h
//  Music
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#ifndef Music_Single_h
#define Music_Single_h

/// 写在.h文件中
#define singleton_interface(className) \
+ (className *)shared##className;


/// 写在.m文件中
#define singleton_implementation(className) \
static className *_instance; \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[[self class] alloc] init]; \
}); \
return _instance; \
} \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \






#endif
