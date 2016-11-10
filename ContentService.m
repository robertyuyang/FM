//
//  ContentService.m
//  MyFM
//
//  Created by mac on 10/28/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "ContentService.h"


#import "Album.h"
#import "Track.h"
#import "Author.h"

@interface ContentService()
@property (nonatomic, strong) NSMutableArray* allAlbums;
@property (nonatomic, strong) NSMutableDictionary* allAuthors;

@end
@implementation ContentService


-(NSMutableArray*)allAlbums {
    if(_allAlbums == nil){
        _allAlbums = [[NSMutableArray alloc] init];
    }
    return _allAlbums;
}

-(NSDictionary*)allAuthors {
    if(_allAuthors == nil) {
        _allAuthors = [[NSMutableDictionary alloc] init];
    }
    return _allAuthors;
}

+(ContentService*)sharedObject {
    static ContentService* _sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[ContentService alloc] init];
    });
    return _sharedObject;
}



-(void) loadData {
    
    NSString* dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType: @"json"];
   
    
    NSData* data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    /*
     "author":
     [
     {"name":"tom","nickName":"汤姆斯陈", "intro":"一个好人", "imgUrl":"http://", "albums":["k2001","dj71"]},
     {"name":"jack","nickName":"老杰克", "intro":"开膛手", "imgUrl":"http://", "albums":["dj71"]}
     ]
     
     albums":
     [
     {"title":"鬼吹灯","intro":"鬼吹灯的简介，简介简介","tags":["有声小说","悬疑","畅销"], "tracks":
     [
     {"title":"第一话 序言", "author":"tom", "duration": 3000, "url": "http://111", "imgUrl": "http://dddd.jpg"},*/
    NSArray* jsAuthors = [dict objectForKey:@"authors"];
    if(jsAuthors != nil) {
        for(NSDictionary *jsAuthor in jsAuthors){
            Author* author = [[Author alloc ] init];
            author.name = [jsAuthor objectForKey: @"name"];
            author.nickName = [jsAuthor objectForKey: @"nickName"];
            author.intro = [jsAuthor objectForKey: @"intro"];
            author.imgUrl = [jsAuthor objectForKey: @"imgUrl"];
            //author.intro = [jsAuthor objectForKey: @"intro"];
            
            
            [self.allAuthors setValue: author forKey: author.name];
        }
    }
    
    NSArray* jsAlbums = [dict objectForKey:@"albums"];
    if(jsAlbums !=nil) {
        for(NSDictionary* jsAlbum in jsAlbums) {
            if(![jsAlbum isKindOfClass:[NSDictionary class]]){
                continue;
            }
            
            Album* album = [[Album alloc] init];
            album.albumId = [jsAlbum objectForKey: @"id"];
            album.title = [jsAlbum objectForKey: @"title"];
            album.imgUrl = [jsAlbum objectForKey: @"imgUrl"];
            album.intro = [jsAlbum objectForKey: @"intro"];
            album.tags = [[NSSet alloc] initWithArray:[jsAlbum objectForKey: @"tags"]];
            NSArray* jsTracks = [jsAlbum objectForKey: @"tracks"];
            NSMutableArray* tracks = [[NSMutableArray alloc] initWithCapacity:[jsTracks count]];
            for(NSDictionary* jsTrack in jsTracks){
                Track* track = [[Track alloc] init];
                track.title = [jsTrack objectForKey: @"title"];
                
                NSString* authorName = [jsTrack objectForKey: @"author"];
                if(self.allAuthors) {
                    track.author = [self.allAuthors objectForKey: authorName];
                }
                track.duration = [[jsTrack objectForKey: @"duration"] intValue];
                track.url = [jsTrack objectForKey: @"url"];
                track.imgUrl = [jsTrack objectForKey: @"imgUrl"];
                
                [tracks addObject:track];
            }
            album.tracks = [tracks copy];
            
            [self.allAlbums addObject:album];
        }
    }
    
}
-(NSArray*) getAlbumsByTag: (NSString*) filterTag {
   
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for(Album* album in self.allAlbums) {
        if([album.tags containsObject: filterTag]) {
            [result addObject: album];
        }
    }
    return [result copy];
}

@end
