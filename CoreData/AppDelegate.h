//
//  AppDelegate.h
//  CoreData
//
//  Created by User on 4/11/18.
//  Copyright © 2018 DEL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class DataController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataController *dataController;

@end

