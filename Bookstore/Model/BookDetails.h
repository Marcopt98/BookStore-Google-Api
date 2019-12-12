//
//  BookDetails.h
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookDetails : NSObject

@property(strong,nonatomic) NSString *selfLink,*Sinopse,*Author,*Image,*Title, *Preview,*Categories;
@property(nonatomic,assign) int pageCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void) getSingleBook:(void (^)(BookDetails *))completion;

@end

NS_ASSUME_NONNULL_END
