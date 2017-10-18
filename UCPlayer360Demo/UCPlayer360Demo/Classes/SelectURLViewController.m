//
//  SelectURLViewController.m
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import "SelectURLViewController.h"
#import "PlayerViewController.h"

@interface URLItemData : NSObject

+ (instancetype)itemWithTitle:(NSString *)title url:(NSString *)url;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;

@end

@interface SelectURLViewController ()
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tvItems;
@property (weak, nonatomic) IBOutlet UITextField *tfVideoURL;

@property (strong, nonatomic) NSArray <URLItemData *> *items;

@end

@implementation SelectURLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UC360 player demo";
    [self createItems];
    self.tfVideoURL.text = @"http://d221ncusdt61xh.cloudfront.net/uploads/production/5882f7cbf6ae6c06c3cede94/5184-2874-1587.m3u8";
}

- (IBAction)tapPlay:(id)sender
{
    [self presentPlayerWithURL:self.tfVideoURL.text];
}

- (void)presentPlayerWithURL:(NSString *)url
{
    NSURL *videoURL = [NSURL URLWithString:url];
    if (videoURL != nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PlayerViewController *playerVC = [sb instantiateViewControllerWithIdentifier:[PlayerViewController storyboardIdentifier]];
        [self.navigationController pushViewController:playerVC animated:YES];
        [playerVC configureWithVideoURL:videoURL];
    }
}

- (void)createItems
{
    
    self.items = @[[URLItemData itemWithTitle:@"Le Mans 2016 BR Nissan Tech Team Pit-stop Training"
                                          url:@"http://d221ncusdt61xh.cloudfront.net/uploads/production/5882f0b4f6ae6c06c3cede8d/9813-8174-7867.m3u8"],
                   [URLItemData itemWithTitle:@"Le Mans 2016: LMP1 Podium"
                                          url:@"http://d221ncusdt61xh.cloudfront.net/uploads/production/5882f105f6ae6c06c3cede8e/2778-4960-2285.m3u8"],
                   [URLItemData itemWithTitle:@"Le Mans 2016: Race Start"
                                          url:@"http://d221ncusdt61xh.cloudfront.net/uploads/production/5882f18ff6ae6c06c3cede8f/7090-5557-2185.m3u8"],
                   [URLItemData itemWithTitle:@"FIA Formula E Uruguay 2015 Highlights"
                                          url:@"http://d221ncusdt61xh.cloudfront.net/uploads/production/5882698ff6ae6c06c3cede8c/1811-7238-2671.m3u8"],
                   [URLItemData itemWithTitle:@"FIA Formula E Punta del Este Timelapse"
                                          url:@"http://d221ncusdt61xh.cloudfront.net/uploads/production/58d4c81672036204b3e5aa18/2969-8192-6075.m3u8"]
                   ];

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    URLItemData *item = self.items[indexPath.row];
    [self presentPlayerWithURL:item.url];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"URLCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    URLItemData *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

@end


@implementation URLItemData

+ (instancetype)itemWithTitle:(NSString *)title url:(NSString *)url
{
    URLItemData *item = [URLItemData new];
    item.title = title;
    item.url = url;
    return item;
}

@end
