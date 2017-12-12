//
//  DetailViewController.h
//  skyDecoder
//
//  Created by Eiichi Hayashi on 2017/12/11.
//  Copyright © 2017年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic) NSDictionary *selectedData;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end
