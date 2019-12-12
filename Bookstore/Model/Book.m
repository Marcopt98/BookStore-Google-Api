//
//  Book.m
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "Book.h"
#import "ConnectionManager.h"

@implementation Book
@synthesize Title,Image,Date,URL,maxItems;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) { //consulta json
        
        id volumeInfo = [dictionary objectForKey:@"volumeInfo"];
        
        if([volumeInfo valueForKey:@"title"]){
            self.Title  = [volumeInfo objectForKey:@"title"];
        }else{
            self.Title = @"N/A";
        }
        
        if([volumeInfo valueForKey:@"publishedDate"]){
            self.Date = [volumeInfo objectForKey:@"publishedDate"];
        }else{
            self.Date = @"N/A";
        }
        
        id imageLinks = [volumeInfo objectForKey:@"imageLinks"];
        
        if([imageLinks valueForKey:@"smallThumbnail"]){
            self.Image = [imageLinks objectForKey:@"smallThumbnail"];
        }
    
    }
    return self;
}


-(void) getBooks:(void (^)(NSMutableArray *))completion{
    
    [ConnectionManager getItens:self.URL completionHandler:^(id result) {
        if (result) {
            self.maxItems = [[result  objectForKey:@"totalItems"] intValue];
            completion((NSMutableArray *)[result  objectForKey:@"items"]);
        }else{
            completion(nil);
        }
    }];
    
    
}

@end
