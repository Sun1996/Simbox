//
//  AddFolderView.m
//  Simbox
//
//  Created by 孙一峰 on 2018/7/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "AddFolderView.h"
#import "NSLable.h"
#import "NSBaseButton.h"
#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "SPopButton.h"
#import "PopupView.h"

@interface AddFolderView()

@property(nonatomic,strong) NSLable          *titleLable;

@property(nonatomic,strong) NSBaseButton     *cancelButton;
@property(nonatomic,strong) SPopButton     *locationButton;   //选择存储位置
@property(nonatomic,strong) NSTextField     *nameButton;       //选择文件
@property(nonatomic,strong) NSBaseButton     *addButton;


@end


@implementation AddFolderView

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
    [self addSubview:self.nameButton];
    [self addSubview:self.addButton];
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
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(240);
        make.centerX.equalTo(self);
        make.width.equalTo(@350);
        make.height.equalTo(@40);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    PopupView *popupView = [[PopupView alloc]initWithFrame:NSMakeRect(45, 95, 350, 190)];
    popupView.dept = self.dept;
    [self addSubview:popupView];
}


-(void)addFolder:(id)send{
    
}


#pragma mark - Setter and Getter
-(void)setDept:(DepartmentData *)dept{
    _dept = dept ;
    _locationButton.title = dept.name;
}

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
        _titleLable.stringValue = @"新建文件夹";
        _titleLable.font = [NSFont systemFontOfSize:16];   //文字大小
        _titleLable.textColor = [NSColor colorWithHexString:@"0x18191A" alpha:0.9f];      //文字颜色
        _titleLable.alignment = NSTextAlignmentCenter;       //水平显示方式
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

-(NSTextField *)nameButton{
    if (!_nameButton) {
        _nameButton = [[NSTextField alloc]init];
        _nameButton.wantsLayer = YES;
        _nameButton.layer.cornerRadius = 6.f;
        _nameButton.layer.borderWidth = 1.f;
        _nameButton.layer.borderColor = [NSColor colorWithHexString:@"D8D8D8"].CGColor;
        
        _nameButton.placeholderString = @"请填写你的梦想";
//        _nameButton.bezeled = YES;
        _nameButton.bezelStyle = NSTextFieldRoundedBezel;

        _nameButton.maximumNumberOfLines = 1; //最多显示行数
        [[_nameButton cell]setUsesSingleLineMode:YES];//启用单行模式 
        
    }
    return _nameButton;
}

-(NSBaseButton *)addButton{
    if (!_addButton) {
        _addButton = [[NSBaseButton alloc]init];
        //        _uploadButton.hasBorder = NO ;
        _addButton.cornerNormalRadius = 22;
        _addButton.backgroundNormalColor = [NSColor colorWithHexString:@"3C99FC"];
        
        _addButton.font = [NSFont systemFontOfSize:16];
        _addButton.title = @"新建";
        _addButton.normalColor = [NSColor whiteColor];
        
        
        [_addButton setTarget:self];
        [_addButton setAction:@selector(addFolder:)];
        
    }
    return _addButton;
}












@end
