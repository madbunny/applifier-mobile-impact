//
//  ApplifierImpactViewController.m
//  ImpactProto
//
//  Created by bluesun on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplifierImpactViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <ApplifierImpact/ApplifierImpact.h>

@interface ApplifierImpactViewController () <ApplifierImpactDelegate>
@end

@implementation ApplifierImpactViewController

@synthesize buttonView;
@synthesize contentView;
@synthesize currentPhase;
@synthesize avPlayer;
@synthesize avPlayerLayer;
@synthesize avAsset;
@synthesize avPlayerItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[ApplifierImpact sharedInstance] setDelegate:self];
	
    [self.buttonView addTarget:self action:@selector(nextPhase) forControlEvents:UIControlEventTouchUpInside];
	[self.buttonView setImage:[UIImage imageNamed:@"impact-waiting"] forState:UIControlStateNormal];
}

- (void)nextPhase
{
	if ([[ApplifierImpact sharedInstance] canShowImpact])
	{
		NSLog(@"Showing Impact.");
		UIView *adView = [[ApplifierImpact sharedInstance] impactAdView];
		adView.frame = self.view.bounds;
		[self.view addSubview:adView];
	}
	else
		NSLog(@"Impact cannot be shown.");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - ApplifierImpactDelegate

- (void)applifierImpact:(ApplifierImpact *)applifierImpact completedVideoWithRewardItemKey:(NSString *)rewardItemKey
{
	NSLog(@"applifierImpact:completedVideoWithRewardItem: -- key: %@", rewardItemKey);
}

- (void)applifierImpactWillOpen:(ApplifierImpact *)applifierImpact
{
	NSLog(@"applifierImpactWillOpen");
}

- (void)applifierImpactWillClose:(ApplifierImpact *)applifierImpact
{
	NSLog(@"applifierImpactWillClose");
}

- (void)applifierImpactVideoStarted:(ApplifierImpact *)applifierImpact
{
	NSLog(@"applifierImpactVideoStarted");
}

- (void)applifierImpactCampaignsAreAvailable:(ApplifierImpact *)applifierImpact
{
	NSLog(@"applifierImpactCampaignsAreAvailable");

	[self.buttonView setImage:[UIImage imageNamed:@"impact-ready"] forState:UIControlStateNormal];
}

- (UIViewController *)viewControllerForPresentingViewControllersForImpact:(ApplifierImpact *)applifierImpact
{
	NSLog(@"viewControllerForPresentingViewControllersForImpact");
	
	return self;
}

@end