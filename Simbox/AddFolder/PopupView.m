//
//  PopupView.m
//  Simbox
//
//  Created by 孙一峰 on 2018/8/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "PopupView.h"
#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "MCUVmsNetSDK.h"
#import "PopupOutlineCell.h"
#import "DetailInfoResult.h"

@interface PopupView()<
NSOutlineViewDelegate,
NSOutlineViewDataSource
>

@property (nonatomic,strong) NSScrollView           *scrollView;
@property (nonatomic,strong) NSOutlineView          *outlineView;

@property (nonatomic,strong) NSArray                *infoArray;//文件夹data


@end

@implementation PopupView

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
    
    [self loadFileDate];
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
    
    [self addSubview:self.scrollView];
    self.scrollView.contentView.documentView = self.outlineView;
    
    
}

-(void )layoutSubviews{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.outlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
}

#pragma mark - NSOutlineViewDelegate
// 子节点的行数
-(NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
    if (item) {
        DetailInfoResult *data = item;
        if ([data type] == 1)
        {
            return data.leafArray.count;
        }
    }
    return self.infoArray.count;
    
}
//行高
-(CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item{
    return 32;
}
//节点加载
-(id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
    if (item != nil)
    {
        DetailInfoResult *data = item;
        if ([data type] == 1)
        {
            return [data.leafArray objectAtIndex:index];
        }
    }
    return self.infoArray[index];
    
}
//是否可以展开
-(BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{

    return YES;
}

//每个单元内的cell
-(NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item{
    PopupOutlineCell *cell = [[PopupOutlineCell alloc]init];
    if (item != nil)
    {
        DetailInfoResult *data = item;
        cell.data = data;
    }
    
    return cell;
}
//是否可以选中单元
-(BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item{
    return YES;
}

#pragma mark - Network

-(void)loadFileDate{
    NSDictionary *params = @{ @"deptId" : [NSString stringWithFormat:@"%ld",self.dept.departmentID]};
    
    [[MCUVmsNetSDK shareInstance] getDirListWithParams:params success:^(NSDictionary *json) {
        NSInteger status = [json[@"code"] integerValue];
        if(status == 200){
            self.infoArray = [self classifyResult:json[@"data"]];
            [self.outlineView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Event Response
/**
 *  字典 —> 模型
 */
-(NSArray *)classifyResult:(NSDictionary *)result{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *info in result) {
        DetailInfoResult *fileData = [[DetailInfoResult alloc]init];
        fileData.nodeId = info[@"id"];
        fileData.nodeName = info[@"name"];
        fileData.creator = info[@"creator"];
        fileData.createTime = info[@"createTime"];
        fileData.type = [info[@"type"] integerValue];
        fileData.filePath = info[@"filePath"];
        fileData.isNew = YES;
        
        if (![info[@"child"] isEqual:[NSNull null]]) {
            fileData.leafArray = [self classifyResult:info[@"child"]];
        }
        
        [dataArray addObject:fileData];
    }
    return dataArray;
}

#pragma mark - Setter and Getter
-(void)setDept:(DepartmentData *)dept{
    _dept = dept;
}

-(NSScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[NSScrollView alloc]init];
        _scrollView.hasVerticalScroller  = YES;     //有垂直滚动条
        _scrollView.autohidesScrollers = YES;      //自动隐藏滚动条（滚动的时候出现）
//        _scrollView.backgroundColor = [NSColor colorWithHexString:@"0xF5F6F8"];
        _scrollView.backgroundColor = [NSColor clearColor];
    }
    return _scrollView;
}

-(NSOutlineView *)outlineView{
    if (!_outlineView) {
        _outlineView = [[NSOutlineView alloc]init];
        _outlineView.delegate = self;
        _outlineView.dataSource = self;
        
        _outlineView.headerView.frame = NSZeroRect;       //表头
        _outlineView.indentationPerLevel = 16;            //层级缩进
        
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"column"];
        [column setWidth:352];
//        column.
        [_outlineView addTableColumn:column];
    }
    return _outlineView;
}



- (IBAction)outlineViews:(id)sender {
}
@end
