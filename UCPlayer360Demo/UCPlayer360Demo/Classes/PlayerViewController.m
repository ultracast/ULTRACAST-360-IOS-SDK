//
//  PlayerViewController.m
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import "PlayerViewController.h"
#import <UC360SDK/UC360SDK.h>
#import "UIViewController+Autorotation.h"

@interface PlayerViewController ()
<
UC360PlayerDelegate,
UIViewControllerAutorotation
>

@property (weak, nonatomic) IBOutlet UIView *playerContainer;
@property (weak, nonatomic) IBOutlet UIView *topBarContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomBarContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aivLoading;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnPause;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnControlsType;
@property (weak, nonatomic) IBOutlet UIButton *btnVR;
@property (weak, nonatomic) IBOutlet UISlider *timelineSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayedTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalTime;

@property (strong, nonatomic) UC360PlayerViewController *playerVC;
@property (strong, nonatomic) NSURL *videoURL;
@property (assign, nonatomic) UC360PlayerControlType controlsType;
@property (weak, nonatomic) NSTimer *timeUpdateTimer;
@property (assign, nonatomic) BOOL isSeeking;
@property (assign, nonatomic) NSTimeInterval seekTime;

@end

@implementation PlayerViewController

+ (NSString *)storyboardIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPlayer];
    if (self.videoURL != nil) {
        [self configureWithVideoURL:self.videoURL];
    }
    [self.playerVC play];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [self.playerVC cleanup];
}

- (void)configureWithVideoURL:(NSURL *)videoURL
{
    self.videoURL = videoURL;
    if (self.isViewLoaded) {
        [self.playerVC updateVideoURL:videoURL];
    }
}

- (void)initPlayer
{
    self.isSeeking = NO;
    self.timelineSlider.enabled = NO;
    self.controlsType = UC360PlayerControlTypeMotionAndTouch;
    self.playerVC = [UC360PlayerViewController new];
    [self addChildViewController:self.playerVC];
    
    self.playerVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.playerContainer addSubview:self.playerVC.view];
    [self.playerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v]-0-|" options:0 metrics:nil views:@{@"v" : self.playerVC.view}]];
    [self.playerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v]-0-|" options:0 metrics:nil views:@{@"v" : self.playerVC.view}]];
    [self.playerVC didMoveToParentViewController:self];
    
    self.playerVC.delegate = self;
    self.playerVC.controlsType = self.controlsType;
    [self startTimeUpdateTimer];
    [self updateControlsStateBtn];
}

#pragma mark - user input

- (IBAction)tapClose:(id)sender
{
    [self stopTimeUpdateTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapPlay:(id)sender
{
    [self.playerVC play];
}

- (IBAction)tapPause:(id)sender
{
    self.btnPlay.hidden = NO;
    self.btnPause.hidden = YES;
    [self.playerVC pause];
}

- (IBAction)tapVR:(id)sender
{
    if ([self isPhone] && [self isInPortraitOrientation]) {
        [self rotateToLandscapeorientation];
    }
    BOOL enable = !self.playerVC.isVREnabled;
    [self.playerVC enableVR:enable];
}

- (IBAction)tapControlsType:(id)sender
{
    [self displayControlsTypeSelector:^(UC360PlayerControlType type) {
        self.controlsType = type;
        self.playerVC.controlsType = self.controlsType;
        [self updateControlsStateBtn];
    }];
}

- (IBAction)startSeeking:(UISlider *)sender
{
    [self.playerVC pause];
    self.isSeeking = YES;
}

- (IBAction)finishSeeking:(UISlider *)sender
{
    self.isSeeking = NO;
    self.seekTime = sender.value * self.playerVC.videoDuration;
    [self.playerVC seek:self.seekTime];
    [self.playerVC play];
}

- (IBAction)didChangeTimelineValue:(UISlider *)sender
{
    self.seekTime = sender.value * self.playerVC.videoDuration;
}

#pragma mark - UC360PlayerDelegate

- (void)uc360Player:(UC360PlayerViewController *)player stateChanged:(UC360PlayerPlaybackState)state
{
    switch (state) {
        case UC360PlayerPlaybackStatePrepearing: {
            [self.aivLoading startAnimating];
            self.btnPlay.hidden = YES;
            self.btnPause.hidden = YES;
            self.aivLoading.hidden = NO;
            self.timelineSlider.enabled = NO;
            self.lblTotalTime.alpha = 0.5;
            self.lblPlayedTime.alpha = 0.5;
        } break;
        case UC360PlayerPlaybackStateReadyToPlay: {
            self.btnPlay.hidden = NO;
            self.btnPause.hidden = YES;
            self.lblTotalTime.alpha = 1.;
            self.lblPlayedTime.alpha = 1.;
            self.lblTotalTime.text = [self formattedTime:self.playerVC.videoDuration];
            self.timelineSlider.enabled = YES;
        } break;
        case UC360PlayerPlaybackStateLoading: {
            [self.aivLoading startAnimating];
            self.aivLoading.hidden = NO;
            self.btnPlay.hidden = NO;
            self.btnPause.hidden = YES;
        } break;
        case UC360PlayerPlaybackStatePlaying: {
            self.aivLoading.hidden = YES;
            [self.aivLoading stopAnimating];
            self.btnPlay.hidden = YES;
            self.btnPause.hidden = NO;
        } break;
        case UC360PlayerPlaybackStateStopped: {
            self.btnPlay.hidden = NO;
            self.btnPause.hidden = YES;
        } break;
        case UC360PlayerPlaybackStateFinished: {
            self.btnPlay.hidden = NO;
            self.btnPause.hidden = YES;
        } break;
        case UC360PlayerPlaybackStateUnknown: {
            self.btnPlay.hidden = NO;
            self.btnPause.hidden = YES;
        } break;
        default:
            break;
    }
}

- (void)uc360Player:(UC360PlayerViewController *)player playbackError:(UC360Error *)error
{
    [self displayMessage:error.localizedDescription];
}

- (void)uc360Player:(UC360PlayerViewController *)player networkError:(NSError *)error
{
    [self displayMessage:error.localizedDescription];
}

#pragma mark - update timer

- (void)startTimeUpdateTimer
{
    [self stopTimeUpdateTimer];
    self.timeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTimerTick) userInfo:nil repeats:YES];
}

- (void)stopTimeUpdateTimer
{
    if (self.timeUpdateTimer != nil) {
        if ([self.timeUpdateTimer isValid]) {
            [self.timeUpdateTimer invalidate];
        }
        self.timeUpdateTimer = nil;
    }
}

- (void)updateTimerTick
{
    if (self.isSeeking) {
        self.lblPlayedTime.text = [self formattedTime:self.seekTime];
    } else {
        self.lblPlayedTime.text = [self formattedTime:self.playerVC.playbackTime];
        float sliderValue = self.playerVC.playbackTime / self.playerVC.videoDuration;
        self.timelineSlider.value = sliderValue;
    }
}

#pragma mark - utils

- (void)displayMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {}];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)displayControlsTypeSelector:(void (^)(UC360PlayerControlType type))callback
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contols type" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Motion" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                    if (callback != nil) {
                                        callback(UC360PlayerControlTypeMotion);
                                    }
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Touch" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                    if (callback != nil) {
                                        callback(UC360PlayerControlTypeTouch);
                                    }
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Motion+Touch" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                    if (callback != nil) {
                                        callback(UC360PlayerControlTypeMotionAndTouch);
                                    }
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
    popPresenter.sourceView = self.btnControlsType;
    popPresenter.sourceRect = self.btnControlsType.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)updateControlsStateBtn
{
    NSString *msg = @"";
    switch (self.playerVC.controlsType) {
        case UC360PlayerControlTypeMotion:
            msg = @"Motion";
            break;
        case UC360PlayerControlTypeTouch:
            msg = @"Touch";
            break;
        case UC360PlayerControlTypeMotionAndTouch:
            msg = @"M+T";
            break;
        default:
            msg = @"Unknown";
            break;
    }
    [self.btnControlsType setTitle:msg forState:UIControlStateNormal];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSString *)formattedTime:(long)totalSeconds
{
    long seconds = totalSeconds % 60;
    long minutes = (totalSeconds / 60) % 60;
    long hours = totalSeconds / 3600;
    NSString *result = @"";
    if (hours > 0) {
        result = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
    } else  {
        result = [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    }
    return result;
}

- (BOOL)isInPortraitOrientation
{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown;
}

- (void)rotateToLandscapeorientation
{
    if ([[UIApplication sharedApplication] statusBarOrientation] != UIInterfaceOrientationLandscapeLeft && [[UIApplication sharedApplication] statusBarOrientation] != UIInterfaceOrientationLandscapeRight) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
}

- (BOOL)isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

#pragma mark - UIViewControllerAutorotation

- (UIInterfaceOrientationMask)interfaceOrientationMask
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)canAutoRotate
{
    return ![self.playerVC isVREnabled];
}

@end
