//
//  CostumTableViewCell.h
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CostumTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *CostumImageView;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Date;

@end

NS_ASSUME_NONNULL_END
