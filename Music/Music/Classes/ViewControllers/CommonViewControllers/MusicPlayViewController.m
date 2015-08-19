//
//  MusicPlayViewController.m
//  Music
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "MusicListManage.h"
#import "LyricManage.h"

@interface MusicPlayViewController ()<MusicPlayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentIndex;//记录当前歌曲模型下标
}

@property(nonatomic,assign)NSInteger currentIndex;


@end

@implementation MusicPlayViewController

+ (instancetype)shareInstance{
    static MusicPlayViewController * musicPlayViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"playStoryboard"];
    });
    return musicPlayViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentIndex = -1;
    
    [MusicPlayManage shareInstrace].musicPlayDelegate = self;
    
    self.singerPhoto.transform = CGAffineTransformMakeRotation(0);
    
    self.slider.continuous = YES;
    
    self.LyricTableView.delegate = self;
    self.LyricTableView.dataSource = self;
    
    [self.LyricTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    if (_currentIndex == self.index) {
        
    }else{
        _currentIndex = self.index;
    }
    [self upData];
    
}

- (void)upData{
    
    self.musicModel = [[MusicListManage sharedMusicListManage]returenModelWithIndex:_currentIndex];
    
    [self.singerPhoto sd_setImageWithURL:[NSURL URLWithString:_musicModel.picUrl]];
    
    [[MusicPlayManage shareInstrace] setAVPlayerWithUrl:self.musicModel.mp3Url];
    CGFloat duration = [self.musicModel.duration floatValue]/1000;
    
    self.slider.maximumValue = duration;
    
  
    
    //加载歌词 刷新界面

    [[LyricManage shareInstrace]formatLyricModelWithLyric:self.musicModel.lyric];
    
    [self.LyricTableView reloadData];
    
}
#pragma mark 播放过程中执行
- (void)playingWithProgress:(CGFloat)progress{
    
    
    
    self.singerPhoto.transform = CGAffineTransformRotate(self.singerPhoto.transform, M_PI_2/100);
    
    self.slider.value = progress;
    
    self.currentTime.text = [self changeFormatWithTime:progress];
    
    CGFloat duration = [self.musicModel.duration floatValue]/1000;
    
    self.duration.text = [self changeFormatWithTime:duration-progress];
    
#pragma mark--------------
    
    NSInteger index = [[LyricManage shareInstrace]indexOfTime:progress];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.LyricTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[LyricManage shareInstrace]countOfAllLyricModelsArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//中心对齐
    
    cell.textLabel.text = [[LyricManage shareInstrace]lyricAtIndex:indexPath.row];
    
    cell.highlighted = YES;
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random() % 256/256.0) blue:(arc4random() % 256/256.0) alpha:1];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat time = [[LyricManage shareInstrace] progressAtIndex:indexPath.row];
    
    [[MusicPlayManage shareInstrace]seekToTimePlay:time];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)backSong:(id)sender {
    [[MusicPlayManage shareInstrace]pauseMusic];
    _currentIndex--;
    if (_currentIndex<0) {
        _currentIndex = [MusicListManage sharedMusicListManage].allModelsArray.count-1;
    }
    [self upData];
}

- (IBAction)nextSong:(id)sender {

    [[MusicPlayManage shareInstrace]pauseMusic];
    _currentIndex++;
    if (_currentIndex>[MusicListManage sharedMusicListManage].allModelsArray.count-1) {
        _currentIndex = 0;
    }
    [self upData];
}

- (IBAction)playSong:(id)sender {
        BOOL isplayling = [[MusicPlayManage shareInstrace] playOrPauseMusic];
        if (isplayling) {
            [(UIButton *)sender setTitle:@"暂停" forState:UIControlStateNormal];
        }else{
            [(UIButton *)sender setTitle:@"播放" forState:UIControlStateNormal];
    
        }
    
}

- (void)playDidToEnd{
    
    _currentIndex++;
    if (_currentIndex>[MusicListManage sharedMusicListManage].allModelsArray.count-1) {
        _currentIndex = 0;
    }
    
    [self upData];
    
}



#pragma mark - 转换时间格式

-(NSString *)changeFormatWithTime:(CGFloat)time
{
    //计算分钟
    int minute = time/60;
    //计算秒
    int seconds = (int)time%60;
    
    NSString *timeFormat = [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
    return timeFormat;
}

#pragma mark-------------------------------------滑动


- (IBAction)sliderSong:(id)sender {
    
    
    CGFloat duration = [self.musicModel.duration floatValue]/1000;
    if (((UISlider *)sender).value >= duration) {
       // [[MusicPlayManage shareInstrace]pauseMusic];
        [self playDidToEnd];
    }
    UISlider * slider = sender;
    CGFloat value = slider.value;
    
    NSLog(@"=-=-=-=-=%f",value);
    [[MusicPlayManage shareInstrace]seekToTimePlay:value];
    
}



- (IBAction)changeVolume:(id)sender {
    
    UISlider * slider = (UISlider *)sender;
    
  
    
    [[MusicPlayManage shareInstrace] setVolumeWithValue:slider.value];
    
  //  CGFloat VO =  [[[MusicPlayManage shareInstrace] setVolume];
  //  VO =  slider.value;
}
@end
