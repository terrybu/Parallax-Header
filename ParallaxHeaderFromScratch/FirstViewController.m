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
    
    NSMutableArray* dataArray;
    
    CGFloat heightTableRow;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //we are going to explicity set a table row height
    heightTableRow = 54;
    
    //Fill an array with some data
    dataArray = [[NSMutableArray alloc]init];
    for (int i=0; i <= 100; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"%d hi", i]];
    }
    [self.tableView reloadData];
    
    
    
    self.scrollView.contentSize = self.myView.frame.size;
    self.scrollView.delegate = self;
    
    self.tableView.scrollEnabled = NO;
    //be aware of this. Maybe you can allow tableview scrolling after a certain point?
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    imageViewYCoordinate = self.imageView.frame.origin.y;
    tableViewYCoordinate = self.tableView.frame.origin.y;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
}

- (void)viewDidLayoutSubviews {
    double dynamicHeight = (heightTableRow * dataArray.count) + 500; //the 500 number is just padding. If we don't have this padding, some rows in the bottom will get hidden which sucks. We can adjust this value to determine how much whitespace we have after the very last row with data
    
    self.tableView.frame = CGRectMake(0, 300, 600, dynamicHeight);
    self.myView.frame = CGRectMake(0,0,600, dynamicHeight);
    self.scrollView.contentSize = self.myView.frame.size;
    NSLog(@"tableview frame: %@", NSStringFromCGRect(self.tableView.frame));
    NSLog(@"innerView frame: %@", NSStringFromCGRect(self.myView.frame));
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
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightTableRow;
}

@end
