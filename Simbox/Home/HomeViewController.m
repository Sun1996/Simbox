//
//  HomeViewController.m
//  Simbox
//
//  Created by Sun on 2018/7/4.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "DepartmentData.h"
#import "DetailInfoResult.h"
#import "LeftTableRowView.h"
#import "DepartmentTableCell.h"
#import "FolderTableCell.h"
#import "MCUVmsNetSDK.h"

#import "UploadView.h"
#import "AddFolderView.h"

#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "NSLable.h"
#import "NSBaseButton.h"


@interface HomeViewController ()<
NSTableViewDelegate,
NSTableViewDataSource,
NSOutlineViewDataSource,
NSOutlineViewDelegate
>


@property(nonatomic,strong) NSView          *leftView;
@property(nonatomic,strong) NSScrollView    *leftscrollView;
@property(nonatomic,strong) NSLable         *logoLabel;
@property(nonatomic,strong) NSBaseButton         *loginButton;
@property(nonatomic,strong) NSTableView     *departmentTableView;
//@property (weak) IBOutlet NSTableView *departmentTableView;
@property(nonatomic,strong) NSScrollView    *rightscrollView;
@property(nonatomic,strong) NSOutlineView   *detailInfoOutlineView;
@property (weak) IBOutlet   NSOutlineView   *OutlineView;

@property(nonatomic,strong) NSView          *toolBarView;

@property(nonatomic,strong) DepartmentData      *selectionedDept;           // 选中的部门

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    [self initUI];
    [self layoutSubviews];
}

- (void)initUI {
    
    [self.view addSubview:self.leftView];
    
    [self.leftView  addSubview:self.logoLabel];
    [self.leftView addSubview:self.loginButton];
    [self.leftView addSubview:self.leftscrollView];
//    [self.leftscrollView addSubview:self.departmentTableView];
    self.leftscrollView.contentView.documentView = self.departmentTableView;
    
//    [self.departmentTableView selectRowIndexes:[[NSIndexSet alloc] initWithIndex: 3] byExtendingSelection:YES];

//    [self.view addSubview:self.detailInfoOutlineView];
//    [self.view addSubview:self.rightscrollView];
//    self.rightscrollView.contentView.documentView = self.detailInfoOutlineView;
//    [self.view addSubview:self.OutlineView];
    
    [self.view addSubview:self.toolBarView];
}


#pragma mark - LayoutSuviews
- (void)layoutSubviews {
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.equalTo(@180);
        make.height.equalTo(@600);
    }];
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(25);
        make.left.equalTo(self.view);
        make.width.equalTo(@180);
        make.height.equalTo(@60);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoLabel.mas_bottom).offset(12);
        make.left.equalTo(self.view).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    [self.leftscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
        make.bottom.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.leftView).offset(-10);
//        make.width.equalTo(@150);
    }];
    [self.departmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.leftView).offset(-10);
//        make.width.equalTo(@150);
    }];
    
    
    
//    [self.rightscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.equalTo(self.view);
//        make.width.equalTo(@540);
//        make.height.equalTo(@600);
//    }];
//
//    [self.detailInfoOutlineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.equalTo(self.view);
//        make.width.equalTo(@540);
//        make.height.equalTo(@600);
//    }];
    
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.width.equalTo(@540);
        make.height.equalTo(@40);
    }];
    
}




#pragma mark - NSTableViewDelegate
// 列表的行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.departmentDataArray.count;
}
//行高
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 40 ;
}
//指定自定义的行(选中行背景等)
- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
{
    LeftTableRowView *rowView = [tableView makeViewWithIdentifier:@"rowView" owner:self];
    if (!rowView) {
        rowView = [[LeftTableRowView alloc] init];
        rowView.identifier = @"rowView";
    }
    return rowView;
}

//每个单元内的view
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{

    DepartmentTableCell *cell = [[DepartmentTableCell alloc]init];
    DepartmentData *data = self.departmentDataArray[row];
    cell.name = data.name;
    
    return cell;
}

//是否可以选中单元格
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    return YES;
}
//选中的响应
-(void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSTableView* tableView = notification.object;
    NSInteger selectedRow = [tableView selectedRow];
    DepartmentData *data = self.departmentDataArray[selectedRow];
    self.selectionedDept = data;
//    self.selectionedDept = [NSString stringWithFormat:@"%ld",data.departmentID];
    [self loadFileDate];
    
    NSLog(@"------%ld",selectedRow);
    
//    [self.OutlineView reloadData];
    
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
    return self.detailInfoArray.count;

}
//行高
-(CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item{
    return 50;
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
    return self.detailInfoArray[index];

}
//是否可以展开
-(BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{
    if (item != nil)
    {
        DetailInfoResult *data = item;
        if ([data type] == 1)
        {
            return YES;
        }
    }
    return NO;
}
//-(id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item{
//    return item;
//}
//每个单元内的cell
-(NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item{
    FolderTableCell *cell = [[FolderTableCell alloc]init];
    if (item != nil)
    {
        DetailInfoResult *data = item;
        cell.data = data;
    }

    return cell;
}
//是否可以选中单元
-(BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item{
    return NO;
}

#pragma mark - Network
-(void)loadDeptDate{
    [[MCUVmsNetSDK shareInstance]getDaptWithParams:nil success:^(NSDictionary *json) {
        NSMutableArray *dataArray = [NSMutableArray array];
        NSInteger status = [json[@"code"] integerValue];
        NSDictionary *data = json[@"data"];
        if(status == 200){
            for (int i = 0; i < data.count ; i++){
                DepartmentData *deptData = [[DepartmentData alloc]init];
                deptData.departmentID = [json[@"data"][i][@"id"] integerValue];
                deptData.name = json[@"data"][i][@"name"];
                
                [dataArray addObject:deptData];
            }
            self.departmentDataArray = dataArray;
            [self.departmentTableView reloadData];
        }
    } failure:^(NSError *error) {
        
        
    }];
}

-(void)loadFileDate{
    DepartmentData *data = self.departmentDataArray[0];
    NSString *deptId = [NSString stringWithFormat:@"%ld",data.departmentID];
    NSDictionary *params = @{ @"deptId" : [NSString stringWithFormat:@"%ld",self.selectionedDept.departmentID] ? : deptId};
    
    [[MCUVmsNetSDK shareInstance] getFileWithParams:params success:^(NSDictionary *json) {
        NSInteger status = [json[@"code"] integerValue];
        if(status == 200){
            self.detailInfoArray = [self classifyResult:json[@"data"]];
            [self.OutlineView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - Event Response
-(void)login:(id)sender{
    NSLog(@"login-----");
    
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];

}

-(void)toolBarResponse:(id)sender{
    NSLog(@"toolBarResponse-----");
    NSBaseButton *button = sender;
    switch (button.tag) {
        case 0:{
            [self addFolder];
            break;
        }
        case 1:{
            [self deletaFile];
            break;
        }
        case 2:{
            [self upDate];
            break;
        }
        case 3:{
            [self upload];
            break;
        }
        case 4:{
            [self download];
            break;
        }
            
        default:
            break;
    }
    
}

//新建文件夹
-(void)addFolder{
    
    AddFolderView *addFolderView = [[AddFolderView alloc]initWithFrame:NSMakeRect(140, 60, 440, 480)];
    addFolderView.dept = self.selectionedDept;
    
    [self.view addSubview:addFolderView];
    
}
//删除
-(void)deletaFile{
    
}
//刷新
-(void)upDate{
    
}
//上传
-(void)upload{
    
    UploadView *uploadView = [[UploadView alloc]initWithFrame:NSMakeRect(140, 60, 440, 480)];
    
    [self.view addSubview:uploadView];
    
}
//下载
-(void)download{
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setMessage:@"选择保存地址"];   //提示信息
    [panel setNameFieldStringValue:@"插件.sketch"];//默认文件名
    [panel setDirectoryURL:[NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@""]]];//默认路径
    
    [panel setAllowsOtherFileTypes:YES];
    [panel setAllowedFileTypes:@[@"sketch",@"png"]];//允许的文件类型
    [panel setExtensionHidden:NO];//是否隐藏扩展名
    [panel setCanCreateDirectories:YES];//是否可以创建文件
    
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSString *path =[[panel URL]path];
            NSData *data = [[NSImage imageNamed:@"AppIcon"] TIFFRepresentation];
            [data writeToFile:path atomically:YES];
        }
    }];
    
     
    
    
    
}

-(void)changeView:(id)sender{
    
}



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
-(NSView *)leftView{
    if (!_leftView) {
        _leftView = [[NSView alloc]init];
        _leftView.wantsLayer = YES;
        _leftView.layer.backgroundColor = [NSColor colorWithHexString:@"0xF5F6F8"].CGColor;
//        _leftView.layer.backgroundColor = [NSColor systemYellowColor].CGColor;
    }
    return _leftView;
}
-(NSScrollView *)leftscrollView{
    if (!_leftscrollView) {
        _leftscrollView = [[NSScrollView alloc]init];
        _leftscrollView.hasVerticalScroller  = NO;     //有垂直滚动条
//        _leftscrollView.autohidesScrollers = YES;      //自动隐藏滚动条（滚动的时候出现）
//        _leftscrollView.backgroundColor = [NSColor clearColor];
        _leftscrollView.backgroundColor = [NSColor colorWithHexString:@"0xF5F6F8"];
    }
    return _leftscrollView;
}
-(NSLable *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [[NSLable alloc]init];
        _logoLabel.stringValue = @"Simbox";
        _logoLabel.font = [NSFont fontWithName:@"ChalkboardSE-Regular" size:36];
        _logoLabel.textColor = [NSColor blackColor];
        _logoLabel.alignment = NSTextAlignmentCenter;//水平居中
        _logoLabel.backgroundColor = [NSColor clearColor];
        [_logoLabel setEditable:NO];
        [_logoLabel setBordered:NO];
        
    }
    return _logoLabel;
}
-(NSBaseButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[NSBaseButton alloc]init];

        _loginButton.backgroundNormalColor = [NSColor clearColor];
        _loginButton.bezelStyle = NSBezelStyleInline;
        [_loginButton setButtonType:NSButtonTypeMomentaryChange];
        
        _loginButton.cornerNormalRadius = 15;
        _loginButton.borderNormalWidth = 1.0f;//边框宽度
        _loginButton.borderNormalColor = [NSColor colorWithHexString:@"0xD8D8D8"];//边框颜色
//        _loginButton.borderNormalColor = [NSColor redColor];
        
        _loginButton.borderHighlightColor = [NSColor clearColor];
        _loginButton.backgroundHighlightColor = [NSColor whiteColor];
        _loginButton.highlightColor = [NSColor colorWithHexString:@"0x3C99FC"];
        
        _loginButton.font = [NSFont systemFontOfSize:14];
        _loginButton.title = @"登录";
        

        
        [_loginButton setTarget:self];
        [_loginButton setAction:@selector(login:)];
    }
    return _loginButton;
}
-(NSTableView *)departmentTableView{
    if (!_departmentTableView) {
        _departmentTableView = [[NSTableView alloc]init];
        _departmentTableView.dataSource = self;
        _departmentTableView.delegate = self;
        
        _departmentTableView.backgroundColor = [NSColor clearColor];
        
        _departmentTableView.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
        _departmentTableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
        _departmentTableView.headerView.frame = NSZeroRect;                                  //表头
        
        [_departmentTableView selectRowIndexes:[[NSIndexSet alloc] initWithIndex: 0] byExtendingSelection:YES];//默认选中第一行
        
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"columnLeft"];
        [column setWidth:180];
        [_departmentTableView addTableColumn:column];//一列
    }
    return _departmentTableView;
}

-(NSScrollView *)rightscrollView{
    if (!_rightscrollView) {
        _rightscrollView = [[NSScrollView alloc]init];
//        _rightscrollView.hasVerticalScroller  = YES;     //有垂直滚动条
        _rightscrollView.autohidesScrollers = YES;      //自动隐藏滚动条（滚动的时候出现）
    }
    return _rightscrollView;
}
-(NSOutlineView *)detailInfoOutlineView{
    if (!_detailInfoOutlineView) {
        _detailInfoOutlineView = [[NSOutlineView alloc]init];
        _detailInfoOutlineView.dataSource = self;
        _detailInfoOutlineView.delegate = self;
        
        _detailInfoOutlineView.headerView.frame = NSZeroRect;       //表头
        _detailInfoOutlineView.indentationPerLevel = 32;            //层级缩进
        
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"columnRight"];
        [column setWidth:480];
        [_detailInfoOutlineView addTableColumn:column];             //第一列
    }
    return _detailInfoOutlineView;
}

-(NSView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[NSView alloc]init];
        _toolBarView.wantsLayer = YES;
//        _toolBarView.layer.backgroundColor = [NSColor redColor].CGColor;
        
        NSArray * iconArray = @[@"icon_32_add", @"icon_32_trash",@"icon_32_refresh",@"icon_32_commit_nor",@"icon_32_download_nor"];
        
        for (int i = 0; i < iconArray.count; i++) {
            NSBaseButton *btn = [[NSBaseButton alloc]initWithFrame:NSMakeRect(150 + 56*i, 12, 16, 16)];
            btn.bezelStyle = NSBezelStyleInline;
            [btn setButtonType:NSButtonTypeMomentaryChange];
            btn.hasBorder = NO;
            btn.backgroundNormalColor = [NSColor colorWithPatternImage:[NSImage imageNamed:iconArray[i]]];
            btn.title = @"";
            
            btn.tag = i;
            
            [btn setTarget:self];
            [btn setAction:@selector(toolBarResponse:)];
            
            [_toolBarView addSubview:btn];
        }
        
        NSBaseButton *changeViewBtn = [[NSBaseButton alloc]initWithFrame:NSMakeRect(30, 12, 16, 16)];
        changeViewBtn.hasBorder = NO;
        changeViewBtn.backgroundNormalColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"icon_32_gongge"]];
        changeViewBtn.title = @"";
        [changeViewBtn setTarget:self];
        [changeViewBtn setAction:@selector(changeView:)];
        [_toolBarView addSubview:changeViewBtn];
        
    }
    return _toolBarView;
}















@end
