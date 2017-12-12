//
//  DetailViewController.m
//  skyDecoder
//
//  Created by Eiichi Hayashi on 2017/12/11.
//  Copyright © 2017年 skyElements. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize selectedData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = selectedData[@"abbreviation"];
    
    _detailTextView.text = [NSString stringWithFormat:@"%@\n\n%@", selectedData[@"decoded_text"], selectedData[@"supplement"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
