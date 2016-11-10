//
//  Author.h
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthorData.h"

@interface Author : AuthorData

@property (nonatomic, strong, readonly) NSArray* followers;
@property (nonatomic, strong, readonly) NSArray* followings;

@end
