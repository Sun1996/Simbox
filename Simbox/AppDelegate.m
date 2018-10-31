 //
//  AppDelegate.m
//  Simbox
//
//  Created by Sun on 2018/7/3.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeWindow.h"
#import "HomeViewController.h"
#import "UploadWindow.h"
#import "MCUVmsNetSDK.h"
#import "DepartmentData.h"
#import "DetailInfoResult.h"

@interface AppDelegate ()

//@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong) HomeWindow *homeWindow;
@property(nonatomic,strong) UploadWindow *uploadWindow;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [self.homeWindow center];
    [self.homeWindow orderFront:nil];
    
//    [self.uploadWindow center];
//    [self.uploadWindow orderFront:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

-(void)show{
    [self.uploadWindow center];
    [self.uploadWindow orderFront:nil];
}

-(UploadWindow *)uploadWindow{
    if (!_uploadWindow) {
        NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable  ;
        _uploadWindow = [[UploadWindow alloc]initWithContentRect:CGRectMake(0, 0, 440, 480) styleMask:style backing:NSBackingStoreBuffered defer:YES];
        _uploadWindow.title = @"New Window";
    }

    return _uploadWindow;
}

-(NSWindow *)homeWindow{
    if (!_homeWindow) {
        NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable  ;
        _homeWindow = [[HomeWindow alloc]initWithContentRect:CGRectMake(0, 0, 720, 600) styleMask:style backing:NSBackingStoreBuffered defer:YES];
        //        _homeWindow.contentViewController = self.firstVC;
        
        //隐藏titlebar
//        _window1.titlebarAppearsTransparent=YES;
//        _window1.titleVisibility = NSWindowTitleHidden;
//        //titleBar和 contentView 融合到一起
//        _window1.styleMask = _window1.styleMask | NSWindowStyleMaskFullSizeContentView;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        [[MCUVmsNetSDK shareInstance]getDaptWithParams:nil success:^(NSDictionary *json) {
            NSInteger status = [json[@"code"] integerValue];
            NSDictionary *data = json[@"data"];
            if(status == 200){
                for (int i = 0; i < data.count ; i++){
                    DepartmentData *deptData = [[DepartmentData alloc]init];
                    deptData.departmentID = [json[@"data"][i][@"id"] integerValue];
                    deptData.name = json[@"data"][i][@"name"];
                    
                    [dataArray addObject:deptData];
                }
                
                HomeViewController * homeVC = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
                homeVC.departmentDataArray = dataArray;
//                homeVC.detailInfoArray = [self doLoadDataToArray];
                self.homeWindow.contentViewController = homeVC;
            }
        } failure:^(NSError *error) {
            
        }];
    }
    return _homeWindow;
}

-(NSMutableArray *) doLoadDataToArray
{
        NSMutableArray *detailInfoArray = [[NSMutableArray alloc]init];
        
        for (int i =0; i<10; i++)
        {
            DetailInfoResult *item =[[DetailInfoResult alloc]init];
            [item setNodeName:[NSString stringWithFormat:@"parent-%d",i+1]];
            [item setNodeId:@"000"];
            [item setType:1];
            [item setCreateTime:@"2018-05-10 12:30:45"];
            [item setCreator:@"By：jiangjiahuan"];
            [item setIsNew:NO];
            
            if (i<5)
            {
                [item setType:0];
                NSMutableArray *children = [[NSMutableArray alloc]init];
                for (int j = 0; j<3; j++)
                {
                    DetailInfoResult *temp =[[DetailInfoResult alloc]init];
                    [temp setNodeName:[NSString stringWithFormat:@"%@----item-%d",item.nodeName,j+1]];
                    [temp setNodeId:@"111"];
                    [temp setType:1];
                    [temp setCreateTime:@"2018-05-10 12:30:45"];
                    [temp setCreator:@"By：jiangjiahuan"];
                    [temp setIsNew:NO];
                    [children addObject:temp];
                    if (j>0) {
                        [temp setIsNew:YES];
                        [item setIsNew:YES];
                    }
                    
                }
                item.leafArray = children;
            }
            [detailInfoArray addObject:item];
        }
    return detailInfoArray;
}

@end
