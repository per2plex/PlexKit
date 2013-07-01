// PKDemoListViewController.m
//
// Copyright (c) 2013 Till Hagger (http://owesome.ch/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "PKDemoListViewController.h"
#import "PKSectionLocationDemoViewController.h"


typedef enum Section
{
    SectionView = 0,
    // SectionUtility,
    SectionCount
} Section;

typedef enum UtilitySectionRow
{
    UtilitySectionRowCount,
} UtilitySectionRow;

typedef enum ViewSectionRow
{
    ViewSectionRowSectionLocationDelegate = 0,
    ViewSectionRowCount,
} ViewSectionRow;

@interface PKDemoListViewController ()

@end

@implementation PKDemoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"PlexKit Demo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 60.0f;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return SectionCount;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case SectionView:
            return ViewSectionRowCount;

        default:
            return 0;
    }
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case SectionView:
            return @"View";

        default:
            return nil;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* const CellIdentifier = @"CellIdentifier";

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.minimumFontSize = 10.0f;

        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0f];
    }

    switch (indexPath.section)
    {
        case SectionView:
            switch (indexPath.row)
            {
                case ViewSectionRowSectionLocationDelegate:
                    cell.textLabel.text = @"PKTableViewSectionLocationDelegate";
                    cell.detailTextLabel.text =
                            @"UITableViewDelegate which enables cells to know their own location in their section.";
                    break;

                default:break;
            }
            break;

        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section)
    {
        case SectionView:
            switch (indexPath.row)
            {
                case ViewSectionRowSectionLocationDelegate:
                {
                    PKSectionLocationDemoViewController* viewController =
                            [[PKSectionLocationDemoViewController alloc] initWithStyle:UITableViewStyleGrouped];

                    [self.navigationController pushViewController:viewController
                                                         animated:YES];
                    break;
                }

                default:break;
            }
            break;

        default:
            break;
    }
}

@end
