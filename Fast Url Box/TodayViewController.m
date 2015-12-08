//
//  TodayViewController.m
//  Fast Url Box
//
//  Created by joe feng on 2015/12/8.
//  Copyright © 2015年 joe feng. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding> {
    NSString *myURL;
    UIButton *btn;
}
-(void) gotourl;

@end

@implementation TodayViewController

-(void) viewWillAppear:(BOOL)animated {
    
    NSURL *appGroupDirectoryPath = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.fastUrlSharedDefaults"];
    NSURL *contentURL = [appGroupDirectoryPath URLByAppendingPathComponent:@"url.txt"];
    
    myURL = [NSString stringWithContentsOfURL:contentURL
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
    if ([myURL length] == 0 ) {
        myURL = @"https://www.apple.com/?failed";
    }

    [btn setTitle:myURL forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(0, 100);

    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"GO" forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(gotourl) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];

}

-(void) gotourl {
    NSURL *url = [NSURL URLWithString:myURL];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"fun=%s after completion. success=%d", __func__, success);
    }];
}

-(UIEdgeInsets) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
