//
//  FirstTableController.m
//  isolateVGParallax
//
//  Created by Aditya Narayan on 11/4/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "FirstTableController.h"
#import "UIScrollView+VGParallaxHeader.h"
#import "HeaderView.h"

@interface FirstTableController ()

@end

@implementation FirstTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HeaderView *headerView = [HeaderView instantiateFromNib];
    
    [self.tableView setParallaxHeaderView:headerView
                                     mode:VGParallaxHeaderModeFill
                                   height:200
                          shadowBehaviour:VGParallaxHeaderShadowBehaviourAppearing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView shouldPositionParallaxHeader];
    
    CGRect frame = self.tableView.frame;
    
    //NSLog(@"TableView:  X = %f, Y = %f",frame.origin.x,frame.origin.y );
    
    //
    NSLog(@"Progress: %f", scrollView.parallaxHeader.progress);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %@", @(section)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %@", @(indexPath.row)];
    
    return cell;
}

@end
