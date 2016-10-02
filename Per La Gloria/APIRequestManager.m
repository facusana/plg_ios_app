 //
//  APIManager.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "APIRequestManager.h"
#import "AFNetworking.h"
#import "Customer.h"
#import "Tournament.h"
#import "Division.h"
#import "Team.h"
#import "UIImageView+WebCache.h"
#import "Player.h"


#define kAPIloadCustomersUrl @"/customer/getcustomers"
#define kAPIloadCustomerImageByTeamIdUrl @"/customer/getcustomerimagebyteam?teamId="
#define kAPIloadTournamentUrl @"/tournament/gettournaments?customerId="
#define kAPIloadDivisionUrl @"/division/getdivisions?tournamentId="
#define kAPIloadTeamUrl @"/team/getteams?divisionId="
#define kAPIloadFixtureMatchInfoUrl @"/fixturematch/getnextfixturematch?teamId="
#define kAPIloadStatisticsUrl @"/team/getpositionsteams?teamId="
#define kAPIloadScorersUrl @"/division/getstrikers?teamId="

@implementation APIRequestManager

+ (void)requestGET:(NSString *)urlString withCompletion:(void (^)(id response, NSError *error))completion{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask =
    [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            id jsonDic = responseObject;
            completion(jsonDic, nil);
        } }];
    [dataTask resume];
}

+ (void)getCustomersWithCompletion:(void (^)(NSArray *customersArray, NSError *error))completion{
    NSString *requestURL = [kAPIServerHostUrl stringByAppendingString:kAPIloadCustomersUrl];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *customersArray = [[NSMutableArray alloc] init];
            for (NSDictionary *customerDictionary in responseArray) {
                Customer *customer = [[Customer alloc] initWithDictionary:customerDictionary];
                [customersArray addObject:customer];
            }
            completion (customersArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getTournamentsForCustomer:(NSNumber *)customerID WithCompletion:(void (^)(NSArray *tournamentsArray, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadTournamentUrl] stringByAppendingString:customerID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *tournamentsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tournamentDictionary in responseArray) {
                Tournament *tournament = [[Tournament alloc] initWithDictionary:tournamentDictionary];
                [tournamentsArray addObject:tournament];
            }
            completion (tournamentsArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getDivisionsForTournament:(NSNumber *)tournamentID WithCompletion:(void (^)(NSArray *divisionsArray, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadDivisionUrl] stringByAppendingString:tournamentID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *divisionsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *divisionDictionary in responseArray) {
                Division *division = [[Division alloc] initWithDictionary:divisionDictionary];
                [divisionsArray addObject:division];
            }
            completion (divisionsArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getTeamsForDivision:(NSNumber *)divisionID WithCompletion:(void (^)(NSArray *teamsArray, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadTeamUrl] stringByAppendingString:divisionID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *teamsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *teamDictionary in responseArray) {
                Team *team = [[Team alloc] initWithDictionary:teamDictionary];
                [teamsArray addObject:team];
            }
            completion (teamsArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getStatisticsForTeam:(NSNumber *)teamID WithCompletion:(void (^)(NSArray *teamsArray, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadStatisticsUrl] stringByAppendingString:teamID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *teamsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *teamDictionary in responseArray) {
                Team *team = [[Team alloc] initWithDictionary:teamDictionary];
                [teamsArray addObject:team];
            }
            completion (teamsArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getFixtureMatchInfoForTeam:(NSNumber *)teamID WithCompletion:(void (^)(FixtureMatchInfo *fixtureMatchInfo, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadFixtureMatchInfoUrl] stringByAppendingString:teamID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSDictionary *responceDictionary, NSError *error) {
        if (!error) {
            FixtureMatchInfo *fixtureMatchInfo = [[FixtureMatchInfo alloc] initWithDictionary:responceDictionary];
            completion (fixtureMatchInfo, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

+ (void)getScoresForTeam:(NSNumber *)teamID WithCompletion:(void (^)(NSArray *scoresArray, NSError *error))completion{
    NSString *requestURL = [[kAPIServerHostUrl stringByAppendingString:kAPIloadScorersUrl] stringByAppendingString:teamID.stringValue];
    [APIRequestManager requestGET:requestURL withCompletion:^(NSArray *responseArray, NSError *error) {
        if (!error) {
            NSMutableArray *scoresArray = [[NSMutableArray alloc] init];
            for (NSDictionary *teamDictionary in responseArray) {
                Player *player = [[Player alloc] initWithDictionary:teamDictionary];
                [scoresArray addObject:player];
            }
            completion (scoresArray, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}
@end
