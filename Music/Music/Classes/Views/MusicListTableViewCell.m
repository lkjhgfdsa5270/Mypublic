//
//  MusicListTableViewCell.m
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListTableViewCell.h"

@implementation MusicListTableViewCell

- (void)setMusicModel:(MusicModel *)musicModel{
    
    self.songName.text = musicModel.name;
    
    self.singerName.text = musicModel.singer;
    
    [self.singerPhoto sd_setImageWithURL:[NSURL URLWithString: musicModel.picUrl]];
    
    
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
