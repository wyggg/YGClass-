//
//  ViewController.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "ViewController.h"
#import "YGClassCollection.h"
#import <objc/runtime.h>
#import "YGObjectModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"按钮重复点击测试" forState:0];
    button.acceptEventInterval = 1;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [button addTargetInBlockEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        NSLog(@"%@",[NSDate dateStringByUnixTimeStamp:[NSDate date].timeIntervalSince1970 formatStr:YGDateFormatStr_4]);
    }];
    
//    [self.view addBottomDottedLineLintH:1 color:[UIColor redColor] lengths:@"5,2" left:10 right:10 bottom:10];
    
    
//    cccColor();
    
//    NSArray *array = @[[NSNull null],
//                       @"123",
//  @{@"kkk":[NSNull null],
//    @"Array":@[[NSNull null],
//               @"哈哈哈"]}];
//    NSArray *towArray = [array removeAllNull];
//    NSLog(@"%@",towArray);
    
//    //数据分类
//    NSMutableArray *mArray = [NSMutableArray array];
//    for (int i=0; i<100; i++) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"Key"];
//        [mArray addObject:dic];
//    }
//    YLog1(@"数组分类 %@",[mArray classificationWithKey:@"Key"]);
//    
//    ///对象模型互转
//    NSDictionary *dic = @{@"id":@"=",
//                          @"age":@(100),
//                          @"name":@[@{@"name":@1},@{@"name":@2},@{@"name":@3}],
//                          @"hahaha":@{@"name":@1},
//                          @"color":[UIColor orangeColor]};
//    YGObjectModel *model = [YGObjectModel parsingObj:dic];
//    NSDictionary *vDic = model.objValues;
//    
//    YLog(@"%@",vDic.dicValues);
//    YGObjectModel *arrModel = [YGObjectModel parsingObj:@{@"name":[NSNull null]}];
//    NSDictionary *diccc = [arrModel dicValues];
//    
//    NSLog(@"%@",diccc);
////    YLog(@"%@", [arrModel objValues]);
//    NSLog(@"%@", arrModel);
//    
//    
//    
//    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
//    CFRunLoopStop(runLoopRef);
//    CFRunLoopRun();
//    
//
//
//    [UIWindow mainWindow];
//    [UIWindow rootViewController];
//    
//    self.view.backgroundColor = [UIColor colorWithImageTheme:[UIImage imageNamed:@"123.jpg"]];
//    self.view.backgroundColor = [UIImage imageNamed:@"123.jpg"].mostColor;
//    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(100, 100, 200, 200);
//    button.backgroundColor = [UIColor orangeColor];
//    [button setTitle:@"112233" forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    
//    [button addTargetInBlockEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
//        NSLog(@"123");
//    }];
//    
//
//    NSString *titleStr = @"T O O L  C l A S S";
//    
//    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"123.jpg"];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
//    
////    imageView.image = [imageView.image compressToQuality:0.1];
//    imageView.image = [imageView.image grayImage];
//    [self.view addSubview:imageView];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    label.text = titleStr;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont boldSystemFontOfSize:30];
//    label.frame = CGRectMake(0, 0, kScreenW, [titleStr textSize:CGSizeMake(200, 0) fontSize:30].height);
//    label.bottom = self.view.bottom-30;
//    [label setCornerRadius:8 byRoundingCorners:(UIRectCornerTopLeft|
//                                                UIRectCornerTopRight|
//                                                UIRectCornerBottomLeft)];
//    label.userInteractionEnabled = YES;
//    [label addTarget:self action:@selector(hahahahah)];
//    label.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:label];
//
//    YLog(@"%ld",(long)[NSDate dayInYears:2015 month:2]);
//    YLog(@"%@",[[NSDate dateWithTimeIntervalSince1970:1473819697] dateByFormatString:YGDateFormatStr_1]);
//    UIView *ygView = [UIView viewFromNibName:@"YGView"];
//    ygView.frame = self.view.bounds;
//    [self.view addSubview:ygView];
    
    
}

- (void)hahahahah{
    YLog(@"112233");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
