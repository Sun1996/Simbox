//
//  PopupOutlineCell.m
//  Simbox
//
//  Created by 孙一峰 on 2018/8/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "PopupOutlineCell.h"
#import "Masonry.h"
#import "NSLable.h"
#import "UIColor+Extensions.h"

@interface PopupOutlineCell ()
@property(nonatomic,strong) NSImageView     *imageView;
@property(nonatomic,strong) NSLable         *titleLable;

@end

@implementation PopupOutlineCell

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
}

#pragma mark - LayoutSuviews
- (void)layoutSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@24);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.imageView.mas_right).offset(12);
        make.height.equalTo(@17);
    }];
}

#pragma mark - Setter and Getter
-(void)setData:(DetailInfoResult *)data{

    _titleLable.stringValue = data.nodeName ?: @"";

}
-(NSImageView *)imageView{
    if (!_imageView) {
        _imageView = [[NSImageView alloc]init];
        _imageView.imageFrameStyle = NSImageFrameNone; //图片边框的样式
        _imageView.imageScaling = NSImageScaleProportionallyUpOrDown;//
        _imageView.image = [NSImage imageNamed:@"icon_folder"];
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

@end
