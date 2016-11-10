//
//  audioFileURL.h
//  MyFM
//
//  Created by mac on 11/2/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface audioFileURL : NSObject


@property (nonatomic, strong) NSString* url;

- (instancetype) initWithUrl: (NSString*)url;
- (NSURL *)audioFileURL;
@end
