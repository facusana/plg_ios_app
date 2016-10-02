//
//  Tournament.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Tournament.h"

NSString * const kTournamentIDKey = @"id";
NSString * const kTournamentNameKey = @"name";
NSString * const kTournamentIsActiveKey = @"isActive";
NSString * const kTournamentCreatedDateKey = @"createdDate";

@implementation Tournament

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.name = dictInfo[kTournamentNameKey];
            self.id = dictInfo[kTournamentIDKey];
            self.isActive = [(NSNumber *)dictInfo[kTournamentIsActiveKey] boolValue];
            self.createdDate = dictInfo[kTournamentCreatedDateKey];
        }
    }
    
    return self;
}

@end
