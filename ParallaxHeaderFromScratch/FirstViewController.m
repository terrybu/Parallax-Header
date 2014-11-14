//
//  FirstViewController.m
//  ParallaxHeaderFromScratch
//
//  Created by Aditya Narayan on 11/4/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "FirstViewController.h"
#define scrollDistanceUnit 3

@interface FirstViewController () {
    CGFloat imageViewYCoordinate;
    CGFloat tableViewYCoordinate;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.contentSize = self.myView.frame.size;
    self.scrollView.delegate = self;
    
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    imageViewYCoordinate = self.imageView.frame.origin.y;
    tableViewYCoordinate = self.tableView.frame.origin.y;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        float distMoved = scrollView.contentOffset.y;
        imageViewYCoordinate = distMoved/2;
        //imageview's y coordinate will be equal to 1/2 of the distance the scrollview traveled
    
        self.imageView.frame = CGRectMake(0, imageViewYCoordinate, 500, 300);
        self.imageView.alpha = 1 - imageViewYCoordinate/200.0f;
    
        NSLog(@"------------------------------");
        NSLog(@"scrollview offset = %@", NSStringFromCGPoint(scrollView.contentOffset));
        NSLog(@"Distance moved = %f",distMoved);
        NSLog(@"Current imageview frame = %@ \n\n\n", NSStringFromCGRect(self.imageView.frame));
        NSLog(@"Current tableview frame = %@ \n\n\n", NSStringFromCGRect(self.tableView.frame));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %@", @(indexPath.row)];
    
    return cell;
}


@end
