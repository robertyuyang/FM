//
//  audioFileURL.m
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "audioFileURL.h"

@implementation audioFileURL

- (instancetype) initWithUrl: (NSString*)url {
    self.url = url;
    return self;
}

- (NSURL *)audioFileURL {
    return [NSURL URLWithString: self.url];
}

@end
