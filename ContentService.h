//
//  ContentService.h
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentService : NSObject


+(ContentService*)sharedObject;
-(void)loadData;
-(NSArray*) getAlbumsByTag: (NSString*) filterTag;

@end
