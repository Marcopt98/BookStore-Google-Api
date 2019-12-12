//
//  BookDetails.m
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "BookDetails.h"
#import "ConnectionManager.h"

@implementation BookDetails
@synthesize selfLink,Title,Image,Author,Sinopse, Preview, Categories, pageCount;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) { //consulta json
        
        id volumeInfo = [dictionary objectForKey:@"volumeInfo"];
        if([volumeInfo valueForKey:@"title"]){
            self.Title  = [volumeInfo objectForKey:@"title"];
        }else{
            self.Title = @"N/A";
        }
        
        id imageLinks = [volumeInfo objectForKey:@"imageLinks"];
        if([imageLinks valueForKey:@"thumbnail"]){
            self.Image = [imageLinks objectForKey:@"thumbnail"];
        }
         
         if([volumeInfo valueForKey:@"description"]){
             self.Sinopse = [volumeInfo objectForKey:@"description"];
         }else{
             self.Sinopse = @"N/A";
         }
        
        
        if([volumeInfo valueForKey:@"authors"]){
            NSArray *authors = [volumeInfo objectForKey:@"authors"];
            NSString *combinedAuthors;
            
            combinedAuthors = [authors objectAtIndex:0];
            
           if(authors.count > 1){
               int i = 1;
               while (i < authors.count) {
                   [combinedAuthors stringByAppendingFormat:@", %@", [authors objectAtIndex: i]];
                   i++;
               }
            }
            
            self.Author = combinedAuthors;
            
        }else{
            self.Author = @"N/A";
        }
        
        
        if([volumeInfo valueForKey:@"previewLink"]){
            self.Preview = [volumeInfo objectForKey:@"previewLink"];
        }else{
            self.Preview = nil;
        }
        
        if([volumeInfo valueForKey:@"pageCount"]){
            self.pageCount = [[volumeInfo objectForKey:@"pageCount"] intValue];
        }else{
            self.pageCount = 0;
        }
        
        
        if([volumeInfo valueForKey:@"categories"]){
            NSArray *categories = [volumeInfo objectForKey:@"categories"];
            NSString *categorieName;
            
            categorieName = [categories objectAtIndex:0];
            
            if(categories.count > 1){
                int i = 1;
                while (i < categories.count) {
                    [categorieName stringByAppendingFormat:@", %@", [categories objectAtIndex: i]];
                    i++;
                }
                
            }
            
            self.Categories = categorieName;
            
            
        }else{
            self.Categories = @"N/A";
        }
        
        
    }
    return self;
}



-(void) getSingleBook:(void (^)(BookDetails *))completion{
    
    [ConnectionManager getItens:self.selfLink completionHandler:^(id result) {
        if (result) {
            completion(result);
        }else{
            completion(nil);
        }
    }];
    
    
}

@end
