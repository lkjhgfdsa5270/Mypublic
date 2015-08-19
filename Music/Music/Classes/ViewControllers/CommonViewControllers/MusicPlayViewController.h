//
//  MusicPlayViewController.h
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *singerPhoto;

@property (strong, nonatomic) IBOutlet UILabel *currentTime;


@property (strong, nonatomic) IBOutlet UILabel *duration;


@property (strong, nonatomic) IBOutlet UISlider *slider;


- (IBAction)backSong:(id)sender;

- (IBAction)nextSong:(id)sender;

- (IBAction)playSong:(id)sender;


@property(nonatomic,strong)MusicModel * musicModel;

@property(nonatomic,assign)NSInteger index;

+ (instancetype)shareInstance;

- (IBAction)backPage:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *LyricTableView;

@property (strong, nonatomic) IBOutlet UISlider *volume;

- (IBAction)changeVolume:(id)sender;

@end
