//
//  AppDelegate.h
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong,nonatomic) NSString *resultToSave,*lastSearchResult;

- (void)saveContext;


@end

