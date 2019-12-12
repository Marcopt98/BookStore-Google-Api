//
//  Book.h
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject


@property(strong,nonatomic) NSString *Title;
@property(strong,nonatomic) NSString *Image;
@property(strong,nonatomic) NSString *Date;
@property(strong,nonatomic) NSString *URL;
@property int *maxItems;

-(void) getBooks:(void (^)(NSMutableArray *))completion;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
