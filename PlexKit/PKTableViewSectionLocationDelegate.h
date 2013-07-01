// PKTableViewSectionLocationDelegate.h
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

#import <Foundation/Foundation.h>

/**
 * Defines the different locations a row can be in.
 */
typedef enum PKTableViewSectionLocation
{
    COTableViewSectionLocationTop = 0, /** Row is at the top of its section. */
    COTableViewSectionLocationMiddle, /** Row is at the middle of its section. */
    COTableViewSectionLocationBottom, /** Row is at the bottom of its section. */
    COTableViewSectionLocationSingle /** Row is the only one in its section. */
} PKTableViewSectionLocation;

/**
 * Implement this protocol to declare that you'd like to receive the section location message.
 *
 * Use this protocol in a UITableViewCell subclass or a UIView subclass that you've set as a
 * background view for a UITableViewCell.
 */
@protocol PKTableViewSectionLocationSupport

- (void)setRowLocationInSection:(PKTableViewSectionLocation)sectionLocation;

@end

/**
 * A implementation of UITableViewDelegate, which enables cells to know their own location in their section.
 *
 * Sends the "setRowLocationInSection:" message to all UITableViewCell's and their background views, which
 * implemented the PKTableViewSectionLocationSupport protocol.
 */
@interface PKTableViewSectionLocationDelegate : NSObject <UITableViewDelegate>

/**
 * Subdelegate, which will receive all UITableViewDelegate messages.
 */
@property (nonatomic, weak) id<UITableViewDelegate> delegate;

/**
 * Creates a PKTableViewSectionLocationDelegate with the specified subdelegate.
 *
 * @param delegate Subdelegate, which will receive all UITableViewDelegate messages.
 * @return PKTableViewSectionLocationDelegate with the specified subdelegate.
 */
+ (id)sectionLocationDelegateWithDelegate:(id<UITableViewDelegate>)delegate;

/**
 * Initializes the delegate with a subdelegate, which all UITableViewDelegate messages will
 * be forwarded too.
 *
 * @param delegate Subdelegate, which will receive all UITableViewDelegate messages.
 * @return PKTableViewSectionLocationDelegate with the specified subdelegate.
 */
- (id)initWithDelegate:(id<UITableViewDelegate>)delegate;

/**
 * Refreshes all cell locations in the table view.
 * Call this if you inserted or deleted rows from the table view.
 *
 * @param tableView Table view, which should be refreshed.
 */
- (void)refreshSectionLocationsInTableView:(UITableView*)tableView;

@end