//
//  Album.m
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "Album.h"

@interface Album()

@property (nonatomic, readwrite) NSArray* trackArray;

@end

@implementation Album

-(instancetype) initWithJSONString: (NSString*) jsonString {
    [self loadFromJSONString: jsonString];
    return self;
}

-(void) loadFromJSONString: (NSString*) jsonString {
    NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
    
}


@end
