//
//  Team.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Team.h"
#import "Tactic.h"

NSString * const kTeamIDKey = @"id";
NSString * const kTeamNameKey = @"name";
NSString * const kTeamCreatedDateKey = @"createdDate";
NSString * const kTeamIsActiveKey = @"isActive";
NSString * const kTeamPositionKey = @"position";
NSString * const kTeamPointsKey = @"points";
NSString * const kTeamGamesPlayedKey = @"gamesPlayed";
NSString * const kTeamWinsKey = @"wins";
NSString * const kTeamTiesKey = @"ties";
NSString * const kTeamLossesKey = @"losses";
NSString * const kTeamGoalsForKey = @"goalsFor";
NSString * const kTeamGoalsAgainstKey = @"goalsAgainst";
NSString * const kTeamGoalDifferenceKey = @"goalDifference";
NSString * const kTeamAvgGoalForPerMatchKey = @"avgGoalForPerMatch";
NSString * const kTeamavgGoalAgainstPerMatchKey = @"avgGoalAgainstPerMatch";
NSString * const kTeamTacticKey = @"tactic";

@implementation Team

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.id = dictInfo[kTeamIDKey];
            self.name = dictInfo[kTeamNameKey];
            self.createdDate = dictInfo[kTeamCreatedDateKey];
            self.isActive = [(NSNumber *)dictInfo[kTeamIsActiveKey] boolValue];
            self.position = dictInfo[kTeamPositionKey];
            self.points = dictInfo[kTeamPointsKey];
            self.gamesPlayed = dictInfo[kTeamGamesPlayedKey];
            self.wins = dictInfo[kTeamWinsKey];
            self.ties = dictInfo[kTeamTiesKey];
            self.losses = dictInfo[kTeamLossesKey];
            self.goalsFor = dictInfo[kTeamGoalsForKey];
            self.goalsAgainst = dictInfo[kTeamGoalsAgainstKey];
            self.goalDifference = dictInfo[kTeamGoalDifferenceKey];
            self.avgGoalForPerMatch = dictInfo[kTeamAvgGoalForPerMatchKey];
            self.avgGoalAgainstPerMatch = dictInfo[kTeamavgGoalAgainstPerMatchKey];
            self.tactic = [[Tactic alloc] initWithDictionary: dictInfo[kTeamTacticKey]];
        }
    }
    return self;
}

@end
