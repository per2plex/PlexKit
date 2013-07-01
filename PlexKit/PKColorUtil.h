// PKColorUtil.h
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
#import <UIKit/UIKit.h>

#import "PlexKitDefines.h"

/**
 * Returns a randomly generated UIColor.
 *
 * @return Randomly generated UIColor.
 */
PLEX_KIT_EXPORT UIColor* PKRandomColor();

/**
 * Returns a UIColor with the specified hexadecimal RGB color,
 * e.g. 0xFFFFFF for a white color.
 *
 * @return UIColor with the specified hexadecimal RGB color
 */
PLEX_KIT_EXPORT UIColor* PKColorWithHexRgb(int hexValue);

/**
 * Returns a UIColor with the specified hexadecimal RGBA color,
 * e.g. 0xFFFFFF7F for a white color with 50% transparency.
 *
 * @return UIColor with the specified hexadecimal RGBA color
 */
PLEX_KIT_EXPORT UIColor* PKColorWithHexRgba(int hexValue);