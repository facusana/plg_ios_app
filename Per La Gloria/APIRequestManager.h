//
//  APIRequestManager.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FixtureMatchInfo.h"

#define kAPIServerHostUrl @"http://perlagloria.com"
#define kAPIloadCustomerImageByCustomerIdUrl @"/customer/getcustomerimage?customerId="
#define kAPIloadTeamImageUrl @"/team/getteamimage?teamId="
#define kAPIloadFixtureMatchMapImageUrl @"/fixturematch/getnextfixturematchmapimage?teamId="

@interface APIRequestManager : NSObject

+ (void)getCustomersWithCompletion:(void (^)(NSArray *customersArray, NSError *error))completion;
+ (void)getTournamentsForCustomer:(NSNumber *)customerID WithCompletion:(void (^)(NSArray *tournamentsArray, NSError *error))completion;
+ (void)getDivisionsForTournament:(NSNumber *)tournamentID WithCompletion:(void (^)(NSArray *divisionsArray, NSError *error))completion;
+ (void)getTeamsForDivision:(NSNumber *)divisionID WithCompletion:(void (^)(NSArray *teamsArray, NSError *error))completion;
+ (void)getStatisticsForTeam:(NSNumber *)teamID WithCompletion:(void (^)(NSArray *teamsArray, NSError *error))completion;
+ (void)getFixtureMatchInfoForTeam:(NSNumber *)teamID WithCompletion:(void (^)(FixtureMatchInfo *fixtureMatchInfo, NSError *error))completion;
+ (void)getScoresForTeam:(NSNumber *)teamID WithCompletion:(void (^)(NSArray *scoresArray, NSError *error))completion;

@end
