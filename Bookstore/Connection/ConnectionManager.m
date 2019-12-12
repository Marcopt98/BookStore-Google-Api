//
//  ConnectionManager.m
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"

@implementation ConnectionManager

+(void) getItens:(NSString *)url completionHandler:(void (^)(id))completion{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", [responseObject objectForKey:@"items"]);
        completion(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil);
    }];
}


@end
