//
//  ViewController.m
//  skyDecoder
//
//  Created by Eiichi Hayashi on 2017/12/10.
//  Copyright © 2017年 skyElements. All rights reserved.
//

#import "ViewController.h"

#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *datasArray;
    NSMutableArray *filteredDatasMutableArray;
    NSArray *sortDescriptorsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"skyDecoder";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"abbreviations" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    datasArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    filteredDatasMutableArray = [NSMutableArray new];
    // ソート対象となるキーを指定した、NSSortDescriptorの生成
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"abbreviation" ascending:YES selector:@selector(localizedStandardCompare:)];
    // NSSortDescriptorは配列に入れてNSArrayに渡す
    sortDescriptorsArray = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [_searchBar becomeFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self reloadData];
}

- (void)reloadData {
    NSMutableArray *predicatesArray = [NSMutableArray array];
    [predicatesArray addObject:[NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@", @"abbreviation", _searchBar.text]];
    [predicatesArray addObject:[NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@", @"decoded_text", _searchBar.text]];
    
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicatesArray];
    filteredDatasMutableArray = [NSMutableArray arrayWithArray:[datasArray filteredArrayUsingPredicate:predicate]];
    //if(_searchBar.text.length == 0) filteredDatasMutableArray = [NSMutableArray arrayWithArray:datasArray];
    
    filteredDatasMutableArray = [NSMutableArray arrayWithArray:[filteredDatasMutableArray sortedArrayUsingDescriptors:sortDescriptorsArray]];
    
    [_searchTableView reloadData];
}

// TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filteredDatasMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = filteredDatasMutableArray[indexPath.row][@"abbreviation"];
    cell.detailTextLabel.text = filteredDatasMutableArray[indexPath.row][@"decoded_text"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [_searchTableView indexPathForSelectedRow];
        detailViewController.selectedData = filteredDatasMutableArray[indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
