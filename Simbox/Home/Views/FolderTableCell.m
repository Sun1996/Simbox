//
//  FolderTableCell.m
//  Simbox
//
//  Created by Sun on 2018/7/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "FolderTableCell.h"
#import "Masonry.h"
#import "NSLable.h"
#import "NSBaseButton.h"
#import "UIColor+Extensions.h"

@interface FolderTableCell ()
@property(nonatomic,strong) NSImageView     *imageView;
@property(nonatomic,strong) NSLable         *titleLable;
@property(nonatomic,strong) NSLable         *createTimeLable;
@property(nonatomic,strong) NSLable         *creatorLable;
@property(nonatomic,strong) NSBaseButton    *downloadButton;
@property(nonatomic,strong) NSImageView     *hintImgView;


@end

@implementation FolderTableCell

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupViews];
        [self layoutSubviews];
    }
    return self;
}
- (void)setupViews {
    self.wantsLayer = YES;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLable];
    [self addSubview:self.createTimeLable];
    [self addSubview:self.creatorLable];
    [self addSubview:self.downloadButton];
    [self addSubview:self.hintImgView];
}

#pragma mark - LayoutSuviews
- (void)layoutSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@32);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(9);
        make.left.equalTo(self.imageView.mas_right).offset(12);
        make.height.equalTo(@18);
    }];
    
    [self.createTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-9);
        make.left.equalTo(self.titleLable);
        make.height.equalTo(@13);
    }];
    
    [self.creatorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-9);
        make.left.equalTo(self.createTimeLable.mas_right).offset(10);
        make.height.equalTo(@13);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-30);
        make.width.equalTo(@80);
        make.height.equalTo(@24);
    }];
    
    [self.hintImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.left.equalTo(self.titleLable.mas_right).offset(10);
        make.width.equalTo(@8);
        make.height.equalTo(@8);
    }];
    

}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}


#pragma mark - Event Response
-(void)download:(id)send{
    NSLog(@"download-----");
    
    NSViewController *VC = [[NSViewController alloc]init];

    
    
    NSPopover * popover = [[NSPopover alloc]init];
    [popover setContentViewController:VC];
    
    popover.behavior = NSPopoverBehaviorTransient;//动画
    popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];//外观
    
    NSButton *btn = send;
    NSRect rect = [btn bounds];
    
    [popover showRelativeToRect:rect ofView:btn preferredEdge:NSMaxYEdge];
    
    
}



#pragma mark - Setter and Getter
-(void)setData:(DetailInfoResult *)data{
    _data = data;
    
    if (data.type) {
        _imageView.image = [NSImage imageNamed:@"icon_folder"];
        _downloadButton.hidden = YES;
    }else{
        _imageView.image = [NSImage imageNamed:@"icon_file"];
        _downloadButton.hidden = NO;
    }
    if (data.isNew) {
        _hintImgView.hidden = NO;
    }
    _titleLable.stringValue = data.nodeName ?: @"";
    _createTimeLable.stringValue = data.createTime ?: @"";
    _creatorLable.stringValue = data.creator ?: @"";
}

-(NSImageView *)imageView{
    if (!_imageView) {
        _imageView = [[NSImageView alloc]init];
        _imageView.imageFrameStyle = NSImageFrameNone; //图片边框的样式
        _imageView.imageScaling = NSImageScaleProportionallyUpOrDown;//
        _imageView.image = [NSImage imageNamed:@"icon_file"];
        _imageView.wantsLayer = YES;
        _imageView.layer.backgroundColor = [NSColor clearColor].CGColor;
    }
    return _imageView;
}

-(NSLable *)titleLable{
    if (!_titleLable) {
        _titleLable = [[NSLable alloc]init];
        _titleLable.font = [NSFont systemFontOfSize:14];
        _titleLable.textColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.7f];
    }
    return _titleLable;
}
-(NSLable *)createTimeLable{
    if (!_createTimeLable) {
        _createTimeLable = [[NSLable alloc]init];
        _createTimeLable.font = [NSFont systemFontOfSize:12];
        _createTimeLable.textColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.3f];
        _createTimeLable.stringValue = @"2018-05-10 12:30:45";
    }
    return _createTimeLable;
}
-(NSLable *)creatorLable{
    if (!_creatorLable) {
        _creatorLable = [[NSLable alloc]init];
        _creatorLable.textColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.3f];
        _creatorLable.font = [NSFont systemFontOfSize:12];
        _creatorLable.stringValue = @"By：jiangjiahuan";
    }
    return _creatorLable;
}
-(NSBaseButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [[NSBaseButton alloc]init];
        _downloadButton.backgroundNormalColor = [NSColor clearColor];
        _downloadButton.cornerNormalRadius = 12;
        _downloadButton.borderNormalWidth = 1.0f;
        _downloadButton.borderNormalColor = [NSColor colorWithHexString:@"0xD8D8D8"];
//        _downloadButton.borderNormalColor = [NSColor redColor];
//        _downloadButton.bezelStyle = NSBezelStyleInline;
//        [_downloadButton setButtonType:NSButtonTypeMomentaryChange];
        
        _downloadButton.font = [NSFont systemFontOfSize:14];
        _downloadButton.title = @"下载";
        _downloadButton.normalColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.7f];
        
        
        _downloadButton.canHover = YES;
        _downloadButton.hoverColor = [NSColor colorWithHexString:@"0x3c99F7"];
        _downloadButton.borderHoverColor = [NSColor colorWithHexString:@"0x3c99F7"];
        
        [_downloadButton setTarget:self];
        [_downloadButton setAction:@selector(download:)];
//        _downloadButton
        
    }
        return _downloadButton;
}

-(NSImageView *)hintImgView{
    if (!_hintImgView) {
        _hintImgView = [[NSImageView alloc]init];
//        _imageView.imageFrameStyle = NSImageFrameNone; //图片边框的样式
//        _imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
        _hintImgView.wantsLayer = YES;
        _hintImgView.layer.cornerRadius = 4;
        _hintImgView.layer.backgroundColor = [NSColor redColor].CGColor;
        
        _hintImgView.hidden = YES;
    }
    return _hintImgView;
}





@end
