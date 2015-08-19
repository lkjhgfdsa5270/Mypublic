//
//  MusicListTableViewCell.h
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *singerPhoto;

@property (strong, nonatomic) IBOutlet UILabel *songName;

@property (strong, nonatomic) IBOutlet UILabel *singerName;


@property(nonatomic, strong)MusicModel * musicModel;


@end
