//
//  AppDelegate.h
//  color
//
//  Created by 曾晋哲 on 2017/1/16.
//  Copyright © 2017年 曾晋哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

