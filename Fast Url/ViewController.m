//
//  ViewController.m
//  Fast Url
//
//  Created by joe feng on 2015/12/8.
//  Copyright © 2015年 joe feng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGRect fullScreenRect;
    UITextField *field;
    NSURL *contentURL;
}

-(void) updateurl: (UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fullScreenRect=[[UIScreen mainScreen] bounds];

    NSURL *appGroupDirectoryPath = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.fastUrlSharedDefaults"];
    contentURL = [appGroupDirectoryPath URLByAppendingPathComponent:@"url.txt"];

    NSString *myURL = [NSString stringWithContentsOfURL:contentURL
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];
    if ([myURL length] == 0 ) {
        myURL = @"https://www.apple.com";
    }

    field = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, fullScreenRect.size.width, 50)];
    field.backgroundColor = [UIColor grayColor];
    field.text = myURL;
    field.textColor = [UIColor whiteColor];
    [self.view addSubview:field];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, fullScreenRect.size.width, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"Update" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(updateurl:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}

-(void) updateurl: (UIButton *)sender {
    NSString *str = field.text;
    [str writeToURL:contentURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [field resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
