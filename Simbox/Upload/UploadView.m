//
//  UploadView.m
//  Simbox
//
//  Created by 孙一峰 on 2018/7/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UploadView.h"
#import "NSLable.h"
#import "NSBaseButton.h"
#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "SPopButton.h"

@interface UploadView()

@property(nonatomic,strong) NSLable          *titleLable;

@property(nonatomic,strong) SPopButton     *locationButton;   //选择存储位置
@property(nonatomic,strong) SPopButton     *fileButton;       //选择文件
@property(nonatomic,strong) NSBaseButton     *uploadButton;
@property(nonatomic,strong) NSBaseButton     *cancelButton;

@end

@implementation UploadView

-(instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setupViews];
        [self layoutSubviews];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

-(void )setupViews{
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.cornerRadius = 6;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [NSColor colorWithHexString:@"0x000000"alpha:0.05].CGColor;
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[NSColor colorWithHexString:@"0x000000"alpha:0.24]];//阴影颜色
    [shadow setShadowOffset:NSMakeSize(1, 1)];  //设置阴影为右下方
    [self setShadow:shadow];

    
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.locationButton];
    [self addSubview:self.fileButton];
    [self addSubview:self.uploadButton];
}

-(void )layoutSubviews{
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(8);
        make.width.height.equalTo(@12);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(56);
        make.centerX.equalTo(self);
        make.width.equalTo(@183);
        make.height.equalTo(@20);
    }];
    
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(150);
        make.centerX.equalTo(self);
        make.width.equalTo(@350);
        make.height.equalTo(@40);
    }];
    
    [self.fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(240);
        make.centerX.equalTo(self);
        make.width.equalTo(@350);
        make.height.equalTo(@40);
    }];
    
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-65);
        make.centerX.equalTo(self);
        make.width.equalTo(@350);
        make.height.equalTo(@45);
    }];
}











#pragma mark - Event Response
-(void)cancel{
    [self removeFromSuperview];
}

-(void)location:(id)send{
    
    
    
}

-(void)file:(id)send{
    NSOpenPanel* panel = [NSOpenPanel openPanel];
//    __weak typeof(self)weakSelf = self;
    panel.canCreateDirectories = YES;//是否可以创建文件夹
    panel.canChooseDirectories = NO;//是否可以选择文件夹
    panel.canChooseFiles = YES;//是否可以选择文件
    [panel setAllowsMultipleSelection:NO];//是否可以多选
//    NSArray *array = [NSArray arrayWithObject:@"sketch"];
    NSArray *array = [NSArray arrayWithObject:@"png"];
    [panel setAllowedFileTypes:array];//允许选择的文件类型
    
    //显示
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        //是否点击open 按钮
        if (result == NSModalResponseOK) {
            NSString *pathString = [panel.URLs.firstObject path];
            //            weakSelf.urlTextField = pathString;
            
            NSLog(@"----------pathString:%@",pathString);
            
            self.fileButton.title = pathString;
        }
    }];
    
}
-(void)upload:(id)send{
    
}



#pragma mark - Setter and Getter
-(NSBaseButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[SPopButton alloc]init];
        _cancelButton.hasBorder = NO ;
        _cancelButton.canHover = YES ;
        _cancelButton.backgroundNormalColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"icon_24_close_nor"]];
        _cancelButton.backgroundHoverColor= [NSColor colorWithPatternImage:[NSImage imageNamed:@"icon_24_close_hov"]];
        _cancelButton.backgroundHighlightColor= [NSColor colorWithPatternImage:[NSImage imageNamed:@"icon_24_close_hov"]];
        
        _cancelButton.title = @"";
        
        [_cancelButton setTarget:self];
        [_cancelButton setAction:@selector(cancel)];
        
    }
    return _cancelButton;
}
-(NSLable *)titleLable{
    if (!_titleLable) {
        _titleLable = [[NSLable alloc]init];
        _titleLable.stringValue = @"请选择文件上传至Simbox";
        _titleLable.stringValue = @"请选择文件上传至插件";
        _titleLable.font = [NSFont systemFontOfSize:16];   //文字大小
        _titleLable.textColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.9f];      //文字颜色
    }
    return _titleLable;
}

-(SPopButton *)locationButton{
    if (!_locationButton) {
        _locationButton = [[SPopButton alloc]init];
        _locationButton.cornerNormalRadius = 7;
        _locationButton.borderHighlightColor = [NSColor colorWithHexString:@"3C99FC"];
        
        _locationButton.title = @"楼宇事业部";
        _locationButton.rightImage = [NSImage imageNamed:@"icon_32_jiantou_down"];

        [_locationButton setTarget:self];
        [_locationButton setAction:@selector(location:)];
        
    }
    return _locationButton;
}

-(SPopButton *)fileButton{
    if (!_fileButton) {
        _fileButton = [[SPopButton alloc]init];
        _fileButton.cornerNormalRadius = 7;
        _fileButton.borderHighlightColor = [NSColor colorWithHexString:@"3C99FC"];
        _fileButton.title = @"楼宇事业部楼宇事业部楼宇事业部楼宇事业部楼宇事业部楼宇事业部楼宇事业部楼宇事业部";
        _fileButton.rightImage = [NSImage imageNamed:@"icon_24_liulan"];

        [_fileButton setTarget:self];
        [_fileButton setAction:@selector(file:)];
        
    }
    return _fileButton;
}

-(NSBaseButton *)uploadButton{
    if (!_uploadButton) {
        _uploadButton = [[NSBaseButton alloc]init];
//        _uploadButton.hasBorder = NO ;
        _uploadButton.cornerNormalRadius = 22;
        _uploadButton.backgroundNormalColor = [NSColor colorWithHexString:@"3C99FC"];
        
        _uploadButton.font = [NSFont systemFontOfSize:16];
        _uploadButton.title = @"上传";
        _uploadButton.normalColor = [NSColor whiteColor];
        
        
        [_uploadButton setTarget:self];
        [_uploadButton setAction:@selector(upload:)];
        
    }
    return _uploadButton;
}











@end
