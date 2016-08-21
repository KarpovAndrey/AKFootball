//
//  AKFootballConstants.h
//  AKFootball
//
//  Created by Admin on 17.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#ifndef AKFootballConstants_h
#define AKFootballConstants_h

#define kAKAuthToken @{@"X-Auth-Token": @"f39e518c66d64efd9443fc5e8cef9c3a"}

static NSString * const kAKMomName                       = @"AKFootball";
static NSString * const kAKAllertControllerTitle         = @"No Interner Connection";
static NSString * const kAKAllertControllerMessage       = @"Make sure your device is connected to the internet";
static NSString * const kAKActionTitle                   = @"OK";
static NSString * const kAKLeftBarBattonImageName        = @"BackButton";
static NSString * const kAKRightBarBattonImageName       = @"logo";
static NSString * const kAKNavigationItemTitle           = @"TITLE";
static NSString * const kAKMatchesNavigationItemTitle    = @"MATCHES";
static NSString * const kAKTeamsNavigationItemTitle      = @"TEAMS";
static NSString * const kAKTournamentNavigationItemTitle = @"TOURNAMENT";
static NSString * const kAKLeaguesNavigationItemTitle    = @"LEAGUES";
static NSString * const kAKFinishedMatchesTitle          = @"FINISHED MATCHES";
static NSString * const kAKSheduledMatchesTitle          = @"SHEDULED MATCHES";
static NSString * const kAKNoLogoImageName               = @"noLogo";

static NSString * const kAKSeasonsURLString     = @"http://api.football-data.org/v1/soccerseasons/?season=";
static NSString * const kAKFootballURLString    = @"http://api.football-data.org/v1/soccerseasons/";

static NSString * const kAKHTTPMethod                 = @"GET";
static NSString * const kAKFootballSeasonString       = @"FOOTBALL Season";
static NSString * const kAKYearString                 = @"YEAR";
static NSUInteger const kAKYearInterval               = 1;
static NSString * const kAKDateFormat                 = @"yyyy";
static NSString * const kAKRefreshDateFormat          = @"MMM d, h:mm a";
static NSString * const kAKRefreshString              = @"Last update: %@";
static NSString * const kAKFontName                   = @"HelveticaNeue-BoldItalic";
static NSUInteger const kAKFontSize                   = 20;
static NSUInteger const kAKMatchDateSubstring         = 10;
static NSUInteger const kAKImageSubstringFull         = 4;
static NSUInteger const kAKImageSubstringShort        = 3;
static NSUInteger const kAKHeaderTableViewFontSize    = 19.0;
static NSUInteger const kAKTeamsControllerNumber      = 0;
static NSUInteger const kAKMatchesControllerNumber    = 1;
static NSUInteger const kAKTournamentControllerNumber = 2;

//Context constants
static NSString * const kAKFinishedMatchesKey   = @"FINISHED MATCHES";
static NSString * const kAKShedulededMatchesKey = @"SHEDULED MATCHES";
static NSString * const kAKMatchesKey           = @"matches";
static NSString * const kAKTitleKey             = @"title";
static NSString * const kAKYearKey              = @"year";
static NSString * const kAKCaptionKey           = @"caption";
static NSString * const kAKNameKey              = @"name";
static NSString * const kAKIDKey                = @"id";
static NSString * const kAKTeamsKey             = @"teams";
static NSString * const kAKLinksKey             = @"_links";
static NSString * const kAKSelfKey              = @"self";
static NSString * const kAKHrefKey              = @"href";
static NSString * const kAKCrestURLKey          = @"crestUrl";
static NSString * const kAKFixturesKey          = @"fixtures";
static NSString * const kAKResultKey            = @"result";
static NSString * const kAKDateKey              = @"date";
static NSString * const kAKHomeTeamNameKey      = @"homeTeamName";
static NSString * const kAKAwayTeamNameKey      = @"awayTeamName";
static NSString * const kAKStatusKey            = @"status";
static NSString * const kAKFinishedKey          = @"FINISHED";
static NSString * const kAKGoalsAwayTeamNameKey = @"goalsAwayTeam";
static NSString * const kAKGoalsHomeTeamNameKey = @"goalsHomeTeam";
static NSString * const kAKStandingKey          = @"standing";
static NSString * const kAKPointsKey            = @"points";
static NSString * const kAKTeamKey              = @"team";
static NSString * const kAKPositionKey          = @"position";
static NSString * const kAKTeamsPathKey         = @"/teams";
static NSString * const kAKFixturesPathKey      = @"/fixtures";
static NSString * const kAKLeagueTablePathKey   = @"/leagueTable";
static NSString * const kAKSVGString            = @"svg";

#endif /* AKFootballConstants_h */
