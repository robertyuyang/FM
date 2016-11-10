//
//  Album.h
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, strong) NSString* albumId;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* imgUrl;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, strong) NSArray* tracks;
@property (nonatomic) NSSet<NSString*>* tags;


-(instancetype) initWithJSONString: (NSString*) jsonString;
@end
