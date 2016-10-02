//
//  Player.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 14.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Player.h"

NSString * const kPlayerNameKey = @"playerName";
NSString * const kPlayerTeamNameKey = @"teamName";
NSString * const kPlayerGoalsKey = @"goals";

@implementation Player

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.teamName = dictInfo[kPlayerTeamNameKey];
            self.playerName = dictInfo[kPlayerNameKey];
            self.goals = dictInfo[kPlayerGoalsKey];
        }
    }
    return self;
}

@end
