//
//  DetailsViewController.h
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) BookDetails *bookDetails;
@property(strong,nonatomic) NSString *linkForDetails;

@end

NS_ASSUME_NONNULL_END
