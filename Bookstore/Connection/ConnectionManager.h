//
//  ConnectionManager.h
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectionManager : NSObject

+(void)getItens:(NSString *)url completionHandler:(void(^)(id result))completion;


@end

NS_ASSUME_NONNULL_END
