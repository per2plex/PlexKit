// PKSectionLocationDemoViewController.m
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

#import "PKSectionLocationDemoViewController.h"
#import "PKSectionLocationDemoBackground.h"
#import <PlexKit/PlexKit.h>

typedef enum EditingMode
{
    EditingModeDelete = 0,
    EditingModeInsert,
    EditingModeNone
} EditingMode;

static const NSInteger NumberOfSections = 5;

@implementation PKSectionLocationDemoViewController
{
    PKTableViewSectionLocationDelegate* m_sectionLocationDelegate;

    NSInteger m_totalCells;
    NSMutableArray* m_sections;

    EditingMode m_currentEditingMode;

    UISegmentedControl* m_editingModeControl;
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_sections = [[NSMutableArray alloc] initWithCapacity:NumberOfSections];
        m_totalCells = 0;
        m_currentEditingMode = EditingModeDelete;

        m_editingModeControl = [[UISegmentedControl alloc] initWithItems:@[@"Delete", @"Insert", @"None"]];

        m_editingModeControl.selectedSegmentIndex = 0;
        m_editingModeControl.segmentedControlStyle = UISegmentedControlStyleBar;
        m_editingModeControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [m_editingModeControl addTarget:self
                                 action:@selector(editingModeChanged:)
                       forControlEvents:UIControlEventValueChanged];

        UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];

        self.toolbarItems = @[flexibleSpace,
                              [[UIBarButtonItem alloc] initWithCustomView:m_editingModeControl],
                              flexibleSpace];

        for (NSInteger i = 0; i < NumberOfSections; ++i)
        {
            NSUInteger rowCount = 3 + (NSUInteger)round(PKRandom() * 3);
            NSMutableArray* rows = [[NSMutableArray alloc] initWithCapacity:rowCount];

            for (NSInteger j = 0; j < rowCount; ++j)
            {
                [rows addObject:[NSString stringWithFormat:@"#%i", m_totalCells]];
                ++m_totalCells;
            }

            [m_sections addObject:rows];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    m_editingModeControl.frame = CGRectMake(0,
                                            0,
                                            self.navigationController.toolbar.bounds.size.width - 50.0f,
                                            m_editingModeControl.bounds.size.height);

    [self.navigationController setToolbarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)editingModeChanged:(id)sender
{
    EditingMode oldEditingMode = m_currentEditingMode;
    m_currentEditingMode = (EditingMode)m_editingModeControl.selectedSegmentIndex;

    if (oldEditingMode != EditingModeNone &&
        m_currentEditingMode == EditingModeNone)
    {
        [self.tableView setEditing:NO animated:YES];
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
    }

    if (oldEditingMode != EditingModeNone)
    {
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    switch (m_currentEditingMode)
    {
        default:
        case EditingModeDelete:
            return UITableViewCellEditingStyleDelete;

        case EditingModeInsert:
            return UITableViewCellEditingStyleInsert;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    m_sectionLocationDelegate = [[PKTableViewSectionLocationDelegate alloc] initWithDelegate:self];

    self.tableView.editing = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = m_sectionLocationDelegate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return NumberOfSections;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_sections[(NSUInteger)section] count];
}

- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section #%i", section];
}

- (void) tableView:(UITableView*)tableView
    moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath
           toIndexPath:(NSIndexPath*)destinationIndexPath
{
    NSMutableArray* sourceSection = m_sections[(NSUInteger)sourceIndexPath.section];
    NSMutableArray* destinationSection = m_sections[(NSUInteger)destinationIndexPath.section];

    NSString* cellNumber = sourceSection[(NSUInteger)sourceIndexPath.row];

    [sourceSection removeObjectAtIndex:(NSUInteger)sourceIndexPath.row];
    [destinationSection insertObject:cellNumber atIndex:(NSUInteger)destinationIndexPath.row];
}

- (void) tableView:(UITableView*)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath*)indexPath
{
    switch (editingStyle)
    {
        case UITableViewCellEditingStyleNone:
            break;

        case UITableViewCellEditingStyleDelete:
        {
            NSMutableArray* section = m_sections[(NSUInteger)indexPath.section];
            [section removeObjectAtIndex:(NSUInteger)indexPath.row];

            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            [m_sectionLocationDelegate refreshSectionLocationsInTableView:tableView];
            break;
        }

        case UITableViewCellEditingStyleInsert:
        {
            NSMutableArray* section = m_sections[(NSUInteger)indexPath.section];
            NSString* cellNumber = [NSString stringWithFormat:@"#%i", m_totalCells++];

            [section insertObject:cellNumber atIndex:(NSUInteger)indexPath.row];
            [tableView insertRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];

            [m_sectionLocationDelegate refreshSectionLocationsInTableView:tableView];
            break;
        }
    }
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* const CellIdentifier = @"CellIdentifier";

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];

        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[PKSectionLocationDemoBackground alloc] init];
    }

    NSString* numberString = m_sections[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    cell.textLabel.text = [@"Move or delete me! " stringByAppendingString:numberString];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"%@", indexPath);
}

@end