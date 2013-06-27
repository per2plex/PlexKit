// PKTableViewSectionLocationDelegate.m
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

#import "PKTableViewSectionLocationDelegate.h"

@implementation PKTableViewSectionLocationDelegate
{
    __weak id<UITableViewDelegate> m_delegate;
    UITableViewCell* m_currentCellBeingReordered;
}

@synthesize delegate = m_delegate;

+ (id)sectionLocationDelegateWithDelegate:(id <UITableViewDelegate>)delegate
{
    return [[PKTableViewSectionLocationDelegate alloc] initWithDelegate:delegate];
}

- (id)initWithDelegate:(id <UITableViewDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        m_delegate = delegate;
    }
    return self;
}


- (NSIndexPath*)tableView:(UITableView*)tableView
    targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath*)sourceIndexPath
    toProposedIndexPath:(NSIndexPath*)proposedDestinationIndexPath
{
    if ([m_delegate respondsToSelector:
        @selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
    {
        proposedDestinationIndexPath =
            [m_delegate tableView:tableView
                targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath
                toProposedIndexPath:proposedDestinationIndexPath];
    }

    UITableViewCell* currentCell = [tableView cellForRowAtIndexPath:sourceIndexPath];

    if (!m_currentCellBeingReordered || (currentCell && m_currentCellBeingReordered != currentCell))
    {
        m_currentCellBeingReordered = currentCell;
    }

    NSMutableArray* array = [[tableView visibleCells] mutableCopy];

    // cell goes out of view
    if (m_currentCellBeingReordered && [array indexOfObject:m_currentCellBeingReordered] == NSNotFound)
    {
        m_currentCellBeingReordered.backgroundColor = [UIColor purpleColor];
        [array addObject:m_currentCellBeingReordered];
    }


    for (UITableViewCell* cell in array)
    {
        NSIndexPath* indexPath = [tableView indexPathForCell:cell];
        NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];

        if ((indexPath.row == sourceIndexPath.row
            && indexPath.section == sourceIndexPath.section) || cell == m_currentCellBeingReordered)
        {
            indexPath = proposedDestinationIndexPath;
        }
        else
        {
            if (sourceIndexPath.section == indexPath.section ||
                proposedDestinationIndexPath.section == indexPath.section)
            {
                NSInteger sourceRow;
                NSInteger targetRow;

                if (sourceIndexPath.section < indexPath.section)
                {
                    sourceRow = -1;
                    targetRow = proposedDestinationIndexPath.row;

                    indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
                }
                else if (sourceIndexPath.section > indexPath.section)
                {
                    sourceRow = [tableView numberOfRowsInSection:indexPath.section] + 1;
                    targetRow = proposedDestinationIndexPath.row;
                }
                else
                {
                    sourceRow = sourceIndexPath.row;

                    if (proposedDestinationIndexPath.section == sourceIndexPath.section)
                    {
                        targetRow = proposedDestinationIndexPath.row;
                    }
                    else if (proposedDestinationIndexPath.section > sourceIndexPath.section)
                    {
                        targetRow = [tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
                    }
                    else if (proposedDestinationIndexPath.section < sourceIndexPath.section)
                    {
                        targetRow = -1;
                        indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                    }
                }


                if ((sourceRow == -1 && targetRow == -1 && indexPath.row == 0) ||
                    (indexPath.row < sourceRow
                        && indexPath.row >= targetRow))
                {
                    indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
                }
                else if ((sourceRow == [tableView numberOfRowsInSection:proposedDestinationIndexPath.section] &&
                    targetRow == [tableView numberOfRowsInSection:proposedDestinationIndexPath.section] && indexPath.row == [tableView numberOfRowsInSection:proposedDestinationIndexPath.section] - 1) ||
                    (indexPath.row > sourceRow
                        && indexPath.row <= targetRow))
                {
                    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
            }

        }

        if (indexPath)
        {
            NSInteger minus = 0;

            if (sourceIndexPath.section == indexPath.section &&
                proposedDestinationIndexPath.section != indexPath.section)
            {
                minus = 1;
            }
            else if (sourceIndexPath.section != indexPath.section &&
                proposedDestinationIndexPath.section == indexPath.section)
            {
                minus = -1;
            }

            if ([tableView numberOfRowsInSection:indexPath.section] - minus == 1)
            {
                [self setSectionLocation:COTableViewSectionLocationSingle onCell:cell];
            }
            else if (indexPath.row == 0)
            {
                [self setSectionLocation:COTableViewSectionLocationTop onCell:cell];
            }
            else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1 - minus)
            {
                [self setSectionLocation:COTableViewSectionLocationBottom onCell:cell];
            }
            else
            {
                [self setSectionLocation:COTableViewSectionLocationCenter onCell:cell];
            }
        }
    }

    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    m_currentCellBeingReordered = nil;
}

- (void)tableView:(UITableView*)tableView
    willDisplayCell:(UITableViewCell*)cell
    forRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];

    if (numberOfRows == 1)
    {
        [self setSectionLocation:COTableViewSectionLocationSingle onCell:cell];

    }
    else if (indexPath.row == 0)
    {
        [self setSectionLocation:COTableViewSectionLocationTop onCell:cell];
    }
    else if (indexPath.row == numberOfRows - 1)
    {
        [self setSectionLocation:COTableViewSectionLocationBottom onCell:cell];
    }
    else
    {
        [self setSectionLocation:COTableViewSectionLocationCenter onCell:cell];
    }

    if ([m_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [m_delegate tableView:tableView
            willDisplayCell:cell
            forRowAtIndexPath:indexPath];
    }
}

- (void)setSectionLocation:(PKTableViewSectionLocation)sectionLocation onCell:(UITableViewCell*)cell
{
    if ([cell conformsToProtocol:@protocol(PKTableViewSectionLocationSupport)])
    {
        id<PKTableViewSectionLocationSupport> supportedCell = (id<PKTableViewSectionLocationSupport>)cell;
        [supportedCell setRowLocationInSection:sectionLocation];
    }

    if ([cell.backgroundView conformsToProtocol:@protocol(PKTableViewSectionLocationSupport)])
    {
        id<PKTableViewSectionLocationSupport> supportedBackgroundView = (id<PKTableViewSectionLocationSupport>)cell.backgroundView;
        [supportedBackgroundView setRowLocationInSection:sectionLocation];
    }

    if ([cell.selectedBackgroundView conformsToProtocol:@protocol(PKTableViewSectionLocationSupport)])
    {
        id<PKTableViewSectionLocationSupport> supportedBackgroundView = (id<PKTableViewSectionLocationSupport>)cell.selectedBackgroundView;
        [supportedBackgroundView setRowLocationInSection:sectionLocation];
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([m_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [m_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end