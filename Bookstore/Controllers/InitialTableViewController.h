//
//  InitialTableViewController.h
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface InitialTableViewController : UIViewController

@property (readwrite, retain) NSMutableArray *books;
@property (strong, nonatomic) Book *book;
@property (strong, nonatomic) NSString *lastSearch;


-(void) startAppFromLastSearch:(NSString *)lastSearch;

@end

NS_ASSUME_NONNULL_END
