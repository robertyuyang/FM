//
//  AuthorData.h
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorData : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* nickName;
@property (nonatomic, strong) NSString* imgUrl;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, strong) NSArray* albums;
@end
