//
//  ViewController.h
//  skyDecoder
//
//  Created by Eiichi Hayashi on 2017/12/10.
//  Copyright © 2017年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@end

