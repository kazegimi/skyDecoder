//
//  AppDelegate.h
//  skyDecoder
//
//  Created by Eiichi Hayashi on 2017/12/10.
//  Copyright © 2017年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

