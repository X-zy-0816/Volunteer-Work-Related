//
//  ViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/26.
//

#import "ViewController.h"
@import GoogleSignIn;
#import <GTLRYouTube.h>

@interface ViewController ()<GIDSignInDelegate, GIDSignInUIDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Configure Google Sign-in.
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeYouTubeReadonly, nil];
    [signIn signInSilently];




}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.service.authorizer = nil;
    } else {
        self.signInButton.hidden = true;
        self.output.hidden = false;
        self.service.authorizer = user.authentication.fetcherAuthorizer;
        [self fetchChannelResource];
    }
}


// Construct a query and retrieve the channel resource for the GoogleDevelopers
// YouTube channel. Display the channel title, description, and view count.
- (void)fetchChannelResource {
    GTLRYouTubeQuery_ChannelsList *query =
    [GTLRYouTubeQuery_ChannelsList queryWithPart:@"snippet,statistics"];
  query.identifier = @"UC_x5XG1OV2P6uZZ5FSM9Ttw";
  // To retrieve data for the current user's channel, comment out the previous
  // line (query.identifier ...) and uncomment the next line (query.mine ...).
  // query.mine = true;

  [self.service executeQuery:query
                    delegate:self
           didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}




@end
